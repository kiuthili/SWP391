<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="Models.Address" %>
<!DOCTYPE html>
<html lang="vi">


    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./assets/css/popup.css"/>
        <title>Shipping Address</title>
        <style>

            .add {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                z-index: 1000;
                width: 40%;
            }

            .addoverlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }
        </style>
    </head>

    <body style="font-family: Arial, sans-serif; ">
        <%
            String action = "";
            if (request.getParameter("action") != null) {
                action = request.getParameter("action");
                if (action.equalsIgnoreCase("forOrder")) {
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <br>
            <div class="container">
                <div style=" justify-content: space-between; align-items: center;"> 
                    <a class="btn btn-primary" href="order?action=changeAddress">Back to checkout</a>
                    <p style="margin-top: 20px">Please choose other address by setting as default.</p>
                </div>

            <%
                    }
                }
            %>
            <div style="box-shadow: 2px 2px 2px 2px lightgray; border-radius: 10px ; background-color: white; padding: 20px">
                <div class="header"
                     style=" display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; padding-bottom: 20px">
                    <h2>My addresses</h2>
                    <button class="btn btn-add"
                            style="background: red; color: white; padding: 5px 5px; cursor: pointer; border: none;"
                            onclick="openPopup(false)">+ Add address</button>
                </div>

                <h4 style="padding: 15px 0 0 0">Address</h4>

                <div id="addressList">
                    <c:if test="${sessionScope.addressList.isEmpty()}">
                        <br>
                        <h5>There is no shipping address</h5>
                    </c:if>
                    <c:if test="${!sessionScope.addressList.isEmpty()}">
                        <c:forEach items="${sessionScope.addressList}" var="ad">
                            <c:set var="isDefault" value="0" ></c:set>
                                <br>
                                <div class="address"
                                     style="border-bottom: 1px solid #ddd; display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px">
                                    <div>
                                        <p>${ad.getAddressDetails()}</p>
                                    <c:if test="${ad.getIsDefault() == 1}">
                                        <c:set var="isDefault" value="1" ></c:set>
                                            <span class="default" style="color: red; font-weight: bold;">Default</span>
                                    </c:if>
                                </div>
                                <div class="actions" style="display: flex; flex-direction: column;">        
                                    <c:set var="arr" value="${fn: split(ad.getAddressDetails(), ',')}" ></c:set>
                                    <%
                                        Object arrObj = pageContext.getAttribute("arr");

                                        // Kiểm tra nếu không null và chuyển thành mảng String[]
                                        if (arrObj instanceof String[]) {
                                            String[] arr = (String[]) arrObj;

                                            // Xử lý mảng theo thuật toán của bạn
                                            String province = arr[arr.length - 1];
                                            String district = arr[arr.length - 2];
                                            String commune = arr[arr.length - 3];

                                            // Ghép các phần còn lại thành address
                                            String address = "";
                                            for (int i = 0; i < arr.length - 3; i++) {

                                                address += arr[i] + ",";

                                            }
                                            address = address.substring(0, address.length() - 1);

                                            // Trả kết quả lại JSTL
                                            request.setAttribute("province", province);
                                            request.setAttribute("district", district);
                                            request.setAttribute("commune", commune);
                                            request.setAttribute("address", address);
                                        }
                                    %>


                                    <div class="btn1" style="display: flex; flex-direction: row;">
                                        <button class="btn btn-update"
                                                style="color: blue; padding: 5px 5px; cursor: pointer; border: none; margin-left: 5px;"
                                                data-bs-toggle="modal"
                                                data-bs-target="#updateModal"
                                                data-isDefault = "${isDefault}"
                                                data-id = "${ad.getAddressID()}"
                                                data-province="${province}"
                                                data-district="${district}"
                                                data-commune="${commune}"
                                                data-address="${address}"
                                                onclick="openPopupFromButton(this)">Update</button>
                                        <c:if test="${ad.getIsDefault() == 0}">
                                            <%
                                                if (!action.equalsIgnoreCase("") && action.equalsIgnoreCase("forOrder")) {
                                            %>
                                            <a href="DeleteAddress?id=${ad.getAddressID()}&currentAddressPage=forOrder" class="btn btn-delete"
                                               style="color: red; background: none; padding: 5px 5px; cursor: pointer; border: none; margin-left: 5px;">Delete</a>
                                            <input type="type" name="currentAddressPage" value="forOrder" hidden>
                                            <%
                                            } else {

                                            %>
                                            <a href="DeleteAddress?id=${ad.getAddressID()}&currentAddressPage=addressPage" class="btn btn-delete"
                                               style="color: red; background: none; padding: 5px 5px; cursor: pointer; border: none; margin-left: 5px;">Delete</a>
                                            <%                                                }
                                            %>

                                        </c:if>

                                    </div>
                                    <c:if test="${ad.getIsDefault() == 0}">
                                        <form style="padding: 3px" method="POST" action="UpdateAddress?action=setAsDefault&id=${ad.getAddressID()}">
                                            <%
                                                if (!action.equalsIgnoreCase("") && action.equalsIgnoreCase("forOrder")) {
                                            %>
                                            <input type="type" name="currentAddressPage" value="forOrder" hidden>
                                            <%
                                            } else {

                                            %>
                                            <input type="type" name="currentAddressPage" value="addressPage" hidden>
                                            <%                                                }
                                            %>

                                            <button class="btn btn-default" type="submit"
                                                    style="background: #f5f5f5; padding: 5px 5px; cursor: pointer; border: none; margin-left: 5px;"
                                                    >Set as default</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                            <br>
                        </c:forEach>
                    </c:if>

                </div>
            </div>
            <%
                if (request.getParameter("action") != null) {
                    action = request.getParameter("action");
                    if (action.equalsIgnoreCase("forOrder")) {
            %>
        </div>
        <br>
        <!-- Popup Notification (if needed) -->
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
        <div id="cookiesPopup" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 350px; display: flex; flex-direction: column; align-items: center; background-color: #fff; color: #000; text-align: center; border-radius: 20px; padding: 30px 30px 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); z-index: 1000;">
            <button class="close" onclick="closePopup()" style="width: 30px; font-size: 20px; color: #c0c5cb; align-self: flex-end; background-color: transparent; border: none; margin-bottom: 10px; cursor: pointer;">✖</button>
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" alt="success-tick" style="width: 82px; margin-bottom: 15px;" />
            <p style="margin-bottom: 40px; font-size: 18px;">${sessionScope.message}</p>
            <button class="accept" onclick="closePopup()" style="background-color: #28a745; border: none; border-radius: 5px; width: 200px; padding: 14px; font-size: 16px; color: white; box-shadow: 0px 6px 18px -5px rgba(40, 167, 69, 1); cursor: pointer;">OK</button>
        </div>


        <div id="overlay" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;"></div>

        <%
                session.removeAttribute("message");
            }
        %>

        <jsp:include page="footer.jsp"></jsp:include>
        <%
                }
            }
        %>
        <div class="addoverlay" id="addoverlay" onclick=""></div>

        <div class="add" id="add">

            <div class="" style="display: flex; ">
                <h4 class="title" id="popupLabel">Add Address</h4>
            </div>
            <form method="POST" action="AddAddress" id="formAddress">
                <%
                    if (!action.equalsIgnoreCase("") && action.equalsIgnoreCase("forOrder")) {
                %>
                <input type="type" name="currentAddressPage" value="forOrder" hidden>
                <%
                } else {
                %>
                <input type="type" name="currentAddressPage" value="addressPage" hidden>
                <%                                                }
                %>
                <div class="mb-3">
                    <label for="city" class="form-label">Province</label>
                    <select class="form-select form-select-sm mb-3" name="province" id="city" aria-label=".form-select-sm" required>
                        <option value="" selected>Select Province</option>           
                    </select>
                </div>
                <div class="mb-3">
                    <label for="district" class="form-label">District</label>
                    <select class="form-select form-select-sm mb-3"  name="district" id="district" aria-label=".form-select-sm" required>
                        <option value="" selected>Select District</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="ward" class="form-label">Ward</label>
                    <select class="form-select form-select-sm" name="ward" id="ward" aria-label=".form-select-sm" required>
                        <option value="" selected>Select Ward</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Detailed Address:</label>
                    <input type="text" id="addressInput" name="address" class="form-control" required
                           value="">
                    <small id="error-message" class="form-text text-danger"></small>

                </div>
                <% boolean first = false; %>
                <c:if test="${sessionScope.addressList.isEmpty()}">
                    <%  first = true; %>
                    <div class="mb-3 form-check form-switch">
                        <input type="hidden" name="isDefault" value="1">
                        <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" checked disabled>
                        <label class="form-check-label" for="flexSwitchCheckDefault">Set as default</label>
                    </div>
                </c:if>
                <c:if test="${!sessionScope.addressList.isEmpty()}">
                    <div class="mb-3 form-check form-switch">

                        <input class="form-check-input" name="isDefault" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                        <label class="form-check-label" for="flexSwitchCheckDefault" id="defaultSwitch">Set as default</label>
                    </div>
                </c:if>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeAddPopup()"
                            data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger">Save</button>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>

    <script>
                        document.getElementById('formAddress').addEventListener('submit', function (event) {
                            const addressInput = document.getElementById('addressInput');
                            const errorMessage = document.getElementById('error-message');

                            errorMessage.textContent = '';

                            if (addressInput.value.trim().length < 5) {
                                errorMessage.textContent = 'Detailed Address must be at least 5 characters.';
                                errorMessage.style.color = 'red';
                                event.preventDefault();

                                // Ẩn thông báo sau 5 giây
                                setTimeout(() => {
                                    errorMessage.textContent = '';
                                }, 5000);
                            }
                        });


                        function closePopup() {
                            document.getElementById("cookiesPopup").style.display = "none";
                            document.getElementById("overlay").style.display = "none";
                        }
                        var allData = [];
                        var citis = document.getElementById("city");
                        var districts = document.getElementById("district");
                        var wards = document.getElementById("ward");

                        var Parameter = {
                            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                            method: "GET",
                            responseType: "json"
                        };

                        // Đợi API tải xong rồi mới render
                        axios(Parameter)
                                .then(function (result) {
                                    console.log("Dữ liệu API:", result.data); // Debug dữ liệu
                                    allData = result.data;
                                    if (allData.length > 0) {
                                        renderCity(allData);
                                    }
                                })
                                .catch(function (error) {
                                    console.error("Lỗi tải dữ liệu: ", error);
                                });


                        citis.onchange = function () {
                            if (allData.length > 0) {
                                loadDistricts(this.value);
                            }
                        };

                        districts.onchange = function () {
                            if (allData.length > 0) {
                                loadWards(this.value);
                            }
                        };

                        function renderCity(data) {
                            console.log("Render City Data: ", data); // Kiểm tra dữ liệu có vào không
                            for (const x of data) {
                                let translatedName = translateLocation(x.Name);
                                console.log("Thêm tỉnh/thành phố:", translatedName); // Kiểm tra dữ liệu sau khi dịch
                                citis.options[citis.options.length] = new Option(translatedName, translatedName);
                            }
                        }


                        function loadDistricts(cityName) {
                            districts.length = 1;
                            wards.length = 1;
                            if (cityName !== "") {
                                let result = allData.find(n => translateLocation(n.Name) === cityName);
                                for (const k of result.Districts) {
                                    let translatedName = translateLocation(k.Name);
                                    districts.options[districts.options.length] = new Option(translatedName, translatedName);
                                }
                            }
                        }

                        function loadWards(districtName) {
                            wards.length = 1;
                            let cityData = allData.find(n => translateLocation(n.Name) === citis.value);
                            if (cityData && districtName !== "") {
                                let districtData = cityData.Districts.find(n => translateLocation(n.Name) === districtName);
                                for (const w of districtData.Wards) {
                                    let translatedName = translateLocation(w.Name);
                                    wards.options[wards.options.length] = new Option(translatedName, translatedName);
                                }
                            }
                        }

                        function translateLocation(name) {
                            let temp = name;

                            if (temp.includes("Thành phố "))
                                temp = temp.replace("Thành phố ", "") + " City";
                            if (temp.includes("Tỉnh "))
                                temp = temp.replace("Tỉnh ", "") + " Province";
                            if (temp.includes("Huyện "))
                                temp = temp.replace("Huyện ", "") + " District";
                            if (temp.includes("Quận "))
                                temp = temp.replace("Quận ", "") + " District";
                            if (temp.includes("Thị xã "))
                                temp = temp.replace("Thị xã ", "") + " Town";
                            if (temp.includes("Thị trấn "))
                                temp = temp.replace("Thị trấn ", "") + " Town";
                            if (temp.includes("Phường "))
                                temp = temp.replace("Phường ", "") + " Ward";
                            if (temp.includes("Xã "))
                                temp = temp.replace("Xã ", "") + " Commune";

                            return removeDiacritics(temp); // Xóa dấu tiếng Việt
                        }

                        function removeDiacritics(str) {
                            return str.normalize("NFD").replace(/[\u0300-\u036f]/g, ""); // Loại bỏ dấu tiếng Việt
                        }
                        function openPopupFromButton(button) {
                            const isDefault = button.getAttribute("data-isDefault").trim();
                            const id = button.getAttribute("data-id").trim();
                            const province = button.getAttribute("data-province").trim();
                            const district = button.getAttribute("data-district").trim();
                            const commune = button.getAttribute("data-commune").trim();
                            const address = button.getAttribute("data-address").trim();

                            openPopup(true, {isDefault, id, province, district, commune, address});
                        }

                        function openPopup(isUpdate, data = null) {
                            document.getElementById("add").style.display = "block";
                            document.getElementById("addoverlay").style.display = "block";

                            if (isUpdate && data) {
                                document.getElementById("popupLabel").innerHTML = "Update Address";
                                document.getElementById("addressInput").value = data.address || "";
                                const form = document.getElementById("formAddress");
                                if (data.isDefault === "1") {
                                    document.getElementById("flexSwitchCheckDefault").checked = true;
                                    document.getElementById("flexSwitchCheckDefault").disabled = true;
                                } else {
                                    document.getElementById("flexSwitchCheckDefault").checked = false;
                                    document.getElementById("flexSwitchCheckDefault").disabled = false;

                                }

                                if (form && data.id) {
                                    form.action = "UpdateAddress?id=" + data.id.trim();
                                } else {
                                    console.error("Error: formAddress not found or data.id is invalid");
                                }


                                // Chọn tỉnh/thành phố trước, rồi kích hoạt sự kiện change
                                setSelectValue("city", data.province, function () {
                                    document.getElementById("city").dispatchEvent(new Event("change"));

                                    // Chờ quận/huyện load xong rồi chọn
                                    setTimeout(() => {
                                        setSelectValue("district", data.district, function () {
                                            document.getElementById("district").dispatchEvent(new Event("change"));

                                            // Chờ xã/phường load xong rồi chọn
                                            setTimeout(() => {
                                                setSelectValue("ward", data.commune);
                                            }, 200);
                                        });
                                    }, 200);
                                });
                            } else {
                                document.getElementById("popupLabel").innerHTML = "Add Address";
                                document.getElementById("addressInput").value = "";
                                document.getElementById("city").selectedIndex = 0;
                                document.getElementById("district").length = 1;
                                document.getElementById("ward").length = 1;
                        }
                        }

                        function setSelectValue(selectId, value, callback = null) {
                            let select = document.getElementById(selectId);
                            let found = false;

                            for (let i = 0; i < select.options.length; i++) {
                                if (select.options[i].text === value) {
                                    select.selectedIndex = i;
                                    found = true;
                                    break;
                                }
                            }

                            if (!found) {
                                select.selectedIndex = 0;
                            }

                            if (callback) {
                                callback();
                        }
                        }


                        function closeAddPopup() {
                            document.getElementById("add").style.display = "none";
                            document.getElementById("addoverlay").style.display = "none";
                            let selects = document.querySelectorAll("#add select");
                            selects.forEach(select => {
                                select.selectedIndex = 0;
                            });
        <% if (!first) {
        %>
                            document.getElementById("flexSwitchCheckDefault").disabled = false;
                            document.getElementById("flexSwitchCheckDefault").checked = false;
        <%
            }%>



                        }

                        console.log(document.getElementById("city"));
                        console.log(document.getElementById("district"));
                        console.log(document.getElementById("ward"));

    </script>

</body>

</html>