Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1J3NvI04850
	for linux-mips-outgoing; Mon, 18 Feb 2002 19:23:57 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1J3Ne904847
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 19:23:40 -0800
Message-Id: <200202190323.g1J3Ne904847@oss.sgi.com>
Received: (qmail 29502 invoked from network); 19 Feb 2002 02:26:24 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 19 Feb 2002 02:26:24 -0000
Date: Tue, 19 Feb 2002 10:20:37 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
CC: "libc-alpha@sources.redhat.com" <libc-alpha@sources.redhat.com>
Subject: endless loop in remainder() on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====_Dragon655117627178_====="
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

--=====_Dragon655117627178_=====
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit

hi,
  for this testcase,remaider() will enter an endless loop:
rounding is TONEAREST
x=(7fefffff,ffffffff),y=(00000000,00000001)

attached is a little program to test it(gcc t-remainder.c -lm)
most important part is listed here:

while (l>0) {
    ...
printf("u=(%08lx,%08lx),d=(%08lx,%08lx),w=(%08lx,%08lx)\n",u.i[1],u.i[0],tmp2.i[1],tmp2.i[0],w.i[1],w.i[0]); 
    tmp1.x = d*w.x;
	tmp2.x = u.x - tmp1.x; 
	u.x=(u.x-d*w.x)/*-d*ww.x*/;
printf("d*w=(%08lx,%08lx),u.x-d*w=(%08lx,%08lx),u=(%08lx,%08lx)\n",tmp1.i[1],tmp1.i[0],tmp2.i[1],tmp2.i[0],u.i[1],u.i[0]); 
	l=(u.i[HIGH_HALF]&0x7ff00000)-nn;
}
It is weird enough for me that u doesn't equal to tmp2,that is where x86 and mips differ. 

the output from my P4:
rounding is TONEAREST
x=(7fefffff,ffffffff),y=(00000000,00000001)
x=(7fefffff,ffffffff),y=(04d00000,00000000)
1/y=7b100000,00000000
n=04d00000,nn=06100000,ww=(00000000,00000000),w=(04d00000,00000000),l=79d00000
u=(7fefffff,ffffffff),d=(41400000,00000000),w=(7ea00000,00000000)
d*w=(7ff00000,00000000),u.x-d*w=(fff00000,00000000),u=(fca00000,00000000) <--notice this
u=(fca00000,00000000),d=(c1300000,00000000),w=(7b600000,00000000)
d*w=(fca00000,00000000),u.x-d*w=(00000000,00000000),u=(00000000,00000000)
x=(00000000,00000000),y=(04d00000,00000000)

output from mipsel:
rounding is TONEAREST
x=(7fefffff,ffffffff),y=(00000000,00000001)
x=(7fefffff,ffffffff),y=(04d00000,00000000)
1/y=7b100000,00000000
n=04d00000,nn=06100000,ww=(00000000,00000000),w=(04d00000,00000000),l=79d00000
u=(7fefffff,ffffffff),d=(41400000,00000000),w=(7ea00000,00000000)
d*w=(7ff00000,00000000),u.x-d*w=(fff00000,00000000),u=(fff00000,00000000) <--notice this
u=(fff00000,00000000),d=(fff00000,00000000),w=(7eb00000,00000000)
d*w=(fff00000,00000000),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
u=(7ff7ffff,ffffffff),d=(7ff7ffff,ffffffff),w=(7eb00000,00000000)
d*w=(7ff7ffff,ffffffff),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
u=(7ff7ffff,ffffffff),d=(7ff7ffff,ffffffff),w=(7eb00000,00000000)
d*w=(7ff7ffff,ffffffff),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
u=(7ff7ffff,ffffffff),d=(7ff7ffff,ffffffff),w=(7eb00000,00000000)
d*w=(7ff7ffff,ffffffff),u.x-d*w=(7ff7ffff,ffffffff),u=(7ff7ffff,ffffffff)
...

Thank you.


Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

