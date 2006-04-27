Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 13:36:58 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.205]:52278 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133511AbWD0Mgs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Apr 2006 13:36:48 +0100
Received: by nz-out-0102.google.com with SMTP id j2so1531605nzf
        for <linux-mips@linux-mips.org>; Thu, 27 Apr 2006 05:36:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=jCRTZZjgrOoGXscZyRh+8yrjfH6a0UaGMRvG5HYgqn2aDXJ4BOE9gh08XwmtPwzVkQq4sixf8rLvJrqH2HtpjCJTh8EELc/BsKjhqGE2iQkhpbj3srGZ8STGEl3qxQ0zHvbCE/XsCFpm9NZR6GDMWe33eMr2lw+tiPY5ep4BYL0=
Received: by 10.36.118.9 with SMTP id q9mr1909343nzc;
        Thu, 27 Apr 2006 05:36:43 -0700 (PDT)
Received: by 10.36.49.4 with HTTP; Thu, 27 Apr 2006 05:36:43 -0700 (PDT)
Message-ID: <f07e6e0604270536s5282351fi87e18f55d8a384f7@mail.gmail.com>
Date:	Thu, 27 Apr 2006 18:06:43 +0530
From:	"Kishore K" <hellokishore@gmail.com>
To:	"Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
Subject: Re: Crosstools for MALTA MIPS in little endian
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Nigel Stephens" <nigel@mips.com>
In-Reply-To: <3857255c0604270332p333c182ft3022b5d851178582@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3933_9772259.1146141403317"
References: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
	 <4448F638.9060502@mips.com>
	 <3857255c0604260145i65356e12w89c6667756cddd3c@mail.gmail.com>
	 <20060426221254.GA21670@linux-mips.org>
	 <20060426221823.GC21670@linux-mips.org>
	 <f07e6e0604262259x3cc0893ch8a64b6cc41c34e9b@mail.gmail.com>
	 <3857255c0604270332p333c182ft3022b5d851178582@mail.gmail.com>
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_3933_9772259.1146141403317
Content-Type: multipart/alternative; 
	boundary="----=_Part_3934_26975547.1146141403317"

------=_Part_3934_26975547.1146141403317
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 4/27/06, Shyamal Sadanshio <shyamal.sadanshio@gmail.com> wrote:
>
> Hello Kishore,
>
> Following the history of "problem with MALTA thread", you had
> mentioned that you will try with 2.16 binutils. Have you tried with
> 2.16 version?


Yes. but without success.

Regarding 2.6.12 kernel version, it is put under stable MALTA git
> repository so most likely it could have been validated for MALTA
> platform.


I was using tar balls from linux-mips, rather than from MALTA git
repository.

Regarding pci.c file of 2.6.10 version, Can you please pass me that
> file so I will just try directly in my 2.6.12 kernel and see if it
> works?


Please find the file (arch/mips/mips-boards/generic/pci.c) enclosed along
with this mail.

--kishore

------=_Part_3934_26975547.1146141403317
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br>
<div><span class=3D"gmail_quote">On 4/27/06, <b class=3D"gmail_sendername">=
Shyamal Sadanshio</b> &lt;<a href=3D"mailto:shyamal.sadanshio@gmail.com">sh=
yamal.sadanshio@gmail.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hello Kishore,<br><br>Following =
the history of &quot;problem with MALTA thread&quot;, you had<br>mentioned =
that you will try with=20
2.16 binutils. Have you tried with<br>2.16 version?</blockquote>
<div>&nbsp;</div>
<div>Yes. but without success.</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Regarding 2.6.12 kernel version,=
 it is put under stable MALTA git<br>repository so most likely it could hav=
e been validated for MALTA
<br>platform.</blockquote>
<div>&nbsp;</div>
<div>I was using tar balls from linux-mips, rather than from MALTA git repo=
sitory.</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Regarding pci.c file of 2.6.10 v=
ersion, Can you please pass me that<br>file so I will just try directly in =
my=20
2.6.12 kernel and see if it<br>works?</blockquote>
<div>&nbsp;</div>
<div>Please find the file (arch/mips/mips-boards/generic/pci.c)&nbsp;enclos=
ed along with this mail.</div>
<div>&nbsp;</div>
<div>--kishore</div>
<div>&nbsp;</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&nbsp;</blockquote></div>

------=_Part_3934_26975547.1146141403317--

