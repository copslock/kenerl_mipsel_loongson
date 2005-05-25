Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2005 16:05:55 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([IPv6:::ffff:203.101.113.39]:55504 "EHLO
	wip-ec-wd.wipro.com") by linux-mips.org with ESMTP
	id <S8225551AbVEYPFh>; Wed, 25 May 2005 16:05:37 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 2845420554
	for <linux-mips@linux-mips.org>; Wed, 25 May 2005 20:26:43 +0530 (IST)
Received: from blr-ec-bh01.wipro.com (unknown [10.201.50.91])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 0FC5D2053D
	for <linux-mips@linux-mips.org>; Wed, 25 May 2005 20:26:43 +0530 (IST)
Received: from chn-snr-bh2.wipro.com ([10.145.50.92]) by blr-ec-bh01.wipro.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 25 May 2005 20:35:27 +0530
Received: from CHN-SNR-MBX01.wipro.com ([10.145.50.181]) by chn-snr-bh2.wipro.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 25 May 2005 20:35:24 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5613B.2E4B5FBD"
Subject: RE: Unable to handle kernel paging request at virtual address 04000460
Date:	Wed, 25 May 2005 20:32:03 +0530
Message-ID: <438662DA48DCAA41B1DF648BD4BD76C0CF6283@CHN-SNR-MBX01.wipro.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to handle kernel paging request at virtual address 04000460
Thread-Index: AcVgd+bKyjXc1BZZTzOXOhBhBJ2c9wAwfS0w
From:	<raghunathan.venkatesan@wipro.com>
To:	<philippedeswert@scarlet.be>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 25 May 2005 15:05:24.0672 (UTC) FILETIME=[2DA59C00:01C5613B]
Return-Path: <raghunathan.venkatesan@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghunathan.venkatesan@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5613B.2E4B5FBD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,
We were able to build the cross ksymoops utility and converted couple of
Oops capture to analyze the dump. All the crashes were pointing to
skbuff issues. When packets are received, the __kfree_skb function is
crashing at some point and when packets are transmitted the
skb_drop_fraglist is crashing at some point.

Please find attached the oops decoded dumps.=20
We would like to know are there any patches that need to be applied for
2.4.26 for it to handle fragmented packets when load is heavy ? We use
flood ping test on linux to get the crashes.

Thanks for your info.
Regards,
Raghu



-----Original Message-----
From: Philippe De Swert [mailto:philippedeswert@scarlet.be]=20
Sent: Tuesday, May 24, 2005 9:17 PM
To: Raghunathan Venkatesan (WT01 - EMBEDDED & PRODUCT ENGINEERING
SOLUTIONS)
Cc: linux-mips
Subject: Re:Unable to handle kernel paging request at virtual address
04000460

Decode this dump with ksymoops

See here:
http://freshmeat.net/projects/ksymoops/

This will help you discover in which function it is dying, on which
offset in your kernel code etc... Very helpful for debugging. (in 2.6
you can even compile something alike in the kernel (kallsyms))


---------- Initial header -----------

> We are facing the following crash in custom Linux 2.4.26 kernel, when=20
> we run a netperf TCP Stream (sizes varying from 64 to 32586 bytes)=20
> test over an IPSEC tunnel created between a host and a VPN server=20
> through our box. This is a Au1550 MIPS32 based board (DB1550 Cabernet=20
> board from AMD). We observe that crash happens randomly (the PrId=20
> keeps changing at each crash), because of burstiness in the netperf=20
> tool generated traffic. Please look into the following capture below.=20
> I'd like some help in debugging this issue. The same set of IPSEC=20
> drivers works fine on a custom Linux 2.4.25 based kernel. Is there a=20
> patch that needs to be applied for Linux 2.4.26 ?
> =20
> Unable to handle kernel paging request at virtual address 04000460,=20
> epc =3D=3D 802501cc, 8Oops in fault.c::do_page_fault, line 206:
>=20
> $0 : 00000000 1000fc00 00000000 00000001 00000000 8b5f61b2 04000460=20
> 00000000
<SNIP> KERNEL DUMP

CHEERS,

Philippe
=20
| Philippe De Swert      =20
|     =20
| Stag developer http://stag.mind.be/
| Emdebian developer: http://www.emdebian.org
|  =20
| Please do not send me documents in a closed=20
| format.(*.doc,*.xls,*.ppt)   =20
| Use the open alternatives. (*.pdf,*.ps,*.html,*.txt)   =20
| http://www.gnu.org/philosophy/no-word-attachments.html

-------------------------------------------------------
NOTE! My email address is changing to ... @scarlet.be Please make the
necessary changes in your address book.=20




------_=_NextPart_001_01C5613B.2E4B5FBD
Content-Type: application/octet-stream;
	name="recent.cap_send1.oops"
Content-Transfer-Encoding: base64
Content-Description: recent.cap_send1.oops
Content-Disposition: attachment;
	filename="recent.cap_send1.oops"

a3N5bW9vcHMgMi40Ljkgb24gaTY4NiAyLjQuMjItMS4yMTE1Lm5wdGwuICBPcHRpb25zIHVzZWQK
ICAgICAtdiAvaG9tZS9hbWQvcHJvamVjdC9hbWQva2VybmVsL3ZtbGludXggKGRlZmF1bHQpCiAg
ICAgLUsgKHNwZWNpZmllZCkKICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQogICAgIC1v
IC9ob21lL2FtZC9wcm9qZWN0L2FtZC9maWxlc3lzdGVtL3Vzci9saWIvbW9kdWxlcy8gKGRlZmF1
bHQpCiAgICAgLW0gL2hvbWUvYW1kL3Byb2plY3QvYW1kL2tlcm5lbC9TeXN0ZW0ubWFwIChkZWZh
dWx0KQogICAgIC10IGVsZjMyLWxpdHRsZW1pcHMgLWEgbWlwczo0NjAwCgpObyBtb2R1bGVzIGlu
IGtzeW1zLCBza2lwcGluZyBvYmplY3RzCk5vIGtzeW1zLCBza2lwcGluZyBsc21vZApVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDIwMDA0
ZDQsIGVwYyA9PSA4MDI0YWY2YywgcmEgPT0gODAyNGIwOTQKT29wcyBpbiBmYXVsdC5jOjpkb19w
YWdlX2ZhdWx0LCBsaW5lIDIwNjoKJDAgOiAwMDAwMDAwMCAxMDAwZmMwMCA4YWJiYjYwMCAwMjAw
MDQ2MCAwMjAwMDQ2MCA4YWJiYjVlYyAwMDAwMDAwMCAwMDAwMDVlYwokOCA6IDVhZDM0MzZlIDhh
YmJiZGVjIGIzZGU1ZDcxIDU2NzM2OTg4IDA3ODNmZGZiIDgwMzIzODU4IDgwMzIzODA0IDI0ZTEy
YWU1CiQxNjogMDIwMDA0NjAgMDAwMDAwMDEgOGFiYmI4MDAgMDAwMDA2MDAgMDAwMDBjZmMgMDAw
MDA1ZGMgMDAwMDAwMTQgMDAwMDM0MDgKJDI0OiAwMDAwMDAwMCAyYWVhM2M3MCAgICAgICAgICAg
ICAgICAgICA4MDMyMjAwMCA4MDMyM2EyOCAwMDAwMzQxYyA4MDI0YjA5NApIaSA6IDAwMDAwMDAw
CkxvIDogMDAwMDA4MDAKZXBjICAgOiA4MDI0YWY2YyAgICBOb3QgdGFpbnRlZApTdGF0dXM6IDEw
MDBmYzAzCkNhdXNlIDogMDA4MDAwMDgKUHJvY2VzcyBzd2FwcGVyIChwaWQ6IDAsIHN0YWNrcGFn
ZT04MDMyMjAwMCkKU3RhY2s6ICAgIDhiOTYyNDgwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwODAwIDhiNmFmNDYwIDgwMjRiMDk0CiA4YjZhZjQ2MCA4YWJiYjgwMCAwMDAwMDYwMCAw
MDAwMGNmYyAwMDAwMDVkYyAwMDAwMDgwMCA4YjZhZjQ2MCA4MDI0YjdjYwogODAyNGI3YjAgMjRl
MTJhZTUgODAzMjM4NTggODAzMjM4MDQgYzAxYzIwNTAgOGI2YWY0NjAgODAzYTA0MDAgMDAwMDA1
YzgKIDgxMmJlMzAwIDgwMjUwMWQ0IDAwMDAwNWRjIDAwMDAwMDE0IDAwMDAyZTQwIDAwMDAwMDAw
IDJhZWEzYzcwIDhiNmFmNDYwCiA4YWVhMTE2MCAwMDAwMDVjOCA4MDI2YTllOCAwMDAwMmU1NCA4
MDI2YTE4NCAxMDAwZmMwMyAwMDAwMDAwMCA4YjZhZjQ2MAogOGFiYmIwMTAgLi4uCkNhbGwgVHJh
Y2U6ICAgWzw4MDI0YjA5ND5dIFs8ODAyNGI3Y2M+XSBbPDgwMjRiN2IwPl0gWzw4MDI1MDFkND5d
IFs8ODAyNmE5ZTg+XQogWzw4MDI2YTE4ND5dIFs8ODAyNmEzMGM+XSBbPDgwMjZhMWRjPl0gWzw4
MDI2YTkwYz5dIFs8ODAyNmE5MGM+XSBbPDgwMjljNDE4Pl0KIFs8ODAyNmE5MGM+XSBbPDgwMjZh
OTBjPl0gWzw4MDI1YTQ4ND5dIFs8ODAyNmE5MGM+XSBbPDgwMjZhOTBjPl0gWzw4MDI1YTk0OD5d
CiBbPDgwMmRhMGUwPl0gWzw4MDI2YTkwYz5dIFs8ODAyNmE4ZDQ+XSBbPDgwMjZhOTBjPl0gWzw4
MDI2YTMwYz5dIFs8ODAyNmExODQ+XQogWzw4MDI2NzEzMD5dIFs8ODAyNjcxYjA+XSBbPDgwMjZh
NzQ0Pl0gWzw4MDI1YTk4Yz5dIFs8ODAyOWVkODg+XSBbPDgwMjY3MTMwPl0KIFs8ODAyOWZkMzQ+
XSBbPDgwMjY3MDZjPl0gWzw4MDI2NzEzMD5dIFs8ODAyNjU3Zjg+XSBbPDgwMjY1YTIwPl0gWzw4
MDI1YTQ4ND5dCiBbPGMwMWNlMmE4Pl0gWzw4MDI2NTdmOD5dIFs8ODAyNjU3Zjg+XSBbPDgwMjVh
OThjPl0gWzw4MDI1YTk0OD5dIC4uLgpXYXJuaW5nIChPb3BzX3RyYWNlX2xpbmUpOiBnYXJiYWdl
ICcuLi4nIGF0IGVuZCBvZiB0cmFjZSBsaW5lIGlnbm9yZWQKQ29kZTogOGM1MDAwMDggIGFjNDAw
MDA4ICAwMjAwMjAyMSA8OGM4MjAwNzQ+IDEwNTEwMDA5ICA4ZTEwMDAwMCAgYzA4MzAwNzQgIDAw
NzExMDIzICBlMDgyMDA3NAoKCj4+UkE7ICAwMDAwMDAwMDgwMjRiMDk0IDxza2JfcmVsZWFzZV9k
YXRhK2IwL2JjPgo+PiQxMzsgMDAwMDAwMDA4MDMyMzg1OCA8aW5pdF90YXNrX3VuaW9uKzE4NTgv
MjAwMD4KPj4kMTQ7IDAwMDAwMDAwODAzMjM4MDQgPGluaXRfdGFza191bmlvbisxODA0LzIwMDA+
Cj4+JDI4OyAwMDAwMDAwMDgwMzIyMDAwIDxpbml0X3Rhc2tfdW5pb24rMC8yMDAwPgo+PiQyOTsg
MDAwMDAwMDA4MDMyM2EyOCA8aW5pdF90YXNrX3VuaW9uKzFhMjgvMjAwMD4KPj4kMzE7IDAwMDAw
MDAwODAyNGIwOTQgPHNrYl9yZWxlYXNlX2RhdGErYjAvYmM+Cgo+PlBDOyAgMDAwMDAwMDA4MDI0
YWY2YyA8c2tiX2Ryb3BfZnJhZ2xpc3QrMzQvNzQ+ICAgPD09PT09CgpUcmFjZTsgMDAwMDAwMDA4
MDI0YjA5NCA8c2tiX3JlbGVhc2VfZGF0YStiMC9iYz4KVHJhY2U7IDAwMDAwMDAwODAyNGI3Y2Mg
PHNrYl9saW5lYXJpemUrYzQvMTRjPgpUcmFjZTsgMDAwMDAwMDA4MDI0YjdiMCA8c2tiX2xpbmVh
cml6ZSthOC8xNGM+ClRyYWNlOyAwMDAwMDAwMDgwMjUwMWQ0IDxkZXZfcXVldWVfeG1pdCs1MC8z
Yjg+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOWU4IDxpcF9maW5pc2hfb3V0cHV0MitlYy8xNTA+ClRy
YWNlOyAwMDAwMDAwMDgwMjZhMTg0IDxpcF9mcmFnbWVudCsyNDAvNTAwPgpUcmFjZTsgMDAwMDAw
MDA4MDI2YTMwYyA8aXBfZnJhZ21lbnQrM2M4LzUwMD4KVHJhY2U7IDAwMDAwMDAwODAyNmExZGMg
PGlwX2ZyYWdtZW50KzI5OC81MDA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hf
b3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0cHV0
MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjljNDE4IDxpcF9yZWZyYWcrNjgvNzQ+ClRyYWNl
OyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAw
MDAwMDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgw
MjVhNDg0IDxuZl9pdGVyYXRlKzk0LzExND4KVHJhY2U7IDAwMDAwMDAwODAyNmE5MGMgPGlwX2Zp
bmlzaF9vdXRwdXQyKzEwLzE1MD4KVHJhY2U7IDAwMDAwMDAwODAyNmE5MGMgPGlwX2ZpbmlzaF9v
dXRwdXQyKzEwLzE1MD4KVHJhY2U7IDAwMDAwMDAwODAyNWE5NDggPG5mX2hvb2tfc2xvdysxMjgv
MWY4PgpUcmFjZTsgMDAwMDAwMDA4MDJkYTBlMCA8bWVtc2V0KzAvMWM+ClRyYWNlOyAwMDAwMDAw
MDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZh
OGQ0IDxpcF9maW5pc2hfb3V0cHV0KzFhMC8xYTQ+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxp
cF9maW5pc2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhMzBjIDxpcF9mcmFn
bWVudCszYzgvNTAwPgpUcmFjZTsgMDAwMDAwMDA4MDI2YTE4NCA8aXBfZnJhZ21lbnQrMjQwLzUw
MD4KVHJhY2U7IDAwMDAwMDAwODAyNjcxMzAgPGlwX2ZvcndhcmRfZmluaXNoKzEwL2EwPgpUcmFj
ZTsgMDAwMDAwMDA4MDI2NzFiMCA8aXBfZm9yd2FyZF9maW5pc2grOTAvYTA+ClRyYWNlOyAwMDAw
MDAwMDgwMjZhNzQ0IDxpcF9maW5pc2hfb3V0cHV0KzEwLzFhND4KVHJhY2U7IDAwMDAwMDAwODAy
NWE5OGMgPG5mX2hvb2tfc2xvdysxNmMvMWY4PgpUcmFjZTsgMDAwMDAwMDA4MDI5ZWQ4OCA8aXBf
Y3RfcmVmcmVzaCs4NC9iOD4KVHJhY2U7IDAwMDAwMDAwODAyNjcxMzAgPGlwX2ZvcndhcmRfZmlu
aXNoKzEwL2EwPgpUcmFjZTsgMDAwMDAwMDA4MDI5ZmQzNCA8aWNtcF9wYWNrZXQrOTgvOWM+ClRy
YWNlOyAwMDAwMDAwMDgwMjY3MDZjIDxfX2dudV9jb21waWxlZF9jKzI2Yy8zMjA+ClRyYWNlOyAw
MDAwMDAwMDgwMjY3MTMwIDxpcF9mb3J3YXJkX2ZpbmlzaCsxMC9hMD4KVHJhY2U7IDAwMDAwMDAw
ODAyNjU3ZjggPGlwX3Jjdl9maW5pc2grMTAvMmE4PgpUcmFjZTsgMDAwMDAwMDA4MDI2NWEyMCA8
aXBfcmN2X2ZpbmlzaCsyMzgvMmE4PgpUcmFjZTsgMDAwMDAwMDA4MDI1YTQ4NCA8bmZfaXRlcmF0
ZSs5NC8xMTQ+ClRyYWNlOyAwMDAwMDAwMGMwMWNlMmE4IDxFTkRfT0ZfQ09ERSszZmUzYmFhOC8/
Pz8/PgpUcmFjZTsgMDAwMDAwMDA4MDI2NTdmOCA8aXBfcmN2X2ZpbmlzaCsxMC8yYTg+ClRyYWNl
OyAwMDAwMDAwMDgwMjY1N2Y4IDxpcF9yY3ZfZmluaXNoKzEwLzJhOD4KVHJhY2U7IDAwMDAwMDAw
ODAyNWE5OGMgPG5mX2hvb2tfc2xvdysxNmMvMWY4PgpUcmFjZTsgMDAwMDAwMDA4MDI1YTk0OCA8
bmZfaG9va19zbG93KzEyOC8xZjg+CgpDb2RlOyAgMDAwMDAwMDA4MDI0YWY2MCA8c2tiX2Ryb3Bf
ZnJhZ2xpc3QrMjgvNzQ+CjAwMDAwMDAwIDxfUEM+OgpDb2RlOyAgMDAwMDAwMDA4MDI0YWY2MCA8
c2tiX2Ryb3BfZnJhZ2xpc3QrMjgvNzQ+CiAgIDA6ICAgOGM1MDAwMDggIGx3ICAgICAgczAsOCh2
MCkKQ29kZTsgIDAwMDAwMDAwODAyNGFmNjQgPHNrYl9kcm9wX2ZyYWdsaXN0KzJjLzc0PgogICA0
OiAgIGFjNDAwMDA4ICBzdyAgICAgIHplcm8sOCh2MCkKQ29kZTsgIDAwMDAwMDAwODAyNGFmNjgg
PHNrYl9kcm9wX2ZyYWdsaXN0KzMwLzc0PgogICA4OiAgIDAyMDAyMDIxICBtb3ZlICAgIGEwLHMw
CkNvZGU7ICAwMDAwMDAwMDgwMjRhZjZjIDxza2JfZHJvcF9mcmFnbGlzdCszNC83ND4gICA8PT09
PT0KICAgYzogICA4YzgyMDA3NCAgbHcgICAgICB2MCwxMTYoYTApICAgPD09PT09CkNvZGU7ICAw
MDAwMDAwMDgwMjRhZjcwIDxza2JfZHJvcF9mcmFnbGlzdCszOC83ND4KICAxMDogICAxMDUxMDAw
OSAgYmVxICAgICB2MCxzMSwzOCA8X1BDKzB4Mzg+CkNvZGU7ICAwMDAwMDAwMDgwMjRhZjc0IDxz
a2JfZHJvcF9mcmFnbGlzdCszYy83ND4KICAxNDogICA4ZTEwMDAwMCAgbHcgICAgICBzMCwwKHMw
KQpDb2RlOyAgMDAwMDAwMDA4MDI0YWY3OCA8c2tiX2Ryb3BfZnJhZ2xpc3QrNDAvNzQ+CiAgMTg6
ICAgYzA4MzAwNzQgIGxsICAgICAgdjEsMTE2KGEwKQpDb2RlOyAgMDAwMDAwMDA4MDI0YWY3YyA8
c2tiX2Ryb3BfZnJhZ2xpc3QrNDQvNzQ+CiAgMWM6ICAgMDA3MTEwMjMgIHN1YnUgICAgdjAsdjEs
czEKQ29kZTsgIDAwMDAwMDAwODAyNGFmODAgPHNrYl9kcm9wX2ZyYWdsaXN0KzQ4Lzc0PgogIDIw
OiAgIGUwODIwMDc0ICBzYyAgICAgIHYwLDExNihhMCkKCktlcm5lbCBwYW5pYzogQWllZSwga2ls
bGluZyBpbnRlcnJ1cHQgaGFuZGxlciEKCjEgd2FybmluZyBpc3N1ZWQuICBSZXN1bHRzIG1heSBu
b3QgYmUgcmVsaWFibGUuCg==

------_=_NextPart_001_01C5613B.2E4B5FBD
Content-Type: application/octet-stream;
	name="recent.cap.oops"
Content-Transfer-Encoding: base64
Content-Description: recent.cap.oops
Content-Disposition: attachment;
	filename="recent.cap.oops"

a3N5bW9vcHMgMi40Ljkgb24gaTY4NiAyLjQuMjItMS4yMTE1Lm5wdGwuICBPcHRpb25zIHVzZWQK
ICAgICAtdiAvaG9tZS9hbWQvcHJvamVjdC9hbWQva2VybmVsL3ZtbGludXggKGRlZmF1bHQpCiAg
ICAgLUsgKHNwZWNpZmllZCkKICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQogICAgIC1v
IC9ob21lL2FtZC9wcm9qZWN0L2FtZC9maWxlc3lzdGVtL3Vzci9saWIvbW9kdWxlcy8gKGRlZmF1
bHQpCiAgICAgLW0gL2hvbWUvYW1kL3Byb2plY3QvYW1kL2tlcm5lbC9TeXN0ZW0ubWFwIChkZWZh
dWx0KQogICAgIC10IGVsZjMyLWxpdHRsZW1pcHMgLWEgbWlwczo0NjAwCgpObyBtb2R1bGVzIGlu
IGtzeW1zLCBza2lwcGluZyBvYmplY3RzCk5vIGtzeW1zLCBza2lwcGluZyBsc21vZApVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDQwMDA0
NjAsIGVwYyA9PSA4MDI0YjIwYywgcmEgPT0gODAyYzQ5ZjgKT29wcyBpbiBmYXVsdC5jOjpkb19w
YWdlX2ZhdWx0LCBsaW5lIDIwNjoKJDAgOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMSA4Yjc4MzU4MCAwMDAwMDAwMCAwNDAwMDQ2MCAwMDAwMDAwMQokOCA6IDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAyIGQzZDBiMDAwIDgwMzIzYjY4IDAwMDAwMDAwIDgwMzIzZDYwIDdiN2E3
OTc4CiQxNjogODEyYmViMjAgODEyYmViMjAgZmZmZmZmZmYgOGJiMGQ4MDAgODAzYTA4MDQgMDAw
MDAwMDAgMDAwMDAwMDIgODAzMjNlMTAKJDI0OiAwMDAwMDAwMCAyYjAwYWM3MCAgICAgICAgICAg
ICAgICAgICA4MDMyMjAwMCA4MDMyM2FkMCAwMDAwMjQwMSA4MDJjNDlmOApIaSA6IDAwMDAyMDkx
CkxvIDogZDY5MTI4NWUKZXBjICAgOiA4MDI0YjIwYyAgICBOb3QgdGFpbnRlZApTdGF0dXM6IDEw
MDBmYzAzCkNhdXNlIDogMDA4MDAwMDgKUHJvY2VzcyBzd2FwcGVyIChwaWQ6IDAsIHN0YWNrcGFn
ZT04MDMyMjAwMCkKU3RhY2s6ICAgIDAwMDAwMDAwIDhiYjBkODAwIDgwM2EwODA0IDAwMDAwMDAw
IDgxMmJlYjIwIDgwMmM0OWY4IDgwMTA3YzI4CiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCA4
MTJiZWIyMCA4MTI0ZmM2OCA4YjZhZjVhMCA4MDNhMDgwMCAwMDAwMDAwNAogODAyNTAwODggMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgODEyYjY1NjAgODAzYTA4MDAgOGI2YWY1
YTAKIDgwM2EwODAwIDAwMDAwMDAwIDgwMjVjM2UwIDAwMDAwMDAwIDAwMDAwMDAwIDgwMzIzYzE4
IDgwMzY5YmYwIDgwMzRkN2U4CiA4MDNhMDgwMCAwMDAwMDAwMCA4MDI1MDM3YyA4MDI5YzNlYyAw
MDAwMDAwMCA4Yjc4MzU4MCA4YjZhZjVhMCAwMDAwMDAwZQogOGI2YWY1YTAgLi4uCkNhbGwgVHJh
Y2U6ICAgWzw4MDJjNDlmOD5dIFs8ODAxMDdjMjg+XSBbPDgwMjUwMDg4Pl0gWzw4MDI1YzNlMD5d
IFs8ODAyNTAzN2M+XQogWzw4MDI5YzNlYz5dIFs8ODAyNTczYTg+XSBbPDgwMjVhNDg0Pl0gWzw4
MDI2YTkwYz5dIFs8ODAyNmE5ZTg+XSBbPDgwMjZhOTBjPl0KIFs8ODAyNWE5OGM+XSBbPDgwMjVh
OTQ4Pl0gWzw4MDI2YTkwYz5dIFs8ODAyYTNkOTg+XSBbPDgwMjY3MTMwPl0gWzw4MDI2YThkND5d
CiBbPDgwMjZhOTBjPl0gWzw4MDI2NzFjMD5dIFs8ODAyNjcxMzA+XSBbPDgwMjVhOThjPl0gWzw4
MDI5Y2Y1MD5dIFs8ODAyNjcxMzA+XQogWzw4MDI5ZmQwND5dIFs8ODAyNjcwNmM+XSBbPDgwMjY3
MTMwPl0gWzw4MDI2NTdmOD5dIFs8ODAyNjVhMjA+XSBbPDgwMjVhNDg0Pl0KIFs8YzAxY2UyYTg+
XSBbPDgwMjY1N2Y4Pl0gWzw4MDI2NTdmOD5dIFs8ODAyNWE5OGM+XSBbPDgwMjVhOTQ4Pl0gWzw4
MDI2NTdmOD5dCiBbPDgwMjY1NWEwPl0gWzw4MDI2NTdmOD5dIFs8ODAyNTBkNDg+XSBbPDgwMmUw
MWY0Pl0gWzw4MDEwN2MyOD5dIC4uLgpXYXJuaW5nIChPb3BzX3RyYWNlX2xpbmUpOiBnYXJiYWdl
ICcuLi4nIGF0IGVuZCBvZiB0cmFjZSBsaW5lIGlnbm9yZWQKQ29kZTogOGUwNjAwOWMgIDEwYzAw
MDBlICAyNDAzMDAwMSA8OGNjMjAwMDA+IGMwNDUwMDAwICAwMGEzMjAyMyAgZTA0NDAwMDAgIDEw
ODBmZmZjICAwMGEzMjAyMwoKCj4+UkE7ICAwMDAwMDAwMDgwMmM0OWY4IDxwYWNrZXRfcmN2X3Nw
a3QrMjljLzJiMD4KPj4kMTI7IDAwMDAwMDAwODAzMjNiNjggPGluaXRfdGFza191bmlvbisxYjY4
LzIwMDA+Cj4+JDE0OyAwMDAwMDAwMDgwMzIzZDYwIDxpbml0X3Rhc2tfdW5pb24rMWQ2MC8yMDAw
Pgo+PiQyMzsgMDAwMDAwMDA4MDMyM2UxMCA8aW5pdF90YXNrX3VuaW9uKzFlMTAvMjAwMD4KPj4k
Mjg7IDAwMDAwMDAwODAzMjIwMDAgPGluaXRfdGFza191bmlvbiswLzIwMDA+Cj4+JDI5OyAwMDAw
MDAwMDgwMzIzYWQwIDxpbml0X3Rhc2tfdW5pb24rMWFkMC8yMDAwPgo+PiQzMTsgMDAwMDAwMDA4
MDJjNDlmOCA8cGFja2V0X3Jjdl9zcGt0KzI5Yy8yYjA+Cgo+PlBDOyAgMDAwMDAwMDA4MDI0YjIw
YyA8X19rZnJlZV9za2IrYTQvMTMwPiAgIDw9PT09PQoKVHJhY2U7IDAwMDAwMDAwODAyYzQ5Zjgg
PHBhY2tldF9yY3Zfc3BrdCsyOWMvMmIwPgpUcmFjZTsgMDAwMDAwMDA4MDEwN2MyOCA8ZG9fZ2V0
dGltZW9mZGF5KzU4LzExND4KVHJhY2U7IDAwMDAwMDAwODAyNTAwODggPGRldl9xdWV1ZV94bWl0
X25pdCtiYy8xMTA+ClRyYWNlOyAwMDAwMDAwMDgwMjVjM2UwIDxfX2dudV9jb21waWxlZF9jKzcw
LzE0Yz4KVHJhY2U7IDAwMDAwMDAwODAyNTAzN2MgPGRldl9xdWV1ZV94bWl0KzFmOC8zYjg+ClRy
YWNlOyAwMDAwMDAwMDgwMjljM2VjIDxpcF9yZWZyYWcrM2MvNzQ+ClRyYWNlOyAwMDAwMDAwMDgw
MjU3M2E4IDxuZWlnaF9yZXNvbHZlX291dHB1dCsxZmMvMjljPgpUcmFjZTsgMDAwMDAwMDA4MDI1
YTQ4NCA8bmZfaXRlcmF0ZSs5NC8xMTQ+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5p
c2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOWU4IDxpcF9maW5pc2hfb3V0
cHV0MitlYy8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0cHV0Misx
MC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjVhOThjIDxuZl9ob29rX3Nsb3crMTZjLzFmOD4KVHJh
Y2U7IDAwMDAwMDAwODAyNWE5NDggPG5mX2hvb2tfc2xvdysxMjgvMWY4PgpUcmFjZTsgMDAwMDAw
MDA4MDI2YTkwYyA8aXBfZmluaXNoX291dHB1dDIrMTAvMTUwPgpUcmFjZTsgMDAwMDAwMDA4MDJh
M2Q5OCA8aXB0X2xvY2FsX291dF9ob29rKzQvOGM+ClRyYWNlOyAwMDAwMDAwMDgwMjY3MTMwIDxp
cF9mb3J3YXJkX2ZpbmlzaCsxMC9hMD4KVHJhY2U7IDAwMDAwMDAwODAyNmE4ZDQgPGlwX2Zpbmlz
aF9vdXRwdXQrMWEwLzFhND4KVHJhY2U7IDAwMDAwMDAwODAyNmE5MGMgPGlwX2ZpbmlzaF9vdXRw
dXQyKzEwLzE1MD4KVHJhY2U7IDAwMDAwMDAwODAyNjcxYzAgPGlwX29wdGlvbnNfYnVpbGQrMC8w
PgpUcmFjZTsgMDAwMDAwMDA4MDI2NzEzMCA8aXBfZm9yd2FyZF9maW5pc2grMTAvYTA+ClRyYWNl
OyAwMDAwMDAwMDgwMjVhOThjIDxuZl9ob29rX3Nsb3crMTZjLzFmOD4KVHJhY2U7IDAwMDAwMDAw
ODAyOWNmNTAgPGRlYXRoX2J5X3RpbWVvdXQrM2MvYTg+ClRyYWNlOyAwMDAwMDAwMDgwMjY3MTMw
IDxpcF9mb3J3YXJkX2ZpbmlzaCsxMC9hMD4KVHJhY2U7IDAwMDAwMDAwODAyOWZkMDQgPGljbXBf
cGFja2V0KzY4LzljPgpUcmFjZTsgMDAwMDAwMDA4MDI2NzA2YyA8X19nbnVfY29tcGlsZWRfYysy
NmMvMzIwPgpUcmFjZTsgMDAwMDAwMDA4MDI2NzEzMCA8aXBfZm9yd2FyZF9maW5pc2grMTAvYTA+
ClRyYWNlOyAwMDAwMDAwMDgwMjY1N2Y4IDxpcF9yY3ZfZmluaXNoKzEwLzJhOD4KVHJhY2U7IDAw
MDAwMDAwODAyNjVhMjAgPGlwX3Jjdl9maW5pc2grMjM4LzJhOD4KVHJhY2U7IDAwMDAwMDAwODAy
NWE0ODQgPG5mX2l0ZXJhdGUrOTQvMTE0PgpUcmFjZTsgMDAwMDAwMDBjMDFjZTJhOCA8RU5EX09G
X0NPREUrM2ZlM2JhYTgvPz8/Pz4KVHJhY2U7IDAwMDAwMDAwODAyNjU3ZjggPGlwX3Jjdl9maW5p
c2grMTAvMmE4PgpUcmFjZTsgMDAwMDAwMDA4MDI2NTdmOCA8aXBfcmN2X2ZpbmlzaCsxMC8yYTg+
ClRyYWNlOyAwMDAwMDAwMDgwMjVhOThjIDxuZl9ob29rX3Nsb3crMTZjLzFmOD4KVHJhY2U7IDAw
MDAwMDAwODAyNWE5NDggPG5mX2hvb2tfc2xvdysxMjgvMWY4PgpUcmFjZTsgMDAwMDAwMDA4MDI2
NTdmOCA8aXBfcmN2X2ZpbmlzaCsxMC8yYTg+ClRyYWNlOyAwMDAwMDAwMDgwMjY1NWEwIDxpcF9y
Y3YrNTEwLzU3OD4KVHJhY2U7IDAwMDAwMDAwODAyNjU3ZjggPGlwX3Jjdl9maW5pc2grMTAvMmE4
PgpUcmFjZTsgMDAwMDAwMDA4MDI1MGQ0OCA8bmV0aWZfcmVjZWl2ZV9za2IrMjcwLzJjMD4KVHJh
Y2U7IDAwMDAwMDAwODAyZTAxZjQgPGF1MTAwMF9JUlErMTM0LzFhMD4KVHJhY2U7IDAwMDAwMDAw
ODAxMDdjMjggPGRvX2dldHRpbWVvZmRheSs1OC8xMTQ+CgpDb2RlOyAgMDAwMDAwMDA4MDI0YjIw
MCA8X19rZnJlZV9za2IrOTgvMTMwPgowMDAwMDAwMCA8X1BDPjoKQ29kZTsgIDAwMDAwMDAwODAy
NGIyMDAgPF9fa2ZyZWVfc2tiKzk4LzEzMD4KICAgMDogICA4ZTA2MDA5YyAgbHcgICAgICBhMiwx
NTYoczApCkNvZGU7ICAwMDAwMDAwMDgwMjRiMjA0IDxfX2tmcmVlX3NrYis5Yy8xMzA+CiAgIDQ6
ICAgMTBjMDAwMGUgIGJlcXogICAgYTIsNDAgPF9QQysweDQwPgpDb2RlOyAgMDAwMDAwMDA4MDI0
YjIwOCA8X19rZnJlZV9za2IrYTAvMTMwPgogICA4OiAgIDI0MDMwMDAxICBsaSAgICAgIHYxLDEK
Q29kZTsgIDAwMDAwMDAwODAyNGIyMGMgPF9fa2ZyZWVfc2tiK2E0LzEzMD4gICA8PT09PT0KICAg
YzogICA4Y2MyMDAwMCAgbHcgICAgICB2MCwwKGEyKSAgIDw9PT09PQpDb2RlOyAgMDAwMDAwMDA4
MDI0YjIxMCA8X19rZnJlZV9za2IrYTgvMTMwPgogIDEwOiAgIGMwNDUwMDAwICBsbCAgICAgIGEx
LDAodjApCkNvZGU7ICAwMDAwMDAwMDgwMjRiMjE0IDxfX2tmcmVlX3NrYithYy8xMzA+CiAgMTQ6
ICAgMDBhMzIwMjMgIHN1YnUgICAgYTAsYTEsdjEKQ29kZTsgIDAwMDAwMDAwODAyNGIyMTggPF9f
a2ZyZWVfc2tiK2IwLzEzMD4KICAxODogICBlMDQ0MDAwMCAgc2MgICAgICBhMCwwKHYwKQpDb2Rl
OyAgMDAwMDAwMDA4MDI0YjIxYyA8X19rZnJlZV9za2IrYjQvMTMwPgogIDFjOiAgIDEwODBmZmZj
ICBiZXF6ICAgIGEwLDEwIDxfUEMrMHgxMD4KQ29kZTsgIDAwMDAwMDAwODAyNGIyMjAgPF9fa2Zy
ZWVfc2tiK2I4LzEzMD4KICAyMDogICAwMGEzMjAyMyAgc3VidSAgICBhMCxhMSx2MQoKS2VybmVs
IHBhbmljOiBBaWVlLCBraWxsaW5nIGludGVycnVwdCBoYW5kbGVyIQoKMSB3YXJuaW5nIGlzc3Vl
ZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxpYWJsZS4K

------_=_NextPart_001_01C5613B.2E4B5FBD
Content-Type: application/octet-stream;
	name="recent.cap_recv.oops"
Content-Transfer-Encoding: base64
Content-Description: recent.cap_recv.oops
Content-Disposition: attachment;
	filename="recent.cap_recv.oops"

a3N5bW9vcHMgMi40Ljkgb24gaTY4NiAyLjQuMjItMS4yMTE1Lm5wdGwuICBPcHRpb25zIHVzZWQK
ICAgICAtdiAvaG9tZS9hbWQvcHJvamVjdC9hbWQva2VybmVsL3ZtbGludXggKGRlZmF1bHQpCiAg
ICAgLUsgKHNwZWNpZmllZCkKICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQogICAgIC1v
IC9ob21lL2FtZC9wcm9qZWN0L2FtZC9maWxlc3lzdGVtL3Vzci9saWIvbW9kdWxlcy8gKGRlZmF1
bHQpCiAgICAgLW0gL2hvbWUvYW1kL3Byb2plY3QvYW1kL2tlcm5lbC9TeXN0ZW0ubWFwIChkZWZh
dWx0KQogICAgIC10IGVsZjMyLWxpdHRsZW1pcHMgLWEgbWlwczo0NjAwCgpObyBtb2R1bGVzIGlu
IGtzeW1zLCBza2lwcGluZyBvYmplY3RzCk5vIGtzeW1zLCBza2lwcGluZyBsc21vZApVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDMy
NjAsIGVwYyA9PSA4MDI0YjIwYywgcmEgPT0gODAyYzQ5ZjgKT29wcyBpbiBmYXVsdC5jOjpkb19w
YWdlX2ZhdWx0LCBsaW5lIDIwNjoKJDAgOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMSA4Yjc4MDc2MCAwMDAwMDAwMCAwMDAwMzI2MCAwMDAwMDAwMQokOCA6IDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAyIGQzZDBiMDAwIGMwMTE1MDAwIDAwMDAxNGI4IDhiOWJmZDI4IDdiN2E3
OTc4CiQxNjogOGI2YjU0NjAgOGI2YjU0NjAgZmZmZmZmZmYgOGI5MGY4MDAgODAzYTA4MDQgMDAw
MDAwMDAgMDAwMDAwMDIgOGI5YmZkZDgKJDI0OiAwMDAwMDAwMCAyYWNhZDU1MCAgICAgICAgICAg
ICAgICAgICA4YjliZTAwMCA4YjliZmE5OCAwMDAwNDc5ZCA4MDJjNDlmOApIaSA6IDAwMDAyMzYx
CkxvIDogNzY1MGYxMDgKZXBjICAgOiA4MDI0YjIwYyAgICBOb3QgdGFpbnRlZApTdGF0dXM6IDEw
MDBmYzAzCkNhdXNlIDogMDA4MDAwMDgKUHJvY2VzcyB2b3Nsb2cgKHBpZDogMTM0LCBzdGFja3Bh
Z2U9OGI5YmUwMDApClN0YWNrOiAgICAwMDAwMDAwMCA4YjkwZjgwMCA4MDNhMDgwNCAwMDAwMDAw
MCA4YjZiNTQ2MCA4MDJjNDlmOCA4MDEwN2MyOAogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
OGI2YjU0NjAgODEyNGZjNjggODEyYmVkMDAgODAzYTA4MDAgMDAwMDAwMDQKIDgwMjUwMDg4IDAw
MDAwMDAwIDAwMDAwMDAwIDgwMjlkMzgwIDAwMDAwMDAwIDgxMmI2NTYwIDgwM2EwODAwIDgxMmJl
ZDAwCiA4MDNhMDgwMCAwMDAwMDAwMCA4MDI1YzNlMCA4MDI2YTkwYyAwMDAwMDAwMyAwMDAwMDAw
MiA4MDI5YzNhYyA4MDM0ZDdlOAogODAzYTA4MDAgMDAwMDAwMDAgODAyNTAzN2MgODAyOWMzZWMg
MDAwMDAwMDAgOGI3ODA3NjAgODEyYmVkMDAgMDAwMDAwMGUKIDgxMmJlZDAwIC4uLgpDYWxsIFRy
YWNlOiAgIFs8ODAyYzQ5Zjg+XSBbPDgwMTA3YzI4Pl0gWzw4MDI1MDA4OD5dIFs8ODAyOWQzODA+
XSBbPDgwMjVjM2UwPl0KIFs8ODAyNmE5MGM+XSBbPDgwMjljM2FjPl0gWzw4MDI1MDM3Yz5dIFs8
ODAyOWMzZWM+XSBbPDgwMjU3M2E4Pl0gWzw4MDI1YTQ4ND5dCiBbPDgwMjZhOTBjPl0gWzw4MDI2
YTllOD5dIFs8ODAyNmE5MGM+XSBbPDgwMjVhOThjPl0gWzw4MDI1YTk0OD5dIFs8ODAyNmE5MGM+
XQogWzw4MDJhM2Q5OD5dIFs8ODAyNjcxMzA+XSBbPDgwMjZhOGQ0Pl0gWzw4MDI2YTkwYz5dIFs8
ODAyNjcxYzA+XSBbPDgwMjY3MTMwPl0KIFs8ODAyNWE5OGM+XSBbPDgwMjY3MTMwPl0gWzw4MDI5
ZmQzND5dIFs8ODAyNjcwNmM+XSBbPDgwMjY3MTMwPl0gWzw4MDI2NTdmOD5dCiBbPDgwMjY1YTIw
Pl0gWzw4MDI1YTQ4ND5dIFs8YzAxY2UyYTg+XSBbPDgwMjY1N2Y4Pl0gWzw4MDI2NTdmOD5dIFs8
ODAyNWE5OGM+XQogWzw4MDI1YTk0OD5dIFs8ODAyNjU3Zjg+XSBbPDgwMjY1NWEwPl0gWzw4MDI2
NTdmOD5dIFs8ODAxMDEzM2M+XSAuLi4KV2FybmluZyAoT29wc190cmFjZV9saW5lKTogZ2FyYmFn
ZSAnLi4uJyBhdCBlbmQgb2YgdHJhY2UgbGluZSBpZ25vcmVkCkNvZGU6IDhlMDYwMDljICAxMGMw
MDAwZSAgMjQwMzAwMDEgPDhjYzIwMDAwPiBjMDQ1MDAwMCAgMDBhMzIwMjMgIGUwNDQwMDAwICAx
MDgwZmZmYyAgMDBhMzIwMjMKCgo+PlJBOyAgMDAwMDAwMDA4MDJjNDlmOCA8cGFja2V0X3Jjdl9z
cGt0KzI5Yy8yYjA+Cj4+JDMxOyAwMDAwMDAwMDgwMmM0OWY4IDxwYWNrZXRfcmN2X3Nwa3QrMjlj
LzJiMD4KCj4+UEM7ICAwMDAwMDAwMDgwMjRiMjBjIDxfX2tmcmVlX3NrYithNC8xMzA+ICAgPD09
PT09CgpUcmFjZTsgMDAwMDAwMDA4MDJjNDlmOCA8cGFja2V0X3Jjdl9zcGt0KzI5Yy8yYjA+ClRy
YWNlOyAwMDAwMDAwMDgwMTA3YzI4IDxkb19nZXR0aW1lb2ZkYXkrNTgvMTE0PgpUcmFjZTsgMDAw
MDAwMDA4MDI1MDA4OCA8ZGV2X3F1ZXVlX3htaXRfbml0K2JjLzExMD4KVHJhY2U7IDAwMDAwMDAw
ODAyOWQzODAgPF9faXBfY29ubnRyYWNrX2NvbmZpcm0rMjM4LzJjOD4KVHJhY2U7IDAwMDAwMDAw
ODAyNWMzZTAgPF9fZ251X2NvbXBpbGVkX2MrNzAvMTRjPgpUcmFjZTsgMDAwMDAwMDA4MDI2YTkw
YyA8aXBfZmluaXNoX291dHB1dDIrMTAvMTUwPgpUcmFjZTsgMDAwMDAwMDA4MDI5YzNhYyA8aXBf
Y29uZmlybSs0OC80Yz4KVHJhY2U7IDAwMDAwMDAwODAyNTAzN2MgPGRldl9xdWV1ZV94bWl0KzFm
OC8zYjg+ClRyYWNlOyAwMDAwMDAwMDgwMjljM2VjIDxpcF9yZWZyYWcrM2MvNzQ+ClRyYWNlOyAw
MDAwMDAwMDgwMjU3M2E4IDxuZWlnaF9yZXNvbHZlX291dHB1dCsxZmMvMjljPgpUcmFjZTsgMDAw
MDAwMDA4MDI1YTQ4NCA8bmZfaXRlcmF0ZSs5NC8xMTQ+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBj
IDxpcF9maW5pc2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOWU4IDxpcF9m
aW5pc2hfb3V0cHV0MitlYy8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hf
b3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjVhOThjIDxuZl9ob29rX3Nsb3crMTZj
LzFmOD4KVHJhY2U7IDAwMDAwMDAwODAyNWE5NDggPG5mX2hvb2tfc2xvdysxMjgvMWY4PgpUcmFj
ZTsgMDAwMDAwMDA4MDI2YTkwYyA8aXBfZmluaXNoX291dHB1dDIrMTAvMTUwPgpUcmFjZTsgMDAw
MDAwMDA4MDJhM2Q5OCA8aXB0X2xvY2FsX291dF9ob29rKzQvOGM+ClRyYWNlOyAwMDAwMDAwMDgw
MjY3MTMwIDxpcF9mb3J3YXJkX2ZpbmlzaCsxMC9hMD4KVHJhY2U7IDAwMDAwMDAwODAyNmE4ZDQg
PGlwX2ZpbmlzaF9vdXRwdXQrMWEwLzFhND4KVHJhY2U7IDAwMDAwMDAwODAyNmE5MGMgPGlwX2Zp
bmlzaF9vdXRwdXQyKzEwLzE1MD4KVHJhY2U7IDAwMDAwMDAwODAyNjcxYzAgPGlwX29wdGlvbnNf
YnVpbGQrMC8wPgpUcmFjZTsgMDAwMDAwMDA4MDI2NzEzMCA8aXBfZm9yd2FyZF9maW5pc2grMTAv
YTA+ClRyYWNlOyAwMDAwMDAwMDgwMjVhOThjIDxuZl9ob29rX3Nsb3crMTZjLzFmOD4KVHJhY2U7
IDAwMDAwMDAwODAyNjcxMzAgPGlwX2ZvcndhcmRfZmluaXNoKzEwL2EwPgpUcmFjZTsgMDAwMDAw
MDA4MDI5ZmQzNCA8aWNtcF9wYWNrZXQrOTgvOWM+ClRyYWNlOyAwMDAwMDAwMDgwMjY3MDZjIDxf
X2dudV9jb21waWxlZF9jKzI2Yy8zMjA+ClRyYWNlOyAwMDAwMDAwMDgwMjY3MTMwIDxpcF9mb3J3
YXJkX2ZpbmlzaCsxMC9hMD4KVHJhY2U7IDAwMDAwMDAwODAyNjU3ZjggPGlwX3Jjdl9maW5pc2gr
MTAvMmE4PgpUcmFjZTsgMDAwMDAwMDA4MDI2NWEyMCA8aXBfcmN2X2ZpbmlzaCsyMzgvMmE4PgpU
cmFjZTsgMDAwMDAwMDA4MDI1YTQ4NCA8bmZfaXRlcmF0ZSs5NC8xMTQ+ClRyYWNlOyAwMDAwMDAw
MGMwMWNlMmE4IDxFTkRfT0ZfQ09ERSszZmUzYmFhOC8/Pz8/PgpUcmFjZTsgMDAwMDAwMDA4MDI2
NTdmOCA8aXBfcmN2X2ZpbmlzaCsxMC8yYTg+ClRyYWNlOyAwMDAwMDAwMDgwMjY1N2Y4IDxpcF9y
Y3ZfZmluaXNoKzEwLzJhOD4KVHJhY2U7IDAwMDAwMDAwODAyNWE5OGMgPG5mX2hvb2tfc2xvdysx
NmMvMWY4PgpUcmFjZTsgMDAwMDAwMDA4MDI1YTk0OCA8bmZfaG9va19zbG93KzEyOC8xZjg+ClRy
YWNlOyAwMDAwMDAwMDgwMjY1N2Y4IDxpcF9yY3ZfZmluaXNoKzEwLzJhOD4KVHJhY2U7IDAwMDAw
MDAwODAyNjU1YTAgPGlwX3Jjdis1MTAvNTc4PgpUcmFjZTsgMDAwMDAwMDA4MDI2NTdmOCA8aXBf
cmN2X2ZpbmlzaCsxMC8yYTg+ClRyYWNlOyAwMDAwMDAwMDgwMTAxMzNjIDxkb19JUlErZjQvMTE4
PgoKQ29kZTsgIDAwMDAwMDAwODAyNGIyMDAgPF9fa2ZyZWVfc2tiKzk4LzEzMD4KMDAwMDAwMDAg
PF9QQz46CkNvZGU7ICAwMDAwMDAwMDgwMjRiMjAwIDxfX2tmcmVlX3NrYis5OC8xMzA+CiAgIDA6
ICAgOGUwNjAwOWMgIGx3ICAgICAgYTIsMTU2KHMwKQpDb2RlOyAgMDAwMDAwMDA4MDI0YjIwNCA8
X19rZnJlZV9za2IrOWMvMTMwPgogICA0OiAgIDEwYzAwMDBlICBiZXF6ICAgIGEyLDQwIDxfUEMr
MHg0MD4KQ29kZTsgIDAwMDAwMDAwODAyNGIyMDggPF9fa2ZyZWVfc2tiK2EwLzEzMD4KICAgODog
ICAyNDAzMDAwMSAgbGkgICAgICB2MSwxCkNvZGU7ICAwMDAwMDAwMDgwMjRiMjBjIDxfX2tmcmVl
X3NrYithNC8xMzA+ICAgPD09PT09CiAgIGM6ICAgOGNjMjAwMDAgIGx3ICAgICAgdjAsMChhMikg
ICA8PT09PT0KQ29kZTsgIDAwMDAwMDAwODAyNGIyMTAgPF9fa2ZyZWVfc2tiK2E4LzEzMD4KICAx
MDogICBjMDQ1MDAwMCAgbGwgICAgICBhMSwwKHYwKQpDb2RlOyAgMDAwMDAwMDA4MDI0YjIxNCA8
X19rZnJlZV9za2IrYWMvMTMwPgogIDE0OiAgIDAwYTMyMDIzICBzdWJ1ICAgIGEwLGExLHYxCkNv
ZGU7ICAwMDAwMDAwMDgwMjRiMjE4IDxfX2tmcmVlX3NrYitiMC8xMzA+CiAgMTg6ICAgZTA0NDAw
MDAgIHNjICAgICAgYTAsMCh2MCkKQ29kZTsgIDAwMDAwMDAwODAyNGIyMWMgPF9fa2ZyZWVfc2ti
K2I0LzEzMD4KICAxYzogICAxMDgwZmZmYyAgYmVxeiAgICBhMCwxMCA8X1BDKzB4MTA+CkNvZGU7
ICAwMDAwMDAwMDgwMjRiMjIwIDxfX2tmcmVlX3NrYitiOC8xMzA+CiAgMjA6ICAgMDBhMzIwMjMg
IHN1YnUgICAgYTAsYTEsdjEKCktlcm5lbCBwYW5pYzogQWllZSwga2lsbGluZyBpbnRlcnJ1cHQg
aGFuZGxlciEKCjEgd2FybmluZyBpc3N1ZWQuICBSZXN1bHRzIG1heSBub3QgYmUgcmVsaWFibGUu
Cg==

------_=_NextPart_001_01C5613B.2E4B5FBD
Content-Type: application/octet-stream;
	name="recent.cap_send.oops"
Content-Transfer-Encoding: base64
Content-Description: recent.cap_send.oops
Content-Disposition: attachment;
	filename="recent.cap_send.oops"

a3N5bW9vcHMgMi40Ljkgb24gaTY4NiAyLjQuMjItMS4yMTE1Lm5wdGwuICBPcHRpb25zIHVzZWQK
ICAgICAtdiAvaG9tZS9hbWQvcHJvamVjdC9hbWQva2VybmVsL3ZtbGludXggKGRlZmF1bHQpCiAg
ICAgLUsgKHNwZWNpZmllZCkKICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQogICAgIC1v
IC9ob21lL2FtZC9wcm9qZWN0L2FtZC9maWxlc3lzdGVtL3Vzci9saWIvbW9kdWxlcy8gKGRlZmF1
bHQpCiAgICAgLW0gL2hvbWUvYW1kL3Byb2plY3QvYW1kL2tlcm5lbC9TeXN0ZW0ubWFwIChkZWZh
dWx0KQogICAgIC10IGVsZjMyLWxpdHRsZW1pcHMgLWEgbWlwczo0NjAwCgpObyBtb2R1bGVzIGlu
IGtzeW1zLCBza2lwcGluZyBvYmplY3RzCk5vIGtzeW1zLCBza2lwcGluZyBsc21vZApVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDMy
ZDQsIGVwYyA9PSA4MDI0YWY2YywgcmEgPT0gODAyNGIwOTQKT29wcyBpbiBmYXVsdC5jOjpkb19w
YWdlX2ZhdWx0LCBsaW5lIDIwNjoKJDAgOiAwMDAwMDAwMCAxMDAwZmMwMCA4YWM4MWUwMCAwMDAw
MzI2MCAwMDAwMzI2MCAwMDAwMDAwMCAwMDAwMDAwMCA4YjM4YjM0MAokOCA6IDAwMDAwMDMwIDgw
MmRhMWEwIDAwMDAwMDEwIGJmYmViZGJjIGEzYTJhMWEwIDAwMDAwMDAwIDhhYjc5ZGU4IGE3YTZh
NWE0CiQxNjogMDAwMDMyNjAgMDAwMDAwMDEgOGFlYTgyNjAgYzAxNzI5NGMgMDAwMDAwMGYgODAy
NGIxNzggYzAxNjdhYjggYzAxNzI5NTAKJDI0OiAwMDAwMDAxMCAwMDQwZTBmMCAgICAgICAgICAg
ICAgICAgICA4YWI3ODAwMCA4YWI3OWE2OCBjMDE3MjdkOCA4MDI0YjA5NApIaSA6IDAwMDAwMDAw
CkxvIDogMDAwMDAwMGIKZXBjICAgOiA4MDI0YWY2YyAgICBOb3QgdGFpbnRlZApTdGF0dXM6IDEw
MDBmYzAzCkNhdXNlIDogMDA4MDAwMDgKUHJvY2VzcyBtZG0td2lwcm8tbm8tZGUgKHBpZDogNDEw
LCBzdGFja3BhZ2U9OGFiNzgwMDApClN0YWNrOiAgICA4YWI3OWFkOCA4MDM2OWJmMCAwMDAwMDAw
NCA4MDI1YTQ4NCA4YjZiNTQ2MCA4YjZiNTQ2MCA4MDI0YjA5NAogZmZmYmM0NzMgODAyNmE5MGMg
ODAzYTA0MDAgODEyYmVhODAgODAzYTA0MDAgOGI2YjU0NjAgOGIzOGIzNjAgODAyNGIwYzQKIDAw
MDAwMDAwIDAwMDAwMDAyIDAwMDA0MGQyIDgwMmRhMGUwIDhhYjc5YzU4IDhiNmI1NDYwIDgwMjRi
Mjk4IDgxMmI2NDYwCiA4MDNhMDQwMCA4MDNhMDQwMCA4YWI3OWFkOCA4YjZiNTQ2MCBjMDE3MWY1
OCA4MTJiZWJjMCA4MDM5MDZhOCAwMDAwMDAyMAogODAyNGFlMzggOGI2YjU3ODAgOGFhYzQwZjYg
OGI0MjhkNjAgMDAwMDAwMDAgODEyYmViYzAgOGFhYzAwMTAgOGFlYTgyNjAKIDAwMDA0MGQyIC4u
LgpDYWxsIFRyYWNlOiAgIFs8ODAyNWE0ODQ+XSBbPDgwMjRiMDk0Pl0gWzw4MDI2YTkwYz5dIFs8
ODAyNGIwYzQ+XSBbPDgwMmRhMGUwPl0KIFs8ODAyNGIyOTg+XSBbPGMwMTcxZjU4Pl0gWzw4MDI0
YWUzOD5dIFs8ODAyZDlkODA+XSBbPGMwMTcxZTEwPl0gWzw4MDI2YTkwYz5dCiBbPGMwMTcyNDE0
Pl0gWzxjMDE3NDBlOD5dIFs8ODAyNWE0ODQ+XSBbPDgwMjZhOTBjPl0gWzw4MDI2YTkwYz5dIFs8
ODAyNWE5NDg+XQogWzw4MDJkYTBlMD5dIFs8ODAyNmE5MGM+XSBbPGMwMTc1MWRjPl0gWzw4MDI2
YThkND5dIFs8ODAyNmE5MGM+XSBbPDgwMjZhMzBjPl0KIFs8ODAyNmExODQ+XSBbPDgwMjY3MTMw
Pl0gWzw4MDI2NzFiMD5dIFs8ODAyNmE3NDQ+XSBbPDgwMjVhOThjPl0gWzw4MDI2NzEzMD5dCiBb
PDgwMjY3MDZjPl0gWzw4MDI2NzEzMD5dIFs8ODAyNjU3Zjg+XSBbPDgwMjY1YTIwPl0gWzw4MDI1
YTQ4ND5dIFs8YzAxY2UyYTg+XQogWzw4MDI2NTdmOD5dIFs8ODAyNjU3Zjg+XSBbPDgwMjVhOThj
Pl0gWzw4MDI1YTk0OD5dIFs8ODAyNjU3Zjg+XSAuLi4KV2FybmluZyAoT29wc190cmFjZV9saW5l
KTogZ2FyYmFnZSAnLi4uJyBhdCBlbmQgb2YgdHJhY2UgbGluZSBpZ25vcmVkCkNvZGU6IDhjNTAw
MDA4ICBhYzQwMDAwOCAgMDIwMDIwMjEgPDhjODIwMDc0PiAxMDUxMDAwOSAgOGUxMDAwMDAgIGMw
ODMwMDc0ICAwMDcxMTAyMyAgZTA4MjAwNzQKCgo+PlJBOyAgMDAwMDAwMDA4MDI0YjA5NCA8c2ti
X3JlbGVhc2VfZGF0YStiMC9iYz4KPj4kOTsgMDAwMDAwMDA4MDJkYTFhMCA8bWVtc2V0X3BhcnRp
YWwrMjQvNmM+Cj4+JDIxOyAwMDAwMDAwMDgwMjRiMTc4IDxfX2tmcmVlX3NrYisxMC8xMzA+Cj4+
JDMxOyAwMDAwMDAwMDgwMjRiMDk0IDxza2JfcmVsZWFzZV9kYXRhK2IwL2JjPgoKPj5QQzsgIDAw
MDAwMDAwODAyNGFmNmMgPHNrYl9kcm9wX2ZyYWdsaXN0KzM0Lzc0PiAgIDw9PT09PQoKVHJhY2U7
IDAwMDAwMDAwODAyNWE0ODQgPG5mX2l0ZXJhdGUrOTQvMTE0PgpUcmFjZTsgMDAwMDAwMDA4MDI0
YjA5NCA8c2tiX3JlbGVhc2VfZGF0YStiMC9iYz4KVHJhY2U7IDAwMDAwMDAwODAyNmE5MGMgPGlw
X2ZpbmlzaF9vdXRwdXQyKzEwLzE1MD4KVHJhY2U7IDAwMDAwMDAwODAyNGIwYzQgPGtmcmVlX3Nr
Ym1lbSsyNC9jOD4KVHJhY2U7IDAwMDAwMDAwODAyZGEwZTAgPG1lbXNldCswLzFjPgpUcmFjZTsg
MDAwMDAwMDA4MDI0YjI5OCA8c2tiX2Nsb25lKzAvMjUwPgpUcmFjZTsgMDAwMDAwMDBjMDE3MWY1
OCA8RU5EX09GX0NPREUrM2ZkZGY3NTgvPz8/Pz4KVHJhY2U7IDAwMDAwMDAwODAyNGFlMzggPGFs
bG9jX3NrYisxNjAvMjYwPgpUcmFjZTsgMDAwMDAwMDA4MDJkOWQ4MCA8bWVtY3B5KzAvND4KVHJh
Y2U7IDAwMDAwMDAwYzAxNzFlMTAgPEVORF9PRl9DT0RFKzNmZGRmNjEwLz8/Pz8+ClRyYWNlOyAw
MDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAw
MGMwMTcyNDE0IDxFTkRfT0ZfQ09ERSszZmRkZmMxNC8/Pz8/PgpUcmFjZTsgMDAwMDAwMDBjMDE3
NDBlOCA8RU5EX09GX0NPREUrM2ZkZTE4ZTgvPz8/Pz4KVHJhY2U7IDAwMDAwMDAwODAyNWE0ODQg
PG5mX2l0ZXJhdGUrOTQvMTE0PgpUcmFjZTsgMDAwMDAwMDA4MDI2YTkwYyA8aXBfZmluaXNoX291
dHB1dDIrMTAvMTUwPgpUcmFjZTsgMDAwMDAwMDA4MDI2YTkwYyA8aXBfZmluaXNoX291dHB1dDIr
MTAvMTUwPgpUcmFjZTsgMDAwMDAwMDA4MDI1YTk0OCA8bmZfaG9va19zbG93KzEyOC8xZjg+ClRy
YWNlOyAwMDAwMDAwMDgwMmRhMGUwIDxtZW1zZXQrMC8xYz4KVHJhY2U7IDAwMDAwMDAwODAyNmE5
MGMgPGlwX2ZpbmlzaF9vdXRwdXQyKzEwLzE1MD4KVHJhY2U7IDAwMDAwMDAwYzAxNzUxZGMgPEVO
RF9PRl9DT0RFKzNmZGUyOWRjLz8/Pz8+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOGQ0IDxpcF9maW5p
c2hfb3V0cHV0KzFhMC8xYTQ+ClRyYWNlOyAwMDAwMDAwMDgwMjZhOTBjIDxpcF9maW5pc2hfb3V0
cHV0MisxMC8xNTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhMzBjIDxpcF9mcmFnbWVudCszYzgvNTAw
PgpUcmFjZTsgMDAwMDAwMDA4MDI2YTE4NCA8aXBfZnJhZ21lbnQrMjQwLzUwMD4KVHJhY2U7IDAw
MDAwMDAwODAyNjcxMzAgPGlwX2ZvcndhcmRfZmluaXNoKzEwL2EwPgpUcmFjZTsgMDAwMDAwMDA4
MDI2NzFiMCA8aXBfZm9yd2FyZF9maW5pc2grOTAvYTA+ClRyYWNlOyAwMDAwMDAwMDgwMjZhNzQ0
IDxpcF9maW5pc2hfb3V0cHV0KzEwLzFhND4KVHJhY2U7IDAwMDAwMDAwODAyNWE5OGMgPG5mX2hv
b2tfc2xvdysxNmMvMWY4PgpUcmFjZTsgMDAwMDAwMDA4MDI2NzEzMCA8aXBfZm9yd2FyZF9maW5p
c2grMTAvYTA+ClRyYWNlOyAwMDAwMDAwMDgwMjY3MDZjIDxfX2dudV9jb21waWxlZF9jKzI2Yy8z
MjA+ClRyYWNlOyAwMDAwMDAwMDgwMjY3MTMwIDxpcF9mb3J3YXJkX2ZpbmlzaCsxMC9hMD4KVHJh
Y2U7IDAwMDAwMDAwODAyNjU3ZjggPGlwX3Jjdl9maW5pc2grMTAvMmE4PgpUcmFjZTsgMDAwMDAw
MDA4MDI2NWEyMCA8aXBfcmN2X2ZpbmlzaCsyMzgvMmE4PgpUcmFjZTsgMDAwMDAwMDA4MDI1YTQ4
NCA8bmZfaXRlcmF0ZSs5NC8xMTQ+ClRyYWNlOyAwMDAwMDAwMGMwMWNlMmE4IDxFTkRfT0ZfQ09E
RSszZmUzYmFhOC8/Pz8/PgpUcmFjZTsgMDAwMDAwMDA4MDI2NTdmOCA8aXBfcmN2X2ZpbmlzaCsx
MC8yYTg+ClRyYWNlOyAwMDAwMDAwMDgwMjY1N2Y4IDxpcF9yY3ZfZmluaXNoKzEwLzJhOD4KVHJh
Y2U7IDAwMDAwMDAwODAyNWE5OGMgPG5mX2hvb2tfc2xvdysxNmMvMWY4PgpUcmFjZTsgMDAwMDAw
MDA4MDI1YTk0OCA8bmZfaG9va19zbG93KzEyOC8xZjg+ClRyYWNlOyAwMDAwMDAwMDgwMjY1N2Y4
IDxpcF9yY3ZfZmluaXNoKzEwLzJhOD4KCkNvZGU7ICAwMDAwMDAwMDgwMjRhZjYwIDxza2JfZHJv
cF9mcmFnbGlzdCsyOC83ND4KMDAwMDAwMDAgPF9QQz46CkNvZGU7ICAwMDAwMDAwMDgwMjRhZjYw
IDxza2JfZHJvcF9mcmFnbGlzdCsyOC83ND4KICAgMDogICA4YzUwMDAwOCAgbHcgICAgICBzMCw4
KHYwKQpDb2RlOyAgMDAwMDAwMDA4MDI0YWY2NCA8c2tiX2Ryb3BfZnJhZ2xpc3QrMmMvNzQ+CiAg
IDQ6ICAgYWM0MDAwMDggIHN3ICAgICAgemVybyw4KHYwKQpDb2RlOyAgMDAwMDAwMDA4MDI0YWY2
OCA8c2tiX2Ryb3BfZnJhZ2xpc3QrMzAvNzQ+CiAgIDg6ICAgMDIwMDIwMjEgIG1vdmUgICAgYTAs
czAKQ29kZTsgIDAwMDAwMDAwODAyNGFmNmMgPHNrYl9kcm9wX2ZyYWdsaXN0KzM0Lzc0PiAgIDw9
PT09PQogICBjOiAgIDhjODIwMDc0ICBsdyAgICAgIHYwLDExNihhMCkgICA8PT09PT0KQ29kZTsg
IDAwMDAwMDAwODAyNGFmNzAgPHNrYl9kcm9wX2ZyYWdsaXN0KzM4Lzc0PgogIDEwOiAgIDEwNTEw
MDA5ICBiZXEgICAgIHYwLHMxLDM4IDxfUEMrMHgzOD4KQ29kZTsgIDAwMDAwMDAwODAyNGFmNzQg
PHNrYl9kcm9wX2ZyYWdsaXN0KzNjLzc0PgogIDE0OiAgIDhlMTAwMDAwICBsdyAgICAgIHMwLDAo
czApCkNvZGU7ICAwMDAwMDAwMDgwMjRhZjc4IDxza2JfZHJvcF9mcmFnbGlzdCs0MC83ND4KICAx
ODogICBjMDgzMDA3NCAgbGwgICAgICB2MSwxMTYoYTApCkNvZGU7ICAwMDAwMDAwMDgwMjRhZjdj
IDxza2JfZHJvcF9mcmFnbGlzdCs0NC83ND4KICAxYzogICAwMDcxMTAyMyAgc3VidSAgICB2MCx2
MSxzMQpDb2RlOyAgMDAwMDAwMDA4MDI0YWY4MCA8c2tiX2Ryb3BfZnJhZ2xpc3QrNDgvNzQ+CiAg
MjA6ICAgZTA4MjAwNzQgIHNjICAgICAgdjAsMTE2KGEwKQoKS2VybmVsIHBhbmljOiBBaWVlLCBr
aWxsaW5nIGludGVycnVwdCBoYW5kbGVyIQoKMSB3YXJuaW5nIGlzc3VlZC4gIFJlc3VsdHMgbWF5
IG5vdCBiZSByZWxpYWJsZS4K

------_=_NextPart_001_01C5613B.2E4B5FBD--
