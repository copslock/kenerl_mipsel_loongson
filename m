Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E7C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4205B20700
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 09:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfBVJ6A (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:58:00 -0500
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:52113 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfBVJ6A (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Feb 2019 04:58:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06263833|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0759355-0.0175749-0.90649;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=rosysong@rosinson.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.E.o.F.2_1550829475;
Received: from DESKTOP-N5K16OA(mailfrom:rosysong@rosinson.com fp:SMTPD_---.E.o.F.2_1550829475)
          by smtp.aliyun-inc.com(10.194.97.246);
          Fri, 22 Feb 2019 17:57:56 +0800
Date:   Fri, 22 Feb 2019 17:57:56 +0800
From:   "rosysong@rosinson.com" <rosysong@rosinson.com>
To:     "Oleksij Rempel" <linux@rempel-privat.de>,
        linux-mips <linux-mips@vger.kernel.org>
Subject: Re: Re: Kernel hang when replace older uboot with uboot master for ath79 mips platform
References: <201902221035393424496@rosinson.com>, 
        <2142641f-fcea-b3da-dfe2-9ae6135f5c1d@rempel-privat.de>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Mime-Version: 1.0
Message-ID: <2019022217575639196011@rosinson.com>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5LCBJIHNlZSB5b3VyIFNvQyBpcyBBUjkzMzEgd2hpY2ggc3Vw
cG9ydGVkIGJ5IHUtYm9vdC1tYXN0ZXIgZWl0aGVyLCBhbmQgeW91ciBib290bG9hZGVyIGlzwqAK
YmFyZWJveC0yMDE5LiBNYXliZSB5b3UgY2FuIGJ1aWxkIGEgdS1ib290LW1hc3RlciBpbWFnZSBm
b3IgeW91ciBBUjkzMzEgbWFjaGluZSBhbmQgeW91IHdpbGwga25vdyB3aGF0IGhhcHBlbiEhISA6
LSkKCk15IEJTUCBpcyBvcGVud3J0LTE4LjA2wqBodHRwczovL2dpdGh1Yi5jb20vb3BlbndydC9v
cGVud3J0LiBxY2E5NTN4IFNvQy4KCgoKQW0gMjIuMDIuMTkgdW0gMDM6MzUgc2NocmllYiByb3N5
c29uZ0Byb3NpbnNvbi5jb206PiBIaSBhbGwsCj7CoMKgwqDCoCBNeSBrZXJuZWwgdmVyc2lvbiBp
cyBsaW51eC00LjkuMTU4LCBpdCBoYW5ncyB3aGVuIHJlcGxhY2UgdGhlIG9sZCB1LWJvb3QoMS4x
LjQpIHdpdGgKdS1ib290LW1hc3Rlci4KPsKgwqDCoMKgIEZvciBsaW51eC00LjE0Lnh4LCBXaGVu
IEkgZW5hYmxlIENPTkZJR19NSVBTUjJfSVJRX1ZJIG9wdGlvbnMsIGl0IGRvZXMgaGFuZyBhbnkg
bG9uZ2VyIHdoaWxlCnN0aWxsIGhhbmcgaW4gbGludXgtNC45LjE1OC4KPsKgwqDCoMKgIFNvbWV0
aW1lcyBpdCBoYW5ncyBhdCAicmFuZG9tOiBjcm5nIGluaXQgZG9uZSIuCj4KPsKgwqDCoMKgIEFu
eSBoaW50cyB3aWxsIGJlIGFwcHJlY2lhdGVkISEhIFRoYW5rcwpJdCBpcyBoYXJkIHRvIGFuc3dl
ciB5b3VyIHF1ZXN0aW9ucy4gTWFueSBwYXJ0cyBwbGF5IHdpdGggZWFjaCBvdGhlci4gQVNvIGZh
ciBJIGhhdmUgZm9sbG93aW5nCnF1ZXN0aW9uczoKLSB3aHkgZG8geW91IGNoYW5nZSBib290IGxv
YWRlcj8KLSB3aHkgZG8geW91IHVzZSBvbGQga2VybmVscz8KLSB3aHkgeW91IGRvIG5vdCB1c2Ug
ZGV2aWNldHJlZT8KLSB3aGF0IGlzIHlvdXIgbWVtb3J5IGxheW91dD8gV2hlcmUgaXMgbG9hZGVk
IHUtYm9vdCBhbmQgd2hlcmUgc2hvdWxkIGJlIGxvYWRlZCBrZXJuZWwuIElzIGtlcm5lbApjb21w
cmVzc2VkPyBXaGVyZSBpdCB3aWxsIGJlIGV4dHJhY3RlZD8KwqAKSGVyZSBpcyBib290IGxvZyBv
biBteSBzeXN0ZW06CmJhcmVib3ggMjAxOS4wMS4wLTAwNTI2LWdkZDRiNDdhYjFiICMzNDYgTW9u
IEZlYiAxOCAwODo0Mjo0OCBDRVQgMjAxOQrCoApCb2FyZDogRFBUZWNobmljcyBEUFQtTW9kdWxl
Cm1kaW9fYnVzOiBtaWlidXMwOiBwcm9iZWQKYWc3MXh4LWdtYWMgMTgwNzAwMDAubWFjQDE5MDAw
MDAwLm9mOiBuZXR3b3JrIGRldmljZSByZWdpc3RlcmVkCm0yNXA4MCB3MjVxMTI4QDAwOiB3MjVx
MTI4ICgxNjM4NCBLYnl0ZXMpCm5ldGNvbnNvbGU6IHJlZ2lzdGVyZWQgYXMgbmV0Y29uc29sZS0x
Cm1hbGxvYyBzcGFjZTogMHg4M2JhMDAwMCAtPiAweDgzZjlmZmZmIChzaXplIDQgTWlCKQpldGgw
OiBnb3QgcHJlc2V0IE1BQyBhZGRyZXNzOiBjNDo5MzowMDowMDphZTo4OQpydW5uaW5nIC9lbnYv
YmluL2luaXQuLi4KwqAKSGl0IGFueSBrZXkgdG8gc3RvcCBhdXRvYm9vdDrCoMKgwqAgMApCb290
aW5nIGVudHJ5ICduZXQnCmV0aDA6IERIQ1AgY2xpZW50IGJvdW5kIHRvIGFkZHJlc3MgMTkyLjE2
OC4yNS4yMArCoApMb2FkaW5nIEVMRiAnL21udC90ZnRwL29yZS1saW51eC1kcHQtbW9kdWxlJwpM
b2FkaW5nIGRldmljZXRyZWUgZnJvbSAnL21udC90ZnRwL29yZS1vZnRyZWUtZHB0LW1vZHVsZScK
U3RhcnRpbmcgYXBwbGljYXRpb24gYXQgMHg4MDZlMDAwMCwgZHRzIDB4ODNiZDYxMjAuLi4KW8Kg
wqDCoCAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA1LjAuMC1yYzErIChwdHhkaXN0QHB0eGRpc3Qp
IChnY2MgdmVyc2lvbiA4LjIuMSAyMDE4MTEzMCAoT1NFTEFTLlRvb2xjaCQKaW4tMjAxOC4xMi4w
IDgtMjAxODExMzApKSAjNjQ0IDIwMTktMDEtMTFUMTM6MTA6MDYrMDA6MDAKW8KgwqDCoCAwLjAw
MDAwMF0gcHJpbnRrOiBib290Y29uc29sZSBbZWFybHkwXSBlbmFibGVkClvCoMKgwqAgMC4wMDAw
MDBdIENQVTAgcmV2aXNpb24gaXM6IDAwMDE5Mzc0IChNSVBTIDI0S2MpClvCoMKgwqAgMC4wMDAw
MDBdIE1JUFM6IG1hY2hpbmUgaXMgRFBUZWNobmljcyBEUFQtTW9kdWxlClvCoMKgwqAgMC4wMDAw
MDBdIFNvQzogQXRoZXJvcyBBUjkzMzAgcmV2IDEKW8KgwqDCoCAwLjAwMDAwMF0gRGV0ZXJtaW5l
ZCBwaHlzaWNhbCBSQU0gbWFwOgpbwqDCoMKgIDAuMDAwMDAwXcKgIG1lbW9yeTogMDQwMDAwMDAg
QCA4MDAwMDAwMCAodXNhYmxlKQpbwqDCoMKgIDAuMDAwMDAwXcKgIG1lbW9yeTogMDQwMDAwMDAg
QCAwMDAwMDAwMCAodXNhYmxlKQpbwqDCoMKgIDAuMDAwMDAwXSBQcmltYXJ5IGluc3RydWN0aW9u
IGNhY2hlIDY0a0IsIFZJUFQsIDQtd2F5LCBsaW5lc2l6ZSAzMiBieXRlcy4KW8KgwqDCoCAwLjAw
MDAwMF0gUHJpbWFyeSBkYXRhIGNhY2hlIDMya0IsIDQtd2F5LCBWSVBULCBjYWNoZSBhbGlhc2Vz
LCBsaW5lc2l6ZSAzMiBieXRlcwpbwqDCoMKgIDAuMDAwMDAwXSBab25lIHJhbmdlczoKW8KgwqDC
oCAwLjAwMDAwMF3CoMKgIE5vcm1hbMKgwqAgW21lbSAweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAw
MDAwMDAzZmZmZmZmXQpbwqDCoMKgIDAuMDAwMDAwXSBNb3ZhYmxlIHpvbmUgc3RhcnQgZm9yIGVh
Y2ggbm9kZQpbwqDCoMKgIDAuMDAwMDAwXSBFYXJseSBtZW1vcnkgbm9kZSByYW5nZXMKW8KgwqDC
oCAwLjAwMDAwMF3CoMKgIG5vZGXCoMKgIDA6IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAw
MDAwMDAwM2ZmZmZmZl0KW8KgwqDCoCAwLjAwMDAwMF0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21l
bSAweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAwMDAwMDAzZmZmZmZmXQpbwqDCoMKgIDAuMDAwMDAw
XSByYW5kb206IGdldF9yYW5kb21fYnl0ZXMgY2FsbGVkIGZyb20gc3RhcnRfa2VybmVsKzB4YzQv
MHg1MmMgd2l0aCBjcm5nX2luaXQ9MApbwqDCoMKgIDAuMDAwMDAwXSBCdWlsdCAxIHpvbmVsaXN0
cywgbW9iaWxpdHkgZ3JvdXBpbmcgb24uwqAgVG90YWwgcGFnZXM6IDE2MjU2ClvCoMKgwqAgMC4w
MDAwMDBdIEtlcm5lbCBjb21tYW5kIGxpbmU6wqDCoCBpcD1kaGNwIHJvb3Q9L2Rldi9uZnMgbmZz
cm9vdD0xOTIuMTY4LjIzLjQ6L2hvbWUvb3JlL25mc3Jvb3QvZCQKdC1tb2R1bGUsdjMsdGNwClvC
oMKgwqAgMC4wMDAwMDBdIERlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9y
ZGVyOiAzLCAzMjc2OCBieXRlcykKW8KgwqDCoCAwLjAwMDAwMF0gSW5vZGUtY2FjaGUgaGFzaCB0
YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMiwgMTYzODQgYnl0ZXMpClvCoMKgwqAgMC4wMDAw
MDBdIFdyaXRpbmcgRXJyQ3RsIHJlZ2lzdGVyPTAwMDAwMDAwClvCoMKgwqAgMC4wMDAwMDBdIFJl
YWRiYWNrIEVyckN0bCByZWdpc3Rlcj0wMDAwMDAwMApbwqDCoMKgIDAuMDAwMDAwXSBNZW1vcnk6
IDU2NjI0Sy82NTUzNksgYXZhaWxhYmxlICg0ODgzSyBrZXJuZWwgY29kZSwgMzk4SyByd2RhdGEs
IDk2MEsgcm9kYXRhLCAxNDMySyBpJAppdCwgMjEzSyBic3MsIDg5MTJLIHJlc2VydmVkLCAwSyBj
bWEtcmVzZXJ2ZWQpClvCoMKgwqAgMC4wMDAwMDBdIFNMVUI6IEhXYWxpZ249MzIsIE9yZGVyPTAt
MywgTWluT2JqZWN0cz0wLCBDUFVzPTEsIE5vZGVzPTEKW8KgwqDCoCAwLjAwMDAwMF0gZnRyYWNl
OiBhbGxvY2F0aW5nIDE3NTk0IGVudHJpZXMgaW4gMzUgcGFnZXMKW8KgwqDCoCAwLjAwMDAwMF0g
TlJfSVJRUzogNTEKW8KgwqDCoCAwLjAwMDAwMF0gQ1BVIGNsb2NrOiA0MDAuMDAwIE1IegpbwqDC
oMKgIDAuMDAwMDAwXSBjbG9ja3NvdXJjZTogTUlQUzogbWFzazogMHhmZmZmZmZmZiBtYXhfY3lj
bGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogOTU1NjMwMjIzMyBuJApbwqDCoMKgIDAuMDAw
MDE0XSBzY2hlZF9jbG9jazogMzIgYml0cyBhdCAyMDBNSHosIHJlc29sdXRpb24gNW5zLCB3cmFw
cyBldmVyeSAxMDczNzQxODIzN25zClvCoMKgwqAgMC4wMDc5MTVdIENhbGlicmF0aW5nIGRlbGF5
IGxvb3AuLi4gMjY1LjQyIEJvZ29NSVBTIChscGo9MTMyNzEwNCkKW8KgwqDCoCAwLjAwNzkxNV0g
Q2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiAyNjUuNDIgQm9nb01JUFMgKGxwaj0xMzI3MTA0KQpb
wqDCoMKgIDAuMDkyNzEwXSBwaWRfbWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEKW8Kg
wqDCoCAwLjA5NzYzMV0gTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRl
cjogMCwgNDA5NiBieXRlcykKW8KgwqDCoCAwLjEwMzk1OF0gTW91bnRwb2ludC1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpbwqDCoMKgIDAuMTE0
ODkwXSBkZXZ0bXBmczogaW5pdGlhbGl6ZWQKW8KgwqDCoCAwLjEyMDE3OF0gY2xvY2tzb3VyY2U6
IGppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lk
bGVfbnM6IDE5MTEyNjA0NDYKMjc1MDAwMCBucwpbwqDCoMKgIDAuMTI4NjM5XSBmdXRleCBoYXNo
IHRhYmxlIGVudHJpZXM6IDI1NiAob3JkZXI6IC0xLCAzMDcyIGJ5dGVzKQpbwqDCoMKgIDAuMTM0
ODYwXSBwaW5jdHJsIGNvcmU6IGluaXRpYWxpemVkIHBpbmN0cmwgc3Vic3lzdGVtClvCoMKgwqAg
MC4xNDE0NTBdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKW8KgwqDCoCAwLjIy
MjEyMF0gY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIE1JUFMKW8KgwqDCoCAy
LjE3MjI5NV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyClvCoMKgwqAgMi4xNzY0
OTNdIHRjcF9saXN0ZW5fcG9ydGFkZHJfaGFzaCBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3Jk
ZXI6IDAsIDQwOTYgYnl0ZXMpClvCoMKgwqAgMi4xODI5ODVdIFRDUCBlc3RhYmxpc2hlZCBoYXNo
IHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpbwqDCoMKgIDIuMTg5
ODI2XSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAwLCA0MDk2IGJ5
dGVzKQpbwqDCoMKgIDIuMTk2MTg4XSBUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFi
bGlzaGVkIDEwMjQgYmluZCAxMDI0KQpbwqDCoMKgIDIuMjAyNzU0XSBVRFAgaGFzaCB0YWJsZSBl
bnRyaWVzOiAyNTYgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpbwqDCoMKgIDIuMjA4MzQxXSBVRFAt
TGl0ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDI1NiAob3JkZXI6IDAsIDQwOTYgYnl0ZXMpClvCoMKg
wqAgMi4yMTUwODNdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQpbwqDCoMKgIDIu
MjIxNjEzXSBSUEM6IFJlZ2lzdGVyZWQgbmFtZWQgVU5JWCBzb2NrZXQgdHJhbnNwb3J0IG1vZHVs
ZS4KW8KgwqDCoCAyLjIyNjE3NV0gUlBDOiBSZWdpc3RlcmVkIHVkcCB0cmFuc3BvcnQgbW9kdWxl
LgpbwqDCoMKgIDIuMjMwNzY4XSBSUEM6IFJlZ2lzdGVyZWQgdGNwIHRyYW5zcG9ydCBtb2R1bGUu
ClvCoMKgwqAgMi4yMzU0ODddIFJQQzogUmVnaXN0ZXJlZCB0Y3AgTkZTdjQuMSBiYWNrY2hhbm5l
bCB0cmFuc3BvcnQgbW9kdWxlLgpbwqDCoMKgIDIuMjQ1NTM3XSB3b3JraW5nc2V0OiB0aW1lc3Rh
bXBfYml0cz0zMCBtYXhfb3JkZXI9MTQgYnVja2V0X29yZGVyPTAKW8KgwqDCoCAyLjI2MTA0Nl0g
c3F1YXNoZnM6IHZlcnNpb24gNC4wICgyMDA5LzAxLzMxKSBQaGlsbGlwIExvdWdoZXIKW8KgwqDC
oCAyLjI4MjI1NV0gTkZTOiBSZWdpc3RlcmluZyB0aGUgaWRfcmVzb2x2ZXIga2V5IHR5cGUKW8Kg
wqDCoCAyLjI4NTkwMl0gS2V5IHR5cGUgaWRfcmVzb2x2ZXIgcmVnaXN0ZXJlZApbwqDCoMKgIDIu
MjkwMDI0XSBLZXkgdHlwZSBpZF9sZWdhY3kgcmVnaXN0ZXJlZApbwqDCoMKgIDIuMjk0MDk4XSBu
ZnM0ZmlsZWxheW91dF9pbml0OiBORlN2NCBGaWxlIExheW91dCBEcml2ZXIgUmVnaXN0ZXJpbmcu
Li4KW8KgwqDCoCAyLjMwMDc2OF0gamZmczI6IHZlcnNpb24gMi4yLiAoTkFORCkgKFNVTU1BUlkp
wqAgwqkgMjAwMS0yMDA2IFJlZCBIYXQsIEluYy4KW8KgwqDCoCAyLjMxMzcyM10gcGluY3RybC1z
aW5nbGUgMTgwNDAwMjgucGlubXV4OiA2NCBwaW5zLCBzaXplIDgKW8KgwqDCoCAyLjMyMzkwOV0g
U2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciwgMSBwb3J0cywgSVJRIHNoYXJpbmcgZGlzYWJsZWQK
W8KgwqDCoCAyLjMzMTE0Ml0gMTgwMjAwMDAudWFydDogdHR5QVRIMCBhdCBNTUlPIDB4MTgwMjAw
MDAgKGlycSA9IDgsIGJhc2VfYmF1ZCA9IDE1NjI1MDApIGlzIGEgQVI5MzNYIFUKQVJUClvCoMKg
wqAgMi4zMzk0NDZdIHByaW50azogY29uc29sZSBbdHR5QVRIMF0gZW5hYmxlZApbwqDCoMKgIDIu
MzM5NDQ2XSBwcmludGs6IGNvbnNvbGUgW3R0eUFUSDBdIGVuYWJsZWQKW8KgwqDCoCAyLjM0NzYy
N10gcHJpbnRrOiBib290Y29uc29sZSBbZWFybHkwXSBkaXNhYmxlZApbwqDCoMKgIDIuMzQ3NjI3
XSBwcmludGs6IGJvb3Rjb25zb2xlIFtlYXJseTBdIGRpc2FibGVkClvCoMKgwqAgMi4zNjM3Mjhd
IG0yNXA4MCBzcGkwLjA6IHcyNXExMjggKDE2Mzg0IEtieXRlcykKW8KgwqDCoCAyLjM2NzAzOV0g
NCBmaXhlZC1wYXJ0aXRpb25zIHBhcnRpdGlvbnMgZm91bmQgb24gTVREIGRldmljZSBzcGkwLjAK
W8KgwqDCoCAyLjM3MzQzOF0gQ3JlYXRpbmcgNCBNVEQgcGFydGl0aW9ucyBvbiAic3BpMC4wIjoK
W8KgwqDCoCAyLjM3ODEyMV0gMHgwMDAwMDAwMjAwMDAtMHgwMDAwMDAzZTAwMDAgOiAiZmlybXdh
cmUiClvCoMKgwqAgMi4zODYxMjddIDB4MDAwMDAwMDAwMDAwLTB4MDAwMDAwMDgwMDAwIDogImJh
cmVib3giClvCoMKgwqAgMi4zOTMxMjJdIDB4MDAwMDAwMDgwMDAwLTB4MDAwMDAwMDkwMDAwIDog
ImJhcmVib3gtZW52aXJvbm1lbnQiClvCoMKgwqAgMi40MDEwNjVdIDB4MDAwMDAwN2YwMDAwLTB4
MDAwMDAwODAwMDAwIDogImFydCIKW8KgwqDCoCAyLjQwODc3MF0gbGlicGh5OiBGaXhlZCBNRElP
IEJ1czogcHJvYmVkClvCoMKgwqAgMi41NjIxMTRdIHJhbmRvbTogZmFzdCBpbml0IGRvbmUKW8Kg
wqDCoCAyLjc0MjY4M10gbGlicGh5OiBhZzcxeHhfbWRpbzogcHJvYmVkClvCoMKgwqAgMy4wMzIy
MjNdIG1kaW8tYnVzLjA6MWY6IEZvdW5kIGFuIEFSNzI0MC9BUjkzMzAgYnVpbHQtaW4gc3dpdGNo
ClvCoMKgwqAgMy4wMzcxNzBdIGxpYnBoeTogYXI3MjQwc3dfbWRpbzogcHJvYmVkClvCoMKgwqAg
My4wODYyMjFdIGFnNzF4eCAxOTAwMDAwMC5ldGg6IGludmFsaWQgTUFDIGFkZHJlc3MsIHVzaW5n
IHJhbmRvbSBhZGRyZXNzClvCoMKgwqAgMy40MjM4NjJdIGFnNzF4eCAxOTAwMDAwMC5ldGg6IGNv
bm5lY3RlZCB0byBQSFkgYXQgbWRpby1idXMuMDoxZjowNCBbdWlkPTAwNGRkMDQxLCBkcml2ZXI9
R2VuZXJpCmMgUEhZXQpbwqDCoMKgIDMuNDMzMDk0XSBldGgwOiBBdGhlcm9zIEFHNzF4eCBhdCAw
eGI5MDAwMDAwLCBpcnEgNCwgbW9kZTpNSUkKW8KgwqDCoCAzLjQ0MDY0Nl0gTkVUOiBSZWdpc3Rl
cmVkIHByb3RvY29sIGZhbWlseSAxMArCoApbwqDCoMKgIDMuNDQ5ODIyXSBTZWdtZW50IFJvdXRp
bmcgd2l0aCBJUHY2ClvCoMKgwqAgMy40NTIzMTBdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBm
YW1pbHkgMTcKW8KgwqDCoCAzLjQ1NzI5NV0gODAyMXE6IDgwMi4xUSBWTEFOIFN1cHBvcnQgdjEu
OApbwqDCoMKgIDMuNDYwNzE4XSBLZXkgdHlwZSBkbnNfcmVzb2x2ZXIgcmVnaXN0ZXJlZApbwqDC
oMKgIDMuNDcwMTgxXSBJUHY2OiBBRERSQ09ORihORVRERVZfVVApOiBldGgwOiBsaW5rIGlzIG5v
dCByZWFkeQpbwqDCoMKgIDUuNTMzODY1XSBldGgwOiBsaW5rIHVwICgxMDBNYnBzL0Z1bGwgZHVw
bGV4KQpbwqDCoMKgIDUuNTQyMTgwXSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogZXRo
MDogbGluayBiZWNvbWVzIHJlYWR5ClvCoMKgwqAgNS41NzIyNTZdIFNlbmRpbmcgREhDUCByZXF1
ZXN0cyAuLCBPSwpbwqDCoMKgIDYuNjc0NTI1XSBJUC1Db25maWc6IEdvdCBESENQIGFuc3dlciBm
cm9tIDE5Mi4xNjguMjMuNCwgbXkgYWRkcmVzcyBpcyAxOTIuMTY4LjI1LjE1MgpbwqDCoMKgIDYu
NjgyNDQyXSBJUC1Db25maWc6IENvbXBsZXRlOgpbwqDCoMKgIDYuNjg1NjQwXcKgwqDCoMKgwqAg
ZGV2aWNlPWV0aDAsIGh3YWRkcj01YTo4ZTo5ODo1ZTo2Nzo5MSwgaXBhZGRyPTE5Mi4xNjguMjUu
MTUyLCBtYXNrPTI1NS4yNTUuMC4wLCBnCnc9MTkyLjE2OC4yMy4yNTQKW8KgwqDCoCA2LjY5NTk4
Nl3CoMKgwqDCoMKgIGhvc3Q9MTkyLjE2OC4yNS4xNTIsIGRvbWFpbj1sYWIucGVuZ3V0cm9uaXgu
ZGUsIG5pcy1kb21haW49KG5vbmUpClvCoMKgwqAgNi43MDM1NDRdwqDCoMKgwqDCoCBib290c2Vy
dmVyPTE5Mi4xNjguMjMuNCwgcm9vdHNlcnZlcj0xOTIuMTY4LjIzLjQsIHJvb3RwYXRoPQpbwqDC
oMKgIDYuNzAzNTU0XcKgwqDCoMKgwqAgbmFtZXNlcnZlcjA9MTkyLjE2OC4yMy4yNTQKW8KgwqDC
oCA2LjcxNDc0OF3CoMKgwqDCoMKgIG50cHNlcnZlcjA9MTkyLjE2OC4yMy40ClvCoMKgwqAgNi43
NDcxMjRdIFZGUzogTW91bnRlZCByb290IChuZnMgZmlsZXN5c3RlbSkgcmVhZG9ubHkgb24gZGV2
aWNlIDA6MTIuClvCoMKgwqAgNi43NTM3MDldIGRldnRtcGZzOiBtb3VudGVkClvCoMKgwqAgNi43
ODQ1OTZdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDE0MzJLClvCoMKgwqAgNi43ODc2
NzddIFRoaXMgYXJjaGl0ZWN0dXJlIGRvZXMgbm90IGhhdmUga2VybmVsIG1lbW9yeSBwcm90ZWN0
aW9uLgpbwqDCoMKgIDYuNzk0MTQ3XSBSdW4gL3NiaW4vaW5pdCBhcyBpbml0IHByb2Nlc3MKW8Kg
wqDCoCA3LjM3NjA3MF0gc3lzdGVtZFsxXTogU3lzdGVtIHRpbWUgYmVmb3JlIGJ1aWxkIHRpbWUs
IGFkdmFuY2luZyBjbG9jay4KW8KgwqDCoCA3LjUwMDEyOF0gc3lzdGVtZFsxXTogRmFpbGVkIHRv
IGluc2VydCBtb2R1bGUgJ2F1dG9mczQnOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5ClvCoMKg
wqAgNy42MjI1NDZdIHN5c3RlbWRbMV06IHN5c3RlbWQgMjM5IHJ1bm5pbmcgaW4gc3lzdGVtIG1v
ZGUuICgtUEFNIC1BVURJVCAtU0VMSU5VWCAtSU1BIC1BUFBBUk1PUiAtClNNQUNLIC1TWVNWSU5J
VCAtVVRNUCAtTElCQ1JZUFRTRVRVUCAtR0NSWVBUIC1HTlVUTFMgLUFDTCAtWFogLUxaNCAtU0VD
Q09NUCArQkxLSUQgLUVMRlVUSUxTICtLTU9EIC1JCkROMiAtSUROIC1QQ1JFMiBkZWZhdWx0LWhp
ZXJhcmNoeT1oeWJyaWQpClvCoMKgwqAgNy42NDM5NTBdIHN5c3RlbWRbMV06IERldGVjdGVkIGFy
Y2hpdGVjdHVyZSBtaXBzLgrCoApXZWxjb21lIHRvIFBUWGRpc3QgLyBQZW5ndXRyb25peC1GcmVp
ZnVuayEKwqAKW8KgwqDCoCA3LjcxNTkwNV0gc3lzdGVtZFsxXTogU2V0IGhvc3RuYW1lIHRvIDxG
cmVpZnVuaz4uCsKgCi0tClJlZ2FyZHMsCk9sZWtzaWoKwqAKCsKgCkZyb206wqBPbGVrc2lqIFJl
bXBlbApEYXRlOsKgMjAxOS0wMi0yMsKgMTc6MDYKVG86wqByb3N5c29uZ0Byb3NpbnNvbi5jb207
IGxpbnV4LW1pcHMKU3ViamVjdDrCoFJlOiBLZXJuZWwgaGFuZyB3aGVuIHJlcGxhY2Ugb2xkZXIg
dWJvb3Qgd2l0aCB1Ym9vdCBtYXN0ZXIgZm9yIGF0aDc5IG1pcHMgcGxhdGZvcm0KSGksCsKgCkFt
IDIyLjAyLjE5IHVtIDAzOjM1IHNjaHJpZWIgcm9zeXNvbmdAcm9zaW5zb24uY29tOj4gSGkgYWxs
LAo+wqDCoMKgwqAgTXkga2VybmVsIHZlcnNpb24gaXMgbGludXgtNC45LjE1OCwgaXQgaGFuZ3Mg
d2hlbiByZXBsYWNlIHRoZSBvbGQgdS1ib290KDEuMS40KSB3aXRoCnUtYm9vdC1tYXN0ZXIuCj7C
oMKgwqDCoCBGb3IgbGludXgtNC4xNC54eCwgV2hlbiBJIGVuYWJsZSBDT05GSUdfTUlQU1IyX0lS
UV9WSSBvcHRpb25zLCBpdCBkb2VzIGhhbmcgYW55IGxvbmdlciB3aGlsZQpzdGlsbCBoYW5nIGlu
IGxpbnV4LTQuOS4xNTguCj7CoMKgwqDCoCBTb21ldGltZXMgaXQgaGFuZ3MgYXQgInJhbmRvbTog
Y3JuZyBpbml0IGRvbmUiLgo+Cj7CoMKgwqDCoCBBbnkgaGludHMgd2lsbCBiZSBhcHByZWNpYXRl
ZCEhISBUaGFua3MKSXQgaXMgaGFyZCB0byBhbnN3ZXIgeW91ciBxdWVzdGlvbnMuIE1hbnkgcGFy
dHMgcGxheSB3aXRoIGVhY2ggb3RoZXIuIEFTbyBmYXIgSSBoYXZlIGZvbGxvd2luZwpxdWVzdGlv
bnM6Ci0gd2h5IGRvIHlvdSBjaGFuZ2UgYm9vdCBsb2FkZXI/Ci0gd2h5IGRvIHlvdSB1c2Ugb2xk
IGtlcm5lbHM/Ci0gd2h5IHlvdSBkbyBub3QgdXNlIGRldmljZXRyZWU/Ci0gd2hhdCBpcyB5b3Vy
IG1lbW9yeSBsYXlvdXQ/IFdoZXJlIGlzIGxvYWRlZCB1LWJvb3QgYW5kIHdoZXJlIHNob3VsZCBi
ZSBsb2FkZWQga2VybmVsLiBJcyBrZXJuZWwKY29tcHJlc3NlZD8gV2hlcmUgaXQgd2lsbCBiZSBl
eHRyYWN0ZWQ/CsKgCkhlcmUgaXMgYm9vdCBsb2cgb24gbXkgc3lzdGVtOgpiYXJlYm94IDIwMTku
MDEuMC0wMDUyNi1nZGQ0YjQ3YWIxYiAjMzQ2IE1vbiBGZWIgMTggMDg6NDI6NDggQ0VUIDIwMTkK
wqAKQm9hcmQ6IERQVGVjaG5pY3MgRFBULU1vZHVsZQptZGlvX2J1czogbWlpYnVzMDogcHJvYmVk
CmFnNzF4eC1nbWFjIDE4MDcwMDAwLm1hY0AxOTAwMDAwMC5vZjogbmV0d29yayBkZXZpY2UgcmVn
aXN0ZXJlZAptMjVwODAgdzI1cTEyOEAwMDogdzI1cTEyOCAoMTYzODQgS2J5dGVzKQpuZXRjb25z
b2xlOiByZWdpc3RlcmVkIGFzIG5ldGNvbnNvbGUtMQptYWxsb2Mgc3BhY2U6IDB4ODNiYTAwMDAg
LT4gMHg4M2Y5ZmZmZiAoc2l6ZSA0IE1pQikKZXRoMDogZ290IHByZXNldCBNQUMgYWRkcmVzczog
YzQ6OTM6MDA6MDA6YWU6ODkKcnVubmluZyAvZW52L2Jpbi9pbml0Li4uCsKgCkhpdCBhbnkga2V5
IHRvIHN0b3AgYXV0b2Jvb3Q6wqDCoMKgIDAKQm9vdGluZyBlbnRyeSAnbmV0JwpldGgwOiBESENQ
IGNsaWVudCBib3VuZCB0byBhZGRyZXNzIDE5Mi4xNjguMjUuMjAKwqAKTG9hZGluZyBFTEYgJy9t
bnQvdGZ0cC9vcmUtbGludXgtZHB0LW1vZHVsZScKTG9hZGluZyBkZXZpY2V0cmVlIGZyb20gJy9t
bnQvdGZ0cC9vcmUtb2Z0cmVlLWRwdC1tb2R1bGUnClN0YXJ0aW5nIGFwcGxpY2F0aW9uIGF0IDB4
ODA2ZTAwMDAsIGR0cyAweDgzYmQ2MTIwLi4uClvCoMKgwqAgMC4wMDAwMDBdIExpbnV4IHZlcnNp
b24gNS4wLjAtcmMxKyAocHR4ZGlzdEBwdHhkaXN0KSAoZ2NjIHZlcnNpb24gOC4yLjEgMjAxODEx
MzAgKE9TRUxBUy5Ub29sY2gkCmluLTIwMTguMTIuMCA4LTIwMTgxMTMwKSkgIzY0NCAyMDE5LTAx
LTExVDEzOjEwOjA2KzAwOjAwClvCoMKgwqAgMC4wMDAwMDBdIHByaW50azogYm9vdGNvbnNvbGUg
W2Vhcmx5MF0gZW5hYmxlZApbwqDCoMKgIDAuMDAwMDAwXSBDUFUwIHJldmlzaW9uIGlzOiAwMDAx
OTM3NCAoTUlQUyAyNEtjKQpbwqDCoMKgIDAuMDAwMDAwXSBNSVBTOiBtYWNoaW5lIGlzIERQVGVj
aG5pY3MgRFBULU1vZHVsZQpbwqDCoMKgIDAuMDAwMDAwXSBTb0M6IEF0aGVyb3MgQVI5MzMwIHJl
diAxClvCoMKgwqAgMC4wMDAwMDBdIERldGVybWluZWQgcGh5c2ljYWwgUkFNIG1hcDoKW8KgwqDC
oCAwLjAwMDAwMF3CoCBtZW1vcnk6IDA0MDAwMDAwIEAgODAwMDAwMDAgKHVzYWJsZSkKW8KgwqDC
oCAwLjAwMDAwMF3CoCBtZW1vcnk6IDA0MDAwMDAwIEAgMDAwMDAwMDAgKHVzYWJsZSkKW8KgwqDC
oCAwLjAwMDAwMF0gUHJpbWFyeSBpbnN0cnVjdGlvbiBjYWNoZSA2NGtCLCBWSVBULCA0LXdheSwg
bGluZXNpemUgMzIgYnl0ZXMuClvCoMKgwqAgMC4wMDAwMDBdIFByaW1hcnkgZGF0YSBjYWNoZSAz
MmtCLCA0LXdheSwgVklQVCwgY2FjaGUgYWxpYXNlcywgbGluZXNpemUgMzIgYnl0ZXMKW8KgwqDC
oCAwLjAwMDAwMF0gWm9uZSByYW5nZXM6ClvCoMKgwqAgMC4wMDAwMDBdwqDCoCBOb3JtYWzCoMKg
IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAwM2ZmZmZmZl0KW8KgwqDCoCAwLjAw
MDAwMF0gTW92YWJsZSB6b25lIHN0YXJ0IGZvciBlYWNoIG5vZGUKW8KgwqDCoCAwLjAwMDAwMF0g
RWFybHkgbWVtb3J5IG5vZGUgcmFuZ2VzClvCoMKgwqAgMC4wMDAwMDBdwqDCoCBub2RlwqDCoCAw
OiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAwMDAwMDAwMDNmZmZmZmZdClvCoMKgwqAgMC4w
MDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAwIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAw
MDAwMDAwM2ZmZmZmZl0KW8KgwqDCoCAwLjAwMDAwMF0gcmFuZG9tOiBnZXRfcmFuZG9tX2J5dGVz
IGNhbGxlZCBmcm9tIHN0YXJ0X2tlcm5lbCsweGM0LzB4NTJjIHdpdGggY3JuZ19pbml0PTAKW8Kg
wqDCoCAwLjAwMDAwMF0gQnVpbHQgMSB6b25lbGlzdHMsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLsKg
IFRvdGFsIHBhZ2VzOiAxNjI1NgpbwqDCoMKgIDAuMDAwMDAwXSBLZXJuZWwgY29tbWFuZCBsaW5l
OsKgwqAgaXA9ZGhjcCByb290PS9kZXYvbmZzIG5mc3Jvb3Q9MTkyLjE2OC4yMy40Oi9ob21lL29y
ZS9uZnNyb290L2QkCnQtbW9kdWxlLHYzLHRjcApbwqDCoMKgIDAuMDAwMDAwXSBEZW50cnkgY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogMywgMzI3NjggYnl0ZXMpClvCoMKg
wqAgMC4wMDAwMDBdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6
IDIsIDE2Mzg0IGJ5dGVzKQpbwqDCoMKgIDAuMDAwMDAwXSBXcml0aW5nIEVyckN0bCByZWdpc3Rl
cj0wMDAwMDAwMApbwqDCoMKgIDAuMDAwMDAwXSBSZWFkYmFjayBFcnJDdGwgcmVnaXN0ZXI9MDAw
MDAwMDAKW8KgwqDCoCAwLjAwMDAwMF0gTWVtb3J5OiA1NjYyNEsvNjU1MzZLIGF2YWlsYWJsZSAo
NDg4M0sga2VybmVsIGNvZGUsIDM5OEsgcndkYXRhLCA5NjBLIHJvZGF0YSwgMTQzMksgaSQKaXQs
IDIxM0sgYnNzLCA4OTEySyByZXNlcnZlZCwgMEsgY21hLXJlc2VydmVkKQpbwqDCoMKgIDAuMDAw
MDAwXSBTTFVCOiBIV2FsaWduPTMyLCBPcmRlcj0wLTMsIE1pbk9iamVjdHM9MCwgQ1BVcz0xLCBO
b2Rlcz0xClvCoMKgwqAgMC4wMDAwMDBdIGZ0cmFjZTogYWxsb2NhdGluZyAxNzU5NCBlbnRyaWVz
IGluIDM1IHBhZ2VzClvCoMKgwqAgMC4wMDAwMDBdIE5SX0lSUVM6IDUxClvCoMKgwqAgMC4wMDAw
MDBdIENQVSBjbG9jazogNDAwLjAwMCBNSHoKW8KgwqDCoCAwLjAwMDAwMF0gY2xvY2tzb3VyY2U6
IE1JUFM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVf
bnM6IDk1NTYzMDIyMzMgbiQKW8KgwqDCoCAwLjAwMDAxNF0gc2NoZWRfY2xvY2s6IDMyIGJpdHMg
YXQgMjAwTUh6LCByZXNvbHV0aW9uIDVucywgd3JhcHMgZXZlcnkgMTA3Mzc0MTgyMzducwpbwqDC
oMKgIDAuMDA3OTE1XSBDYWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDI2NS40MiBCb2dvTUlQUyAo
bHBqPTEzMjcxMDQpClvCoMKgwqAgMC4wMDc5MTVdIENhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4g
MjY1LjQyIEJvZ29NSVBTIChscGo9MTMyNzEwNCkKW8KgwqDCoCAwLjA5MjcxMF0gcGlkX21heDog
ZGVmYXVsdDogMzI3NjggbWluaW11bTogMzAxClvCoMKgwqAgMC4wOTc2MzFdIE1vdW50LWNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDAsIDQwOTYgYnl0ZXMpClvCoMKgwqAg
MC4xMDM5NThdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRl
cjogMCwgNDA5NiBieXRlcykKW8KgwqDCoCAwLjExNDg5MF0gZGV2dG1wZnM6IGluaXRpYWxpemVk
ClvCoMKgwqAgMC4xMjAxNzhdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZmZmZmZmZm
IG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxOTExMjYwNDQ2CjI3NTAwMDAg
bnMKW8KgwqDCoCAwLjEyODYzOV0gZnV0ZXggaGFzaCB0YWJsZSBlbnRyaWVzOiAyNTYgKG9yZGVy
OiAtMSwgMzA3MiBieXRlcykKW8KgwqDCoCAwLjEzNDg2MF0gcGluY3RybCBjb3JlOiBpbml0aWFs
aXplZCBwaW5jdHJsIHN1YnN5c3RlbQpbwqDCoMKgIDAuMTQxNDUwXSBORVQ6IFJlZ2lzdGVyZWQg
cHJvdG9jb2wgZmFtaWx5IDE2ClvCoMKgwqAgMC4yMjIxMjBdIGNsb2Nrc291cmNlOiBTd2l0Y2hl
ZCB0byBjbG9ja3NvdXJjZSBNSVBTClvCoMKgwqAgMi4xNzIyOTVdIE5FVDogUmVnaXN0ZXJlZCBw
cm90b2NvbCBmYW1pbHkgMgpbwqDCoMKgIDIuMTc2NDkzXSB0Y3BfbGlzdGVuX3BvcnRhZGRyX2hh
c2ggaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpbwqDCoMKg
IDIuMTgyOTg1XSBUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRl
cjogMCwgNDA5NiBieXRlcykKW8KgwqDCoCAyLjE4OTgyNl0gVENQIGJpbmQgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxMDI0IChvcmRlcjogMCwgNDA5NiBieXRlcykKW8KgwqDCoCAyLjE5NjE4OF0gVENQ
OiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCAxMDI0IGJpbmQgMTAyNCkKW8Kg
wqDCoCAyLjIwMjc1NF0gVURQIGhhc2ggdGFibGUgZW50cmllczogMjU2IChvcmRlcjogMCwgNDA5
NiBieXRlcykKW8KgwqDCoCAyLjIwODM0MV0gVURQLUxpdGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAy
NTYgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpbwqDCoMKgIDIuMjE1MDgzXSBORVQ6IFJlZ2lzdGVy
ZWQgcHJvdG9jb2wgZmFtaWx5IDEKW8KgwqDCoCAyLjIyMTYxM10gUlBDOiBSZWdpc3RlcmVkIG5h
bWVkIFVOSVggc29ja2V0IHRyYW5zcG9ydCBtb2R1bGUuClvCoMKgwqAgMi4yMjYxNzVdIFJQQzog
UmVnaXN0ZXJlZCB1ZHAgdHJhbnNwb3J0IG1vZHVsZS4KW8KgwqDCoCAyLjIzMDc2OF0gUlBDOiBS
ZWdpc3RlcmVkIHRjcCB0cmFuc3BvcnQgbW9kdWxlLgpbwqDCoMKgIDIuMjM1NDg3XSBSUEM6IFJl
Z2lzdGVyZWQgdGNwIE5GU3Y0LjEgYmFja2NoYW5uZWwgdHJhbnNwb3J0IG1vZHVsZS4KW8KgwqDC
oCAyLjI0NTUzN10gd29ya2luZ3NldDogdGltZXN0YW1wX2JpdHM9MzAgbWF4X29yZGVyPTE0IGJ1
Y2tldF9vcmRlcj0wClvCoMKgwqAgMi4yNjEwNDZdIHNxdWFzaGZzOiB2ZXJzaW9uIDQuMCAoMjAw
OS8wMS8zMSkgUGhpbGxpcCBMb3VnaGVyClvCoMKgwqAgMi4yODIyNTVdIE5GUzogUmVnaXN0ZXJp
bmcgdGhlIGlkX3Jlc29sdmVyIGtleSB0eXBlClvCoMKgwqAgMi4yODU5MDJdIEtleSB0eXBlIGlk
X3Jlc29sdmVyIHJlZ2lzdGVyZWQKW8KgwqDCoCAyLjI5MDAyNF0gS2V5IHR5cGUgaWRfbGVnYWN5
IHJlZ2lzdGVyZWQKW8KgwqDCoCAyLjI5NDA5OF0gbmZzNGZpbGVsYXlvdXRfaW5pdDogTkZTdjQg
RmlsZSBMYXlvdXQgRHJpdmVyIFJlZ2lzdGVyaW5nLi4uClvCoMKgwqAgMi4zMDA3NjhdIGpmZnMy
OiB2ZXJzaW9uIDIuMi4gKE5BTkQpIChTVU1NQVJZKcKgIMKpIDIwMDEtMjAwNiBSZWQgSGF0LCBJ
bmMuClvCoMKgwqAgMi4zMTM3MjNdIHBpbmN0cmwtc2luZ2xlIDE4MDQwMDI4LnBpbm11eDogNjQg
cGlucywgc2l6ZSA4ClvCoMKgwqAgMi4zMjM5MDldIFNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIs
IDEgcG9ydHMsIElSUSBzaGFyaW5nIGRpc2FibGVkClvCoMKgwqAgMi4zMzExNDJdIDE4MDIwMDAw
LnVhcnQ6IHR0eUFUSDAgYXQgTU1JTyAweDE4MDIwMDAwIChpcnEgPSA4LCBiYXNlX2JhdWQgPSAx
NTYyNTAwKSBpcyBhIEFSOTMzWCBVCkFSVApbwqDCoMKgIDIuMzM5NDQ2XSBwcmludGs6IGNvbnNv
bGUgW3R0eUFUSDBdIGVuYWJsZWQKW8KgwqDCoCAyLjMzOTQ0Nl0gcHJpbnRrOiBjb25zb2xlIFt0
dHlBVEgwXSBlbmFibGVkClvCoMKgwqAgMi4zNDc2MjddIHByaW50azogYm9vdGNvbnNvbGUgW2Vh
cmx5MF0gZGlzYWJsZWQKW8KgwqDCoCAyLjM0NzYyN10gcHJpbnRrOiBib290Y29uc29sZSBbZWFy
bHkwXSBkaXNhYmxlZApbwqDCoMKgIDIuMzYzNzI4XSBtMjVwODAgc3BpMC4wOiB3MjVxMTI4ICgx
NjM4NCBLYnl0ZXMpClvCoMKgwqAgMi4zNjcwMzldIDQgZml4ZWQtcGFydGl0aW9ucyBwYXJ0aXRp
b25zIGZvdW5kIG9uIE1URCBkZXZpY2Ugc3BpMC4wClvCoMKgwqAgMi4zNzM0MzhdIENyZWF0aW5n
IDQgTVREIHBhcnRpdGlvbnMgb24gInNwaTAuMCI6ClvCoMKgwqAgMi4zNzgxMjFdIDB4MDAwMDAw
MDIwMDAwLTB4MDAwMDAwM2UwMDAwIDogImZpcm13YXJlIgpbwqDCoMKgIDIuMzg2MTI3XSAweDAw
MDAwMDAwMDAwMC0weDAwMDAwMDA4MDAwMCA6ICJiYXJlYm94IgpbwqDCoMKgIDIuMzkzMTIyXSAw
eDAwMDAwMDA4MDAwMC0weDAwMDAwMDA5MDAwMCA6ICJiYXJlYm94LWVudmlyb25tZW50IgpbwqDC
oMKgIDIuNDAxMDY1XSAweDAwMDAwMDdmMDAwMC0weDAwMDAwMDgwMDAwMCA6ICJhcnQiClvCoMKg
wqAgMi40MDg3NzBdIGxpYnBoeTogRml4ZWQgTURJTyBCdXM6IHByb2JlZApbwqDCoMKgIDIuNTYy
MTE0XSByYW5kb206IGZhc3QgaW5pdCBkb25lClvCoMKgwqAgMi43NDI2ODNdIGxpYnBoeTogYWc3
MXh4X21kaW86IHByb2JlZApbwqDCoMKgIDMuMDMyMjIzXSBtZGlvLWJ1cy4wOjFmOiBGb3VuZCBh
biBBUjcyNDAvQVI5MzMwIGJ1aWx0LWluIHN3aXRjaApbwqDCoMKgIDMuMDM3MTcwXSBsaWJwaHk6
IGFyNzI0MHN3X21kaW86IHByb2JlZApbwqDCoMKgIDMuMDg2MjIxXSBhZzcxeHggMTkwMDAwMDAu
ZXRoOiBpbnZhbGlkIE1BQyBhZGRyZXNzLCB1c2luZyByYW5kb20gYWRkcmVzcwpbwqDCoMKgIDMu
NDIzODYyXSBhZzcxeHggMTkwMDAwMDAuZXRoOiBjb25uZWN0ZWQgdG8gUEhZIGF0IG1kaW8tYnVz
LjA6MWY6MDQgW3VpZD0wMDRkZDA0MSwgZHJpdmVyPUdlbmVyaQpjIFBIWV0KW8KgwqDCoCAzLjQz
MzA5NF0gZXRoMDogQXRoZXJvcyBBRzcxeHggYXQgMHhiOTAwMDAwMCwgaXJxIDQsIG1vZGU6TUlJ
ClvCoMKgwqAgMy40NDA2NDZdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTAKwqAK
W8KgwqDCoCAzLjQ0OTgyMl0gU2VnbWVudCBSb3V0aW5nIHdpdGggSVB2NgpbwqDCoMKgIDMuNDUy
MzEwXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3ClvCoMKgwqAgMy40NTcyOTVd
IDgwMjFxOiA4MDIuMVEgVkxBTiBTdXBwb3J0IHYxLjgKW8KgwqDCoCAzLjQ2MDcxOF0gS2V5IHR5
cGUgZG5zX3Jlc29sdmVyIHJlZ2lzdGVyZWQKW8KgwqDCoCAzLjQ3MDE4MV0gSVB2NjogQUREUkNP
TkYoTkVUREVWX1VQKTogZXRoMDogbGluayBpcyBub3QgcmVhZHkKW8KgwqDCoCA1LjUzMzg2NV0g
ZXRoMDogbGluayB1cCAoMTAwTWJwcy9GdWxsIGR1cGxleCkKW8KgwqDCoCA1LjU0MjE4MF0gSVB2
NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGV0aDA6IGxpbmsgYmVjb21lcyByZWFkeQpbwqDC
oMKgIDUuNTcyMjU2XSBTZW5kaW5nIERIQ1AgcmVxdWVzdHMgLiwgT0sKW8KgwqDCoCA2LjY3NDUy
NV0gSVAtQ29uZmlnOiBHb3QgREhDUCBhbnN3ZXIgZnJvbSAxOTIuMTY4LjIzLjQsIG15IGFkZHJl
c3MgaXMgMTkyLjE2OC4yNS4xNTIKW8KgwqDCoCA2LjY4MjQ0Ml0gSVAtQ29uZmlnOiBDb21wbGV0
ZToKW8KgwqDCoCA2LjY4NTY0MF3CoMKgwqDCoMKgIGRldmljZT1ldGgwLCBod2FkZHI9NWE6OGU6
OTg6NWU6Njc6OTEsIGlwYWRkcj0xOTIuMTY4LjI1LjE1MiwgbWFzaz0yNTUuMjU1LjAuMCwgZwp3
PTE5Mi4xNjguMjMuMjU0ClvCoMKgwqAgNi42OTU5ODZdwqDCoMKgwqDCoCBob3N0PTE5Mi4xNjgu
MjUuMTUyLCBkb21haW49bGFiLnBlbmd1dHJvbml4LmRlLCBuaXMtZG9tYWluPShub25lKQpbwqDC
oMKgIDYuNzAzNTQ0XcKgwqDCoMKgwqAgYm9vdHNlcnZlcj0xOTIuMTY4LjIzLjQsIHJvb3RzZXJ2
ZXI9MTkyLjE2OC4yMy40LCByb290cGF0aD0KW8KgwqDCoCA2LjcwMzU1NF3CoMKgwqDCoMKgIG5h
bWVzZXJ2ZXIwPTE5Mi4xNjguMjMuMjU0ClvCoMKgwqAgNi43MTQ3NDhdwqDCoMKgwqDCoCBudHBz
ZXJ2ZXIwPTE5Mi4xNjguMjMuNApbwqDCoMKgIDYuNzQ3MTI0XSBWRlM6IE1vdW50ZWQgcm9vdCAo
bmZzIGZpbGVzeXN0ZW0pIHJlYWRvbmx5IG9uIGRldmljZSAwOjEyLgpbwqDCoMKgIDYuNzUzNzA5
XSBkZXZ0bXBmczogbW91bnRlZApbwqDCoMKgIDYuNzg0NTk2XSBGcmVlaW5nIHVudXNlZCBrZXJu
ZWwgbWVtb3J5OiAxNDMySwpbwqDCoMKgIDYuNzg3Njc3XSBUaGlzIGFyY2hpdGVjdHVyZSBkb2Vz
IG5vdCBoYXZlIGtlcm5lbCBtZW1vcnkgcHJvdGVjdGlvbi4KW8KgwqDCoCA2Ljc5NDE0N10gUnVu
IC9zYmluL2luaXQgYXMgaW5pdCBwcm9jZXNzClvCoMKgwqAgNy4zNzYwNzBdIHN5c3RlbWRbMV06
IFN5c3RlbSB0aW1lIGJlZm9yZSBidWlsZCB0aW1lLCBhZHZhbmNpbmcgY2xvY2suClvCoMKgwqAg
Ny41MDAxMjhdIHN5c3RlbWRbMV06IEZhaWxlZCB0byBpbnNlcnQgbW9kdWxlICdhdXRvZnM0Jzog
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpbwqDCoMKgIDcuNjIyNTQ2XSBzeXN0ZW1kWzFdOiBz
eXN0ZW1kIDIzOSBydW5uaW5nIGluIHN5c3RlbSBtb2RlLiAoLVBBTSAtQVVESVQgLVNFTElOVVgg
LUlNQSAtQVBQQVJNT1IgLQpTTUFDSyAtU1lTVklOSVQgLVVUTVAgLUxJQkNSWVBUU0VUVVAgLUdD
UllQVCAtR05VVExTIC1BQ0wgLVhaIC1MWjQgLVNFQ0NPTVAgK0JMS0lEIC1FTEZVVElMUyArS01P
RCAtSQpETjIgLUlETiAtUENSRTIgZGVmYXVsdC1oaWVyYXJjaHk9aHlicmlkKQpbwqDCoMKgIDcu
NjQzOTUwXSBzeXN0ZW1kWzFdOiBEZXRlY3RlZCBhcmNoaXRlY3R1cmUgbWlwcy4KwqAKV2VsY29t
ZSB0byBQVFhkaXN0IC8gUGVuZ3V0cm9uaXgtRnJlaWZ1bmshCsKgClvCoMKgwqAgNy43MTU5MDVd
IHN5c3RlbWRbMV06IFNldCBob3N0bmFtZSB0byA8RnJlaWZ1bms+LgrCoAotLQpSZWdhcmRzLApP
bGVrc2lqCsKg