------=_Part_3933_9772259.1146141403317
Content-Type: text/plain; name="pci.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pci.c"
X-Attachment-Id: f_emj2zkwk

LyoKICogQ2Fyc3RlbiBMYW5nZ2FhcmQsIGNhcnN0ZW5sQG1pcHMuY29tCiAqIENvcHlyaWdodCAo
QykgMTk5OSwgMjAwMCBNSVBTIFRlY2hub2xvZ2llcywgSW5jLiAgQWxsIHJpZ2h0cyByZXNlcnZl
ZC4KICoKICogQ29weXJpZ2h0IChDKSAyMDA0IGJ5IFJhbGYgQmFlY2hsZSAocmFsZkBsaW51eC1t
aXBzLm9yZykKICoKICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIGRp
c3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeSBpdAogKiAgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAoVmVyc2lvbiAyKSBhcwogKiAgcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCiAqCiAqICBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCBXSVRIT1VUCiAqICBB
TlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiBNRVJDSEFO
VEFCSUxJVFkgb3IKICogIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQogKiAgZm9yIG1vcmUgZGV0YWlscy4KICoKICog
IFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlIGFsb25nCiAqICB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLAogKiAgNTkgVGVtcGxlIFBsYWNlIC0g
U3VpdGUgMzMwLCBCb3N0b24gTUEgMDIxMTEtMTMwNywgVVNBLgogKgogKiBNSVBTIGJvYXJkcyBz
cGVjaWZpYyBQQ0kgc3VwcG9ydC4KICovCiNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+CiNpbmNsdWRlIDxsaW51eC9wY2kuaD4KI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPgojaW5jbHVkZSA8bGludXgvaW5pdC5oPgoKI2luY2x1ZGUgPGFzbS9taXBzLWJv
YXJkcy9nZW5lcmljLmg+CiNpbmNsdWRlIDxhc20vZ3Q2NDEyMC5oPgojaW5jbHVkZSA8YXNtL21p
cHMtYm9hcmRzL2Jvbml0bzY0Lmg+CiNpbmNsdWRlIDxhc20vbWlwcy1ib2FyZHMvbXNjMDFfcGNp
Lmg+CiNpZmRlZiBDT05GSUdfTUlQU19NQUxUQQojaW5jbHVkZSA8YXNtL21pcHMtYm9hcmRzL21h
bHRhLmg+CiNlbmRpZgoKc3RhdGljIHN0cnVjdCByZXNvdXJjZSBib25pdG82NF9tZW1fcmVzb3Vy
Y2UgPSB7CgkubmFtZQk9ICJCb25pdG8gUENJIE1FTSIsCgkuc3RhcnQJPSAweDEwMDAwMDAwVUws
CgkuZW5kCT0gMHgxYmZmZmZmZlVMLAoJLmZsYWdzCT0gSU9SRVNPVVJDRV9NRU0sCn07CgpzdGF0
aWMgc3RydWN0IHJlc291cmNlIGJvbml0bzY0X2lvX3Jlc291cmNlID0gewoJLm5hbWUJPSAiQm9u
aXRvIElPIE1FTSIsCgkuc3RhcnQJPSAweDAwMDAyMDAwVUwsCS8qIGF2b2lkIGNvbmZsaWN0cyB3
aXRoIFlBTU9OIGFsbG9jYXRlZCBJL08gYWRkcmVzc2VzICovCgkuZW5kCT0gMHgwMDBmZmZmZlVM
LAoJLmZsYWdzCT0gSU9SRVNPVVJDRV9JTywKfTsKCnN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgZ3Q2
NDEyMF9tZW1fcmVzb3VyY2UgPSB7CgkubmFtZQk9ICJHVDY0MTIwIFBDSSBNRU0iLAoJLnN0YXJ0
CT0gMHgxMDAwMDAwMFVMLAoJLmVuZAk9IDB4MWJkZmZmZmZVTCwKCS5mbGFncwk9IElPUkVTT1VS
Q0VfTUVNLAp9OwoKc3RhdGljIHN0cnVjdCByZXNvdXJjZSBndDY0MTIwX2lvX3Jlc291cmNlID0g
ewoJLm5hbWUJPSAiR1Q2NDEyMCBJTyBNRU0iLAojaWZkZWYgQ09ORklHX01JUFNfQVRMQVMKCS5z
dGFydAk9IDB4MTgwMDAwMDBVTCwKCS5lbmQJPSAweDE4MWZmZmZmVUwsCiNlbmRpZgojaWZkZWYg
Q09ORklHX01JUFNfTUFMVEEKCS5zdGFydAk9IDB4MDAwMDIwMDBVTCwKCS5lbmQJPSAweDAwMWZm
ZmZmVUwsCiNlbmRpZgoJLmZsYWdzCT0gSU9SRVNPVVJDRV9JTywKfTsKCnN0YXRpYyBzdHJ1Y3Qg
cmVzb3VyY2UgbXNjX21lbV9yZXNvdXJjZSA9IHsKCS5uYW1lCT0gIk1TQyBQQ0kgTUVNIiwKCS5z
dGFydAk9IDB4MTAwMDAwMDBVTCwKCS5lbmQJPSAweDFmZmZmZmZmVUwsCgkuZmxhZ3MJPSBJT1JF
U09VUkNFX01FTSwKfTsKCnN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgbXNjX2lvX3Jlc291cmNlID0g
ewoJLm5hbWUJPSAiTVNDIElPIE1FTSIsCgkuc3RhcnQJPSAweDAwMDAyMDAwVUwsCgkuZW5kCT0g
MHgwMDdmZmZmZlVMLAoJLmZsYWdzCT0gSU9SRVNPVVJDRV9JTywKfTsKCmV4dGVybiBzdHJ1Y3Qg
cGNpX29wcyBib25pdG82NF9wY2lfb3BzOwpleHRlcm4gc3RydWN0IHBjaV9vcHMgZ3Q2NDEyMF9w
Y2lfb3BzOwpleHRlcm4gc3RydWN0IHBjaV9vcHMgbXNjX3BjaV9vcHM7CgpzdGF0aWMgc3RydWN0
IHBjaV9jb250cm9sbGVyIGJvbml0bzY0X2NvbnRyb2xsZXIgPSB7CgkucGNpX29wcwk9ICZib25p
dG82NF9wY2lfb3BzLAoJLmlvX3Jlc291cmNlCT0gJmJvbml0bzY0X2lvX3Jlc291cmNlLAoJLm1l
bV9yZXNvdXJjZQk9ICZib25pdG82NF9tZW1fcmVzb3VyY2UsCgkubWVtX29mZnNldAk9IDB4MTAw
MDAwMDBVTCwKCS5pb19vZmZzZXQJPSAweDAwMDAwMDAwVUwsCn07CgpzdGF0aWMgc3RydWN0IHBj
aV9jb250cm9sbGVyIGd0NjQxMjBfY29udHJvbGxlciA9IHsKCS5wY2lfb3BzCT0gJmd0NjQxMjBf
cGNpX29wcywKCS5pb19yZXNvdXJjZQk9ICZndDY0MTIwX2lvX3Jlc291cmNlLAoJLm1lbV9yZXNv
dXJjZQk9ICZndDY0MTIwX21lbV9yZXNvdXJjZSwKCS5tZW1fb2Zmc2V0CT0gMHgwMDAwMDAwMFVM
LAoJLmlvX29mZnNldAk9IDB4MDAwMDAwMDBVTCwKfTsKCnN0YXRpYyBzdHJ1Y3QgcGNpX2NvbnRy
b2xsZXIgIG1zY19jb250cm9sbGVyID0gewoJLnBjaV9vcHMJPSAmbXNjX3BjaV9vcHMsCgkuaW9f
cmVzb3VyY2UJPSAmbXNjX2lvX3Jlc291cmNlLAoJLm1lbV9yZXNvdXJjZQk9ICZtc2NfbWVtX3Jl
c291cmNlLAoJLm1lbV9vZmZzZXQJPSAweDEwMDAwMDAwVUwsCgkuaW9fb2Zmc2V0CT0gMHgwMDAw
MDAwMFVMLAp9OwoKdm9pZCBfX2luaXQgbWlwc19wY2liaW9zX2luaXQodm9pZCkKewoJc3RydWN0
IHBjaV9jb250cm9sbGVyICpjb250cm9sbGVyOwoKCXN3aXRjaCAobWlwc19yZXZpc2lvbl9jb3Jp
ZCkgewoJY2FzZSBNSVBTX1JFVklTSU9OX0NPUklEX1FFRF9STTUyNjE6CgljYXNlIE1JUFNfUkVW
SVNJT05fQ09SSURfQ09SRV9MVjoKCWNhc2UgTUlQU19SRVZJU0lPTl9DT1JJRF9DT1JFX0ZQR0E6
CgljYXNlIE1JUFNfUkVWSVNJT05fQ09SSURfQ09SRV9GUEdBUjI6CgkJLyoKCQkgKiBEdWUgdG8g
YSBidWcgaW4gdGhlIEdhbGlsZW8gc3lzdGVtIGNvbnRyb2xsZXIsIHdlIG5lZWQKCQkgKiB0byBz
ZXR1cCB0aGUgUENJIEJBUiBmb3IgdGhlIEdhbGlsZW8gaW50ZXJuYWwgcmVnaXN0ZXJzLgoJCSAq
IFRoaXMgc2hvdWxkIGJlIGRvbmUgaW4gdGhlIGJpb3MvYm9vdHByb20gYW5kIHdpbGwgYmUKCQkg
KiBmaXhlZCBpbiBhIGxhdGVyIHJldmlzaW9uIG9mIFlBTU9OICh0aGUgTUlQUyBib2FyZHMKCQkg
KiBib290IHByb20pLgoJCSAqLwoJCUdUX1dSSVRFKEdUX1BDSTBfQ0ZHQUREUl9PRlMsCgkJCSAo
MCA8PCBHVF9QQ0kwX0NGR0FERFJfQlVTTlVNX1NIRikgfCAvKiBMb2NhbCBidXMgKi8KCQkJICgw
IDw8IEdUX1BDSTBfQ0ZHQUREUl9ERVZOVU1fU0hGKSB8IC8qIEdUNjQxMjAgZGV2ICovCgkJCSAo
MCA8PCBHVF9QQ0kwX0NGR0FERFJfRlVOQ1ROVU1fU0hGKSB8IC8qIEZ1bmN0aW9uIDAqLwoJCQkg
KCgweDIwLzQpIDw8IEdUX1BDSTBfQ0ZHQUREUl9SRUdOVU1fU0hGKSB8IC8qIEJBUiA0Ki8KCQkJ
IEdUX1BDSTBfQ0ZHQUREUl9DT05GSUdFTl9CSVQgKTsKCgkJLyogUGVyZm9ybSB0aGUgd3JpdGUg
Ki8KCQlHVF9XUklURShHVF9QQ0kwX0NGR0RBVEFfT0ZTLCBDUEhZU0FERFIoTUlQU19HVF9CQVNF
KSk7CgoJCWNvbnRyb2xsZXIgPSAmZ3Q2NDEyMF9jb250cm9sbGVyOwoJCWJyZWFrOwoKCWNhc2Ug
TUlQU19SRVZJU0lPTl9DT1JJRF9CT05JVE82NDoKCWNhc2UgTUlQU19SRVZJU0lPTl9DT1JJRF9D
T1JFXzIwSzoKCWNhc2UgTUlQU19SRVZJU0lPTl9DT1JJRF9DT1JFX0VNVUxfQk9OOgoJCWNvbnRy
b2xsZXIgPSAmYm9uaXRvNjRfY29udHJvbGxlcjsKCQlicmVhazsKCgljYXNlIE1JUFNfUkVWSVNJ
T05fQ09SSURfQ09SRV9NU0M6CgljYXNlIE1JUFNfUkVWSVNJT05fQ09SSURfQ09SRV9GUEdBMjoK
CWNhc2UgTUlQU19SRVZJU0lPTl9DT1JJRF9DT1JFX0VNVUxfTVNDOgoJCWNvbnRyb2xsZXIgPSAm
bXNjX2NvbnRyb2xsZXI7CgkJYnJlYWs7CglkZWZhdWx0OgoJCXJldHVybiA7Cgl9CgoJaW9wb3J0
X3Jlc291cmNlLmVuZCA9IGNvbnRyb2xsZXItPmlvX3Jlc291cmNlLT5lbmQ7CgoJcmVnaXN0ZXJf
cGNpX2NvbnRyb2xsZXIgKGNvbnRyb2xsZXIpOwoKCXJldHVybiA7Cn0KCmVhcmx5X2luaXRjYWxs
KHBjaWJpb3NfaW5pdCk7Cg==
------=_Part_3933_9772259.1146141403317--