--=====_Dragon655117627178_=====
Content-Type: application/octet-stream; name="t-remainder.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="t-remainder.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxtYXRoLmg+CiNpbmNsdWRlIDxmZW52Lmg+CiNp
bmNsdWRlIDxlbmRpYW4uaD4KCnR5cGVkZWYgaW50IGludDQ7CnR5cGVkZWYgdW5pb24ge2ludDQg
aVsyXTsgZG91YmxlIHg7fSBteW51bWJlcjsKCiNkZWZpbmUgQUJTKHgpICAgKCgoeCk+MCk/KHgp
Oi0oeCkpCiNkZWZpbmUgbWF4KHgseSkgICgoKHkpPih4KSk/KHkpOih4KSkKI2RlZmluZSBtaW4o
eCx5KSAgKCgoeSk8KHgpKT8oeSk6KHgpKQoKI2RlZmluZSBISUdIX0hBTEYgMQojZGVmaW5lIExP
V19IQUxGIDAKI2RlZmluZSBMSVRUTEVfRU5ESQoKc3RhdGljIGNvbnN0IG15bnVtYmVyIGJpZyA9
IHt7MCwgMHg0MzM4MDAwMH19LCAgLyogNjc1NTM5OTQ0MTA1NTc0NCAqLwogICAgICAgICAgICAg
ICAgICAgICB0MTI4ID0ge3swLCAweDQ3ZjAwMDAwfX0sICAvKiAgMl4gMTI4ICAgICAgICAgICov
CiAgICAgICAgICAgICAgICAgICAgdG0xMjggPSB7ezAsIDB4MzdmMDAwMDB9fSwgIC8qICAyXi0x
MjggICAgICAgICAgKi8KICAgICAgICAgICAgICAgICAgICAgIFpFUk8gPSB7ezAsIDB9fSwgICAg
ICAgICAgLyogIDAuMCAgICAgICAgICAgICAqLwogICAgICAgICAgICAgICAgICAgICBuWkVSTyA9
IHt7MCwgMHg4MDAwMDAwMH19LCAvKiAtMC4wICAgICAgICAgICAgICovCiAgICAgICAgICAgICAg
ICAgICAgICAgTkFOID0ge3swLCAweDdmZjgwMDAwfX0sIC8qICBOYU4gICAgICAgICAgICAgKi8K
ICAgICAgICAgICAgICAgICAgICAgIG5OQU4gPSB7ezAsIDB4ZmZmODAwMDB9fTsgLyogLU5hTiAg
ICAgICAgICAgICAqLwoKZG91YmxlIHVyZW1haW5kZXIoZG91YmxlICwgZG91YmxlICk7CgovKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCi8qIEFuIHVsdGltYXRlIHJlbWFpbmRlciByb3V0aW5lLiBHaXZlbiB0
d28gSUVFRSBkb3VibGUgbWFjaGluZSBudW1iZXJzIHggKi8KLyogLHkgICBpdCBjb21wdXRlcyB0
aGUgY29ycmVjdGx5IHJvdW5kZWQgKHRvIG5lYXJlc3QpIHZhbHVlIG9mIHJlbWFpbmRlciAqLwov
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKiovCmRvdWJsZSBteV9yZW1haW5kZXIoZG91YmxlIHgsIGRvdWJsZSB5
KQp7CiAgZG91YmxlIHosZCx4eDsKI2lmIDAKICBkb3VibGUgeXk7CiNlbmRpZgogIGludDQga3gs
a3ksbixubixuMSxtMSxsOwojaWYgMAogIGludDQgbTsKI2VuZGlmCiAgbXludW1iZXIgdSx0LHc9
e3swLDB9fSx2PXt7MCwwfX0sd3c9e3swLDB9fSxyLHRtcDEsdG1wMjsKICB1Lng9eDsKICB0Lng9
eTsKICBreD11LmlbSElHSF9IQUxGXSYweDdmZmZmZmZmOyAvKiBubyBzaWduICBmb3IgeCovCiAg
dC5pW0hJR0hfSEFMRl0mPTB4N2ZmZmZmZmY7ICAgLypubyBzaWduIGZvciB5ICovCiAga3k9dC5p
W0hJR0hfSEFMRl07CiAgcHJpbnRmKCJ4PSglMDhseCwlMDhseCkseT0oJTA4bHgsJTA4bHgpXG4i
LHUuaVsxXSx1LmlbMF0sdC5pWzFdLHQuaVswXSk7CiAgLyotLS0tLS0gfHh8IDwgMl4xMDI0ICBh
bmQgICAyXi05NzAgPCB8eXwgPCAyXjEwMjQgLS0tLS0tLS0tLS0tLS0tLS0tKi8KICBpZiAoa3g8
MHg3ZmYwMDAwMCAmJiBreTwweDdmZjAwMDAwICYmIGt5Pj0weDAzNTAwMDAwKSB7CiAgICBpZiAo
a3grMHgwMDEwMDAwMDxreSkgcmV0dXJuIHg7CiAgICBpZiAoKGt4LTB4MDE1MDAwMDApPGt5KSB7
CiAgICAgIHo9eC90Lng7CiAgICAgIHYuaVtISUdIX0hBTEZdPXQuaVtISUdIX0hBTEZdOwogICAg
ICBkPSh6K2JpZy54KS1iaWcueDsKICAgICAgeHg9KHgtZCp2LngpLWQqKHQueC12LngpOwogICAg
ICBpZiAoZC16IT0wLjUmJmQteiE9LTAuNSkgcmV0dXJuICh4eCE9MCk/eHg6KCh4PjApP1pFUk8u
eDpuWkVSTy54KTsKICAgICAgZWxzZSB7CglpZiAoQUJTKHh4KT4wLjUqdC54KSByZXR1cm4gKHo+
ZCk/eHgtdC54Onh4K3QueDsKCWVsc2UgcmV0dXJuIHh4OwogICAgICB9CiAgICB9ICAgLyogICAg
KGt4PChreSsweDAxNTAwMDAwKSkgICAgICAgICAqLwogICAgZWxzZSAgewogICAgICByLng9MS4w
L3QueDsKICAgICAgcHJpbnRmKCIxL3k9JTA4bHgsJTA4bHhcbiIsci5pWzFdLHIuaVswXSk7CQog
ICAgICBuPXQuaVtISUdIX0hBTEZdOwogICAgICBubj0obiYweDdmZjAwMDAwKSsweDAxNDAwMDAw
OwogICAgICB3LmlbSElHSF9IQUxGXT1uOwogICAgICB3dy54PXQueC13Lng7CiAgICAgIGw9KGt4
LW5uKSYweGZmZjAwMDAwOwogICAgICBuMT13dy5pW0hJR0hfSEFMRl07CiAgICAgIG0xPXIuaVtI
SUdIX0hBTEZdOwogICAgICBwcmludGYoIm49JTA4bHgsbm49JTA4bHgsd3c9KCUwOGx4LCUwOGx4
KSx3PSglMDhseCwlMDhseCksbD0lMDhseFxuIixuLG5uLHd3LmlbMV0sd3cuaVswXSx3LmlbMV0s
dy5pWzBdLGwpOwkKICAgICAgd2hpbGUgKGw+MCkgewoJci5pW0hJR0hfSEFMRl09bTEtbDsKCXo9
dS54KnIueDsKICAgICAgICB0bXAxLnggPSB6OwoJdy5pW0hJR0hfSEFMRl09bitsOwoJd3cuaVtI
SUdIX0hBTEZdPShuMSk/bjErbDpuMTsKCWQ9KHorYmlnLngpLWJpZy54OwogICAgICAgIHRtcDIu
eCA9IGQ7CiAgICAgICAgcHJpbnRmKCJ1PSglMDhseCwlMDhseCksZD0oJTA4bHgsJTA4bHgpLHc9
KCUwOGx4LCUwOGx4KVxuIix1LmlbMV0sdS5pWzBdLHRtcDIuaVsxXSx0bXAyLmlbMF0sdy5pWzFd
LHcuaVswXSk7IAogICAgICAgIHRtcDEueCA9IGQqdy54OwoJdG1wMi54ID0gdS54IC0gdG1wMS54
OyAKCS8vdG1wMS54ID0gdS54LWQqdy54OwoJLy90bXAyLnggPSB0bXAxLnggLSBkKnd3Lng7IAoJ
dS54PSh1LngtZCp3LngpLyotZCp3dy54Ki87CiAgICAgICAgcHJpbnRmKCJkKnc9KCUwOGx4LCUw
OGx4KSx1LngtZCp3PSglMDhseCwlMDhseCksdT0oJTA4bHgsJTA4bHgpXG4iLHRtcDEuaVsxXSx0
bXAxLmlbMF0sdG1wMi5pWzFdLHRtcDIuaVswXSx1LmlbMV0sdS5pWzBdKTsgCglsPSh1LmlbSElH
SF9IQUxGXSYweDdmZjAwMDAwKS1ubjsKCS8vcHJpbnRmKCJ1PSglMDhseCwlMDhseCksej0oJTA4
bHgsJTA4bHgpLHd3PSglMDhseCwlMDhseCksZD0oJTA4bHgsJTA4bHgpLGw9JTA4bHhcbiIsdS5p
WzFdLHUuaVswXSx0bXAxLmlbMV0sdG1wMS5pWzBdLHd3LmlbMV0sd3cuaVswXSx0bXAyLmlbMV0s
dG1wMi5pWzBdLGwpOwogICAgICB9CiAgICAgIHIuaVtISUdIX0hBTEZdPW0xOwogICAgICB3Lmlb
SElHSF9IQUxGXT1uOwogICAgICB3dy5pW0hJR0hfSEFMRl09bjE7CiAgICAgIHo9dS54KnIueDsK
ICAgICAgZD0oeitiaWcueCktYmlnLng7CiAgICAgIHUueD0odS54LWQqdy54KS1kKnd3Lng7CiAg
ICAgIGlmIChBQlModS54KTwwLjUqdC54KSByZXR1cm4gKHUueCE9MCk/dS54OigoeD4wKT9aRVJP
Lng6blpFUk8ueCk7CiAgICAgIGVsc2UKICAgICAgICBpZiAoQUJTKHUueCk+MC41KnQueCkgcmV0
dXJuIChkPnopP3UueCt0Lng6dS54LXQueDsKICAgICAgICBlbHNlCiAgICAgICAge3o9dS54L3Qu
eDsgZD0oeitiaWcueCktYmlnLng7IHJldHVybiAoKHUueC1kKncueCktZCp3dy54KTt9CiAgICB9
CgogIH0gICAvKiAgIChreDwweDdmZjAwMDAwJiZreTwweDdmZjAwMDAwJiZreT49MHgwMzUwMDAw
MCkgICAgICovCiAgZWxzZSB7CiAgICBpZiAoa3g8MHg3ZmYwMDAwMCYma3k8MHg3ZmYwMDAwMCYm
KGt5PjB8fHQuaVtMT1dfSEFMRl0hPTApKSB7CiAgICAgIHk9QUJTKHkpKnQxMjgueDsKICAgICAg
ej1teV9yZW1haW5kZXIoeCx5KSp0MTI4Lng7CiAgICAgIHo9bXlfcmVtYWluZGVyKHoseSkqdG0x
MjgueDsKICAgICAgcmV0dXJuIHo7CiAgICB9CiAgICBlbHNlIHsgLyogaWYgeCBpcyB0b28gYmln
ICovCiAgICAgIGlmIChreCA9PSAweDdmZjAwMDAwICYmIHUuaVtMT1dfSEFMRl0gPT0gMCAmJiB5
ID09IDEuMCkKCXJldHVybiB4IC8geDsKICAgICAgaWYgKGt4Pj0weDdmZjAwMDAwfHwoa3k9PTAm
JnQuaVtMT1dfSEFMRl09PTApfHxreT4weDdmZjAwMDAwfHwKCSAgKGt5PT0weDdmZjAwMDAwJiZ0
LmlbTE9XX0hBTEZdIT0wKSkKCXJldHVybiAodS5pW0hJR0hfSEFMRl0mMHg4MDAwMDAwMCk/bk5B
Ti54Ok5BTi54OwogICAgICBlbHNlIHJldHVybiB4OwogICAgfQogIH0KfQp2b2lkIHByaW50X3Jv
dW5kKCkKewoJaW50IHI7CgoJcj1mZWdldHJvdW5kKCk7CglpZiAocj09RkVfVE9ORUFSRVNUKSB7
CgkJcHJpbnRmKCJyb3VuZGluZyBpcyBUT05FQVJFU1RcbiIpOyAKCX1lbHNlIGlmIChyPT1GRV9E
T1dOV0FSRCkgewoJCXByaW50Zigicm91bmRpbmcgaXMgRE9XTldBUkRcbiIpOyAKCX1lbHNlIGlm
IChyPT1GRV9VUFdBUkQpIHsKCQlwcmludGYoInJvdW5kaW5nIGlzIFVQV0FSRFxuIik7IAoJfWVs
c2UgewoJCXByaW50Zigicm91bmRpbmcgaXMgVE9XQVJEWkVST1xuIik7IAoJfQp9CgoJCQppbnQg
bWFpbihpbnQgYXJnYyxjaGFyICoqYXJndikKewoJbXludW1iZXIgdDsKCWRvdWJsZSB0dCx4eDsK
CglwcmludF9yb3VuZCgpOwoJdC5pWzFdID0gMHgwMDAwMDAwMDsKCXQuaVswXSA9IDB4MDAwMDAw
MDE7Cgl0dCA9IHQueDsKCXQuaVsxXSA9IDB4N2ZlZmZmZmY7Cgl0LmlbMF0gPSAweGZmZmZmZmZm
OwoJeHggPSB0Lng7Cgl4eCA9IG15X3JlbWFpbmRlcih4eCx0dCk7CgoJcmV0dXJuIDA7Cn0K

--=====_Dragon655117627178_=====--
