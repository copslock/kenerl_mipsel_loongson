Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K2xAN01523
	for linux-mips-outgoing; Tue, 19 Feb 2002 18:59:10 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K2x2901518
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 18:59:02 -0800
Message-Id: <200202200259.g1K2x2901518@oss.sgi.com>
Received: (qmail 1554 invoked from network); 20 Feb 2002 02:02:00 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 20 Feb 2002 02:02:00 -0000
Date: Wed, 20 Feb 2002 9:56:28 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Hartvig Ekner <hartvige@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Your problem #2
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====_Dragon277531244025_====="
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

--=====_Dragon277531244025_=====
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

hi,
  My way is to extract code from glibc source,math code is=
 related independent
so it is not so hard.
 
  But anyway for your convenience i have adapted a little program=
 for you.
gcc t-expf.c -lm
gcc -O2 t-expf.c -lm
should give different output.


=D4=DA 2002-02-19 22:09:00 you wrote=A3=BA
>Hi Zhang,
>
>I have verified your problem #3 to exist on the SDE compiler as=
 well,
>and it has been reported.
>
>Regarding your problem #2, do you have a self-contained example
>(similar to your small program in #3) which exhibits the error?=
 I don't
>want to spend time installing glibc and dealing with getting=
 that compile
>to run in order to check whether this issue also exists on SDE.
>
>(This is similar to my request on sample failing code for=
 problem #1 you
>reported).
>
>/Hartvig

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

--=====_Dragon277531244025_=====
Content-Type: application/octet-stream; name="t-expf.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="t-expf.c"

I2luY2x1ZGUgPG1hdGguaD4KI2luY2x1ZGUgPGZlbnYuaD4KCnZvaWQgcHJpbnRfcm91bmQoKQp7
CglpbnQgcjsKCglyPWZlZ2V0cm91bmQoKTsKCWlmIChyPT1GRV9UT05FQVJFU1QpIHsKCQlwcmlu
dGYoInJvdW5kaW5nIGlzIFRPTkVBUkVTVFxuIik7IAoJfWVsc2UgaWYgKHI9PUZFX0RPV05XQVJE
KSB7CgkJcHJpbnRmKCJyb3VuZGluZyBpcyBET1dOV0FSRFxuIik7IAoJfWVsc2UgaWYgKHI9PUZF
X1VQV0FSRCkgewoJCXByaW50Zigicm91bmRpbmcgaXMgVVBXQVJEXG4iKTsgCgl9ZWxzZSB7CgkJ
cHJpbnRmKCJyb3VuZGluZyBpcyBUT1dBUkRaRVJPXG4iKTsgCgl9Cn0KCnZvaWQgcHJpbnRfZXhj
ZXB0aW9uKCkKewoJcHJpbnRmKCJmbGFnczoiKTsKCWlmIChmZXRlc3RleGNlcHQoRkVfSU5WQUxJ
RCkpIHByaW50ZigiaSIpOwoJaWYgKGZldGVzdGV4Y2VwdChGRV9ESVZCWVpFUk8pKSBwcmludGYo
IjAiKTsKCWlmIChmZXRlc3RleGNlcHQoRkVfT1ZFUkZMT1cpKSBwcmludGYoIk8iKTsKCWlmIChm
ZXRlc3RleGNlcHQoRkVfVU5ERVJGTE9XKSkgcHJpbnRmKCJVIik7CglpZiAoZmV0ZXN0ZXhjZXB0
KEZFX0lORVhBQ1QpKSBwcmludGYoIlgiKTsKCXByaW50ZigiXG4iKTsKfQoKc3RhdGljIGNvbnN0
IGZsb2F0Cm9fdGhyZXNob2xkPSAgOC44NzIxNjc5Njg4ZSswMSwgIC8qIDB4NDJiMTcxODAgKi8K
dV90aHJlc2hvbGQ9IC0xLjAzOTcyMDg0MDVlKzAyOyAgLyogMHhjMmNmZjFiNSAqLwoKZmxvYXQg
bXlleHBmKGZsb2F0IHgpCnsKCWZsb2F0IHo7Cgl1bnNpZ25lZCBpbnQgaHg7CglpZiAoX0xJQl9W
RVJTSU9OID09IF9JRUVFXykgcmV0dXJuIHo7CglpZihmaW5pdGVmKHgpKSB7CgkgICAgaWYoeD5v
X3RocmVzaG9sZCkKCQlyZXR1cm4gMS4wOwoJICAgIGVsc2UgaWYoeDx1X3RocmVzaG9sZCkKCQly
ZXR1cm4gMi4wOwoJfSAKfQoKaW50IG1haW4oaW50IGFyZ2MsY2hhciAqKmFyZ3YpCnsKCWZsb2F0
IHgsemVybz0wLjA7CgoJeCA9IHplcm8vemVybzsKCWZlY2xlYXJleGNlcHQoRkVfQUxMX0VYQ0VQ
VCk7CglwcmludF9leGNlcHRpb24oKTsKCXggPSBteWV4cGYoeCk7CglwcmludF9leGNlcHRpb24o
KTsKCXJldHVybiAwOwp9Cgo=

--=====_Dragon277531244025_=====--
