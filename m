Received:  by oss.sgi.com id <S42346AbQHWQ10>;
	Wed, 23 Aug 2000 09:27:26 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:61724 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42333AbQHWQ1G>;
	Wed, 23 Aug 2000 09:27:06 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA01998
	for <linux-mips@oss.sgi.com>; Wed, 23 Aug 2000 09:18:59 -0700 (PDT)
	mail_from (gnava@sirio.tecmor.mx)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA14686
	for <linux@engr.sgi.com>;
	Wed, 23 Aug 2000 09:26:19 -0700 (PDT)
	mail_from (gnava@sirio.tecmor.mx)
Received: from sirio.tecmor.mx (sirio.tecmor.mx [200.33.171.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09759
	for <linux@engr.sgi.com>; Wed, 23 Aug 2000 09:25:43 -0700 (PDT)
	mail_from (gnava@sirio.tecmor.mx)
Received: from localhost (gnava@localhost)
	by sirio.tecmor.mx (8.9.3/8.9.3) with ESMTP id KAA16761
	for <linux@engr.sgi.com>; Wed, 23 Aug 2000 10:33:48 -0500
Date:   Wed, 23 Aug 2000 10:33:48 -0500 (CDT)
From:   Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
To:     linux@cthulhu.engr.sgi.com
Subject: XFree86 in Indy
Message-ID: <Pine.LNX.4.21.0008231031450.16640-200000@sirio.tecmor.mx>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="8323328-1100244579-967044400=:16640"
Content-ID: <Pine.LNX.4.21.0008231031451.16640@sirio.tecmor.mx>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1100244579-967044400=:16640
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0008231031452.16640@sirio.tecmor.mx>


Hello

I have linux installed in an Indy and i installed XFree86 following
all the instructions.

When i execute xinit or startx, everything seems to be ok, the display
jumps to tty7 but there is not image.  If i check the terminal from i
executed x11, there is no messages about errors, and if y do a ps x, 
there are all the process alive (x, xterm, etc).

Can you help me? Do you have any experience with the xserver?

Thanks

Ing. Gabriel Nava
Instituto Tecnologico de Morelia, 
Mexico

--8323328-1100244579-967044400=:16640
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=xlog
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0008231026400.16640@sirio.tecmor.mx>
Content-Description: xserver log
Content-Disposition: ATTACHMENT; FILENAME=xlog

DQoNClhGcmVlODYgVmVyc2lvbiA0LjAuMSAvIFggV2luZG93IFN5c3RlbQ0K
KHByb3RvY29sIFZlcnNpb24gMTEsIHJldmlzaW9uIDAsIHZlbmRvciByZWxl
YXNlIDY0MDApDQpSZWxlYXNlIERhdGU6IDEgSnVseSAyMDAwDQoJSWYgdGhl
IHNlcnZlciBpcyBvbGRlciB0aGFuIDYtMTIgbW9udGhzLCBvciBpZiB5b3Vy
IGNhcmQgaXMgbmV3ZXINCgl0aGFuIHRoZSBhYm92ZSBkYXRlLCBsb29rIGZv
ciBhIG5ld2VyIHZlcnNpb24gYmVmb3JlIHJlcG9ydGluZw0KCXByb2JsZW1z
LiAgKHNlZSBodHRwOi8vd3d3LlhGcmVlODYuT3JnL0ZBUSkNCk9wZXJhdGlu
ZyBTeXN0ZW06IExpbnV4IDIuMi4xMyBtaXBzIFtFTEZdIA0KKD09KSBMb2cg
ZmlsZTogIi92YXIvbG9nL1hGcmVlODYuMC5sb2ciLCBUaW1lOiBUdWUgQXVn
IDIyIDE2OjU4OjQ0IDIwMDANCig9PSkgVXNpbmcgY29uZmlnIGZpbGU6ICIv
ZXRjL1gxMS9YRjg2Q29uZmlnIg0KTWFya2VyczogKC0tKSBwcm9iZWQsICgq
KikgZnJvbSBjb25maWcgZmlsZSwgKD09KSBkZWZhdWx0IHNldHRpbmcsDQog
ICAgICAgICAoKyspIGZyb20gY29tbWFuZCBsaW5lLCAoISEpIG5vdGljZSwg
KElJKSBpbmZvcm1hdGlvbmFsLA0KICAgICAgICAgKFdXKSB3YXJuaW5nLCAo
RUUpIGVycm9yLCAoPz8pIHVua25vd24uDQooPT0pIFNlcnZlckxheW91dCAi
c2ltcGxlIGxheW91dCINCigqKikgfC0tPlNjcmVlbiAiU2NyZWVuIDEiICgw
KQ0KKCoqKSB8ICAgfC0tPk1vbml0b3IgIlNHSSBHRE0xN2UxMSINCigqKikg
fCAgIHwtLT5EZXZpY2UgIk5ld3BvcnQgR3JhcGhpY3MiDQooKiopIHwtLT5J
bnB1dCBEZXZpY2UgIk1vdXNlMSINCigqKikgfC0tPklucHV0IERldmljZSAi
S2V5Ym9hcmQxIg0KKFdXKSBUaGUgZGlyZWN0b3J5ICIvdXNyL1gxMVI2L2xp
Yi9YMTEvZm9udHMvVHlwZTEvIiBkb2VzIG5vdCBleGlzdC4NCglFbnRyeSBk
ZWxldGVkIGZyb20gZm9udCBwYXRoLg0KKFdXKSBUaGUgZGlyZWN0b3J5ICIv
dXNyL1gxMVI2L2xpYi9YMTEvZm9udHMvU3BlZWRvLyIgZG9lcyBub3QgZXhp
c3QuDQoJRW50cnkgZGVsZXRlZCBmcm9tIGZvbnQgcGF0aC4NCigqKikgRm9u
dFBhdGggc2V0IHRvICIvdXNyL1gxMVI2L2xpYi9YMTEvZm9udHMvbG9jYWwv
LC91c3IvWDExUjYvbGliL1gxMS9mb250cy9taXNjLywvdXNyL1gxMVI2L2xp
Yi9YMTEvZm9udHMvNzVkcGkvOnVuc2NhbGVkLC91c3IvWDExUjYvbGliL1gx
MS9mb250cy8xMDBkcGkvOnVuc2NhbGVkLC91c3IvWDExUjYvbGliL1gxMS9m
b250cy9DSUQvLC91c3IvWDExUjYvbGliL1gxMS9mb250cy83NWRwaS8sL3Vz
ci9YMTFSNi9saWIvWDExL2ZvbnRzLzEwMGRwaS8iDQooKiopIFJnYlBhdGgg
c2V0IHRvICIvdXNyL1gxMVI2L2xpYi9YMTEvcmdiIg0KKC0tKSB1c2luZyBW
VCBudW1iZXIgNw0KDQooRUUpIE5vIE9TIFBDSSBzdXBwb3J0IGF2YWlsYWJs
ZQ0KKElJKSB2NGwgZHJpdmVyIGZvciBWaWRlbzRMaW51eA0KKElJKSBOZXdw
b3J0OiBkcml2ZXIgZm9yIE5ld3BvcnQgR3JhcGhpY3MgQ2FyZDogWEwNCigq
KikgTmV3cG9ydCgwKTogRGVwdGggOCwgKC0tKSBmcmFtZWJ1ZmZlciBicHAg
OA0KKD09KSBOZXdwb3J0KDApOiBEZWZhdWx0IHZpc3VhbCBpcyBQc2V1ZG9D
b2xvcg0KKD09KSBOZXdwb3J0KDApOiBVc2luZyBnYW1tYSBjb3JyZWN0aW9u
ICgxLjAsIDEuMCwgMS4wKQ0KKC0tKSBOZXdwb3J0KDApOiBOZXdwb3J0IEdy
YXBoaWNzIEJvYXJkIHJldmlzaW9uIDYsIGNtYXAgcmV2aXNpb24gRA0KKC0t
KSBOZXdwb3J0KDApOiBOZXdwb3J0IGhhcyA4IGJpdHBsYW5lcw0KKD09KSBO
ZXdwb3J0KDApOiBVc2luZyBTVyBjdXJzb3INCihJSSkgTmV3cG9ydCgwKTog
U0dJIEdETTE3ZTExOiBVc2luZyBoc3luYyByYW5nZSBvZiAgMzAuMDAtIDgy
LjAwIGtIeg0KKElJKSBOZXdwb3J0KDApOiBTR0kgR0RNMTdlMTE6IFVzaW5n
IHZyZWZyZXNoIHJhbmdlIG9mICA1MC4wMC0xMjAuMDAgSHoNCihJSSkgTmV3
cG9ydCgwKTogQ2xvY2sgcmFuZ2U6ICAxMC4wMCB0byAzMDAuMDAgTUh6DQoo
V1cpIE5ld3BvcnQoMCk6IE1vZGUgIjEyODB4OTYwIiBkZWxldGVkIChoc3lu
YyBvdXQgb2YgcmFuZ2UpDQooV1cpIE5ld3BvcnQoMCk6IE1vZGUgIjEyODB4
MTAyNCIgZGVsZXRlZCAoaHN5bmMgb3V0IG9mIHJhbmdlKQ0KKFdXKSBOZXdw
b3J0KDApOiBNb2RlICIxNjAweDEyMDAiIGRlbGV0ZWQgKGluc3VmZmljaWVu
dCBtZW1vcnkgZm9yIG1vZGUpDQooV1cpIE5ld3BvcnQoMCk6IE1vZGUgIjE2
MDB4MTIwMCIgZGVsZXRlZCAoaW5zdWZmaWNpZW50IG1lbW9yeSBmb3IgbW9k
ZSkNCihXVykgTmV3cG9ydCgwKTogTW9kZSAiMTYwMHgxMjAwIiBkZWxldGVk
IChpbnN1ZmZpY2llbnQgbWVtb3J5IGZvciBtb2RlKQ0KKFdXKSBOZXdwb3J0
KDApOiBNb2RlICIxNjAweDEyMDAiIGRlbGV0ZWQgKGluc3VmZmljaWVudCBt
ZW1vcnkgZm9yIG1vZGUpDQooV1cpIE5ld3BvcnQoMCk6IE1vZGUgIjE2MDB4
MTIwMCIgZGVsZXRlZCAoaW5zdWZmaWNpZW50IG1lbW9yeSBmb3IgbW9kZSkN
CihXVykgTmV3cG9ydCgwKTogTW9kZSAiMTc5MngxMzQ0IiBkZWxldGVkIChp
bnN1ZmZpY2llbnQgbWVtb3J5IGZvciBtb2RlKQ0KKFdXKSBOZXdwb3J0KDAp
OiBNb2RlICIxNzkyeDEzNDQiIGRlbGV0ZWQgKGluc3VmZmljaWVudCBtZW1v
cnkgZm9yIG1vZGUpDQooV1cpIE5ld3BvcnQoMCk6IE1vZGUgIjE4NTZ4MTM5
MiIgZGVsZXRlZCAoaW5zdWZmaWNpZW50IG1lbW9yeSBmb3IgbW9kZSkNCihX
VykgTmV3cG9ydCgwKTogTW9kZSAiMTg1NngxMzkyIiBkZWxldGVkIChpbnN1
ZmZpY2llbnQgbWVtb3J5IGZvciBtb2RlKQ0KKFdXKSBOZXdwb3J0KDApOiBN
b2RlICIxOTIweDE0NDAiIGRlbGV0ZWQgKGluc3VmZmljaWVudCBtZW1vcnkg
Zm9yIG1vZGUpDQooV1cpIE5ld3BvcnQoMCk6IE1vZGUgIjE5MjB4MTQ0MCIg
ZGVsZXRlZCAoaW5zdWZmaWNpZW50IG1lbW9yeSBmb3IgbW9kZSkNCigtLSkg
TmV3cG9ydCgwKTogVmlydHVhbCBzaXplIGlzIDEyODB4MTAyNCAocGl0Y2gg
MTI4MCkNCigqKikgTmV3cG9ydCgwKTogRGVmYXVsdCBtb2RlICIxMjgweDEw
MjQiOiAxMzUuMCBNSHosIDgwLjAga0h6LCA3NS4wIEh6DQooPT0pIE5ld3Bv
cnQoMCk6IERQSSBzZXQgdG8gKDc1LCA3NSkNCig9PSkgTmV3cG9ydCgwKTog
QmFja2luZyBzdG9yZSBkaXNhYmxlZA0KKFdXKSBOZXdwb3J0KDApOiBPcHRp
b24gIlNpbGtlbm1vdXNlIiBpcyBub3QgdXNlZA0KUEVYRXh0ZW5zaW9uSW5p
dDogQ291bGRuJ3Qgb3BlbiBkZWZhdWx0IFBFWCBmb250IGZpbGUgIFJvbWFu
X00NCigqKikgTW91c2UxOiBQcm90b2NvbDogIlBTLzIiDQooKiopIE1vdXNl
MTogQ29yZSBQb2ludGVyDQooPT0pIE1vdXNlMTogQnV0dG9uczogMw0KKElJ
KSBLZXlib2FyZCAiS2V5Ym9hcmQxIiBoYW5kbGVkIGJ5IGxlZ2FjeSBkcml2
ZXINCihJSSkgWElOUFVUOiBBZGRpbmcgZXh0ZW5kZWQgaW5wdXQgZGV2aWNl
ICJNb3VzZTEiICh0eXBlOiBNT1VTRSkNCg0K
--8323328-1100244579-967044400=:16640--
