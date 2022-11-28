REM Step-1: Create Root Certificates
makecert.exe ^
-n "CN=CARoot" ^
-r ^
-pe ^
-a sha512 ^
-len 4096 ^
-cy authority ^
-sv 1CARoot.pvk ^
2CARoot.cer

REM Step-2: Convert the root pvk and cer to pfx
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\pvk2pfx.exe" ^
-pvk 1CARoot.pvk ^
-spc 2CARoot.cer ^
-pfx 3CARoot.pfx ^
-po Test1234

REM Step-3: Create Server Certificates
makecert.exe ^
-n "CN=yourdomain.com" ^
-iv 1CARoot.pvk ^
-ic 2CARoot.cer ^
-pe ^
-a sha512 ^
-len 4096 ^
-b 01/01/2022 ^
-e 01/01/2042 ^
-sky exchange ^
-eku 1.3.6.1.5.5.7.3.1 ^
-sv 4ServerSSL.pvk ^
5ServerSSL.cer

REM Step-4: Convert the Server pvk and cer to pfx
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\pvk2pfx.exe" ^
-pvk 4ServerSSL.pvk ^
-spc 5ServerSSL.cer ^
-pfx 6ServerSSL.pfx ^
-po Test1234

REM Step-5: Create Client Certificates
makecert.exe ^
-n "CN=ClientCert" ^
-iv 1CARoot.pvk ^
-ic 2CARoot.cer ^
-pe ^
-a sha512 ^
-len 4096 ^
-b 01/01/2022 ^
-e 01/01/2042 ^
-sky exchange ^
-eku 1.3.6.1.5.5.7.3.2 ^
-sv 7ClientCert.pvk ^
8ClientCert.cer

REM Step-6: Convert Client pvk and cer to pfx
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\pvk2pfx.exe" ^
-pvk 7ClientCert.pvk ^
-spc 8ClientCert.cer ^
-pfx 9ClientCert.pfx ^
-po Test1234
