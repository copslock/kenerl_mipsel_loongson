Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 17:35:31 +0100 (CET)
Received: from p02c12o145.mxlogic.net ([208.65.145.78]:38206 "EHLO
        p02c12o145.mxlogic.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491042Ab0LVQf1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 17:35:27 +0100
Received: from unknown [76.164.174.81]
        by p02c12o145.mxlogic.net(mxl_mta-6.8.0-0)
        with SMTP id ac8221d4.0.11843.00-257.30000.p02c12o145.mxlogic.net (envelope-from <stuart.venters@adtran.com>);
        Wed, 22 Dec 2010 09:35:27 -0700 (MST)
X-MXL-Hash: 4d1228cf14712109-8edf2454727f4f048cf37951eb1249d161abde92
Received: from corp-exfr1.corp.adtran.com (172.23.101.21) by
 ex-hc1.corp.adtran.com (172.22.50.71) with Microsoft SMTP Server id
 14.1.255.0; Wed, 22 Dec 2010 10:35:19 -0600
Received: from EXV1.corp.adtran.com ([172.22.48.215]) by
 corp-exfr1.corp.adtran.com with Microsoft SMTPSVC(6.0.3790.3959);       Wed, 22
 Dec 2010 10:34:41 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: SMTC support status in latest git head.
Date:   Wed, 22 Dec 2010 10:34:39 -0600
Message-ID: <8F242B230AD6474C8E7815DE0B4982D7179FB887@EXV1.corp.adtran.com>
In-Reply-To: <4D11F707.8040205@paralogos.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMTC support status in latest git head.
Thread-Index: Acuh2JVP6SJCcb4LQuy7QpT3p4hZEgAHK/jw
From:   STUART VENTERS <stuart.venters@adtran.com>
To:     Anoop P A <anoop.pa@gmail.com>
CC:     Anoop P.A. <Anoop_P.A@pmc-sierra.com>, <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>
X-OriginalArrivalTime: 22 Dec 2010 16:34:41.0011 (UTC) FILETIME=[21BAD430:01CBA1F6]
X-Spam: [F=0.2000000000; CM=0.500; S=0.200(2010121501)]
X-MAIL-FROM: <stuart.venters@adtran.com>
X-SOURCE-IP: [(unknown)]
X-AnalysisOut: [v=1.0 c=1 a=fMTePymILGAA:10 a=BLceEmwcHowA:10 a=IkcTkHD0fZ]
X-AnalysisOut: [MA:10 a=0XgpNN2/4a34ymu16SVwsQ==:17 a=GD5LJJB7AAAA:8 a=WPy]
X-AnalysisOut: [IoOwQAAAA:8 a=l1wv9796wFpycM6FTcYA:9 a=00FmtkIcvJrjAydLHE0]
X-AnalysisOut: [A:7 a=jaZI9WZ0oLx7qkTLzJc8KuY4qjcA:4 a=QEXdDO2ut3YA:10 a=b]
X-AnalysisOut: [vPO4xL1mq4A:10 a=1DbiqZag68YA:10]
Return-Path: <stuart.venters@adtran.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuart.venters@adtran.com
Precedence: bulk
X-list: linux-mips

QW5vb3AsDQoNCk5vdGhpbmcganVtcHMgb3V0IHRvIG1lIGluIHRoZSBuZXcgc2V0IG9mIHJlZ2lz
dGVyIHZhbHVlcy4NCg0KSXQgbWlnaHQgYmUgd29ydGggZHVtcGluZyBhbGwgdGhlIENQMCByZWdp
c3RlcnM/DQogICBJJ20gZXNwZWNpYWxseSBpbnRlcmVzdGVkIGluIHRoZSBDb25maWczIHRvIHNl
ZSB0aGUgVkVJQyBiaXQuDQogICBUaGUgdGltZXIgcmVnaXN0ZXJzIG1pZ2h0IGJlIHVzZWZ1bCBh
cyB3ZWxsLg0KDQpSZWdhcmRzLA0KDQpTdHVhcnQNCg0KICAgIA0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogS2V2aW4gRC4gS2lzc2VsbCBbbWFpbHRvOmtldmlua0BwYXJhbG9n
b3MuY29tXQ0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyMiwgMjAxMCA3OjAzIEFNDQpUbzog
QW5vb3AgUCBBDQpDYzogQW5vb3AgUC5BLjsgU1RVQVJUIFZFTlRFUlM7IGxpbnV4LW1pcHNAbGlu
dXgtbWlwcy5vcmcNClN1YmplY3Q6IFJlOiBTTVRDIHN1cHBvcnQgc3RhdHVzIGluIGxhdGVzdCBn
aXQgaGVhZC4NCg0KDQpPbiAxMi8yMi8xMCAzOjUxIEFNLCBBbm9vcCBQIEEgd3JvdGU6DQo+IE9u
IFdlZCwgMjAxMC0xMi0yMiBhdCAwMzozNyAtMDgwMCwgS2V2aW4gRC4gS2lzc2VsbCB3cm90ZToN
Cj4+IFRoYW5rcy4gIFRoaXMgaXMgaW5kZWVkIHN0cmFuZ2UuICBUaGUgVlBFMCBTdGF0dXMgYW5k
IFRDMCBUQ1N0YXR1cy9DYXVzZQ0KPj4gYWxsIGluZGljYXRlIHRoYXQgaW50ZXJydXB0cyBhcmUg
ZW5hYmxlZCBhbmQgbm90IGluaGliaXRlZCBhdCB0aGUgcGVyLVRDDQo+PiBsZXZlbCwgYW5kIHRo
ZSBwcmVzdW1lZCB0aW1lciBpbnRlcnJ1cHQsIGluIHRoZSAweDQwMDAgYml0LCBpcyBwcmVzZW50
DQo+PiBhbmQgbm90IG1hc2tlZC1vZmYuICBMb2dpY2FsbHksIHRoZSBzeXN0ZW0gbXVzdCBiZSBl
bnRlcmluZyAoYW5kDQo+PiBleGl0aW5nKSB0aGUgaW50ZXJydXB0IGhhbmRsZXIsIHlldCB0aGUg
dGltZXIgY2FsaWJyYXRpb24gaXNuJ3QNCj4+IGNvbXBsZXRpbmcuICBUaGF0IGxlYXZlcyBtb3Jl
IGNvbXBsZXggcG9zc2libGUgZXhwbGFuYXRpb25zIGZvciBmYWlsdXJlLA0KPj4gbW9zdCBvZiB3
aGljaCB3b3VsZCBmYWxsIGludG8gdHdvIGNhdGVnb3JpZXM6DQo+Pg0KPj4gMSkgIFRoZSBwbGF0
Zm9ybSBpbnRlcnJ1cHQgaGFuZGxlciBpcyBmYWlsaW5nIHRvIGRlY29kZSB0aGUgZXZlbnQNCj4+
IHByb3Blcmx5IGFzIGEgdGltZXIgZXZlbnQuDQo+PiAyKSAgRGVzcGl0ZSB0aGVyZSBiZWluZyBv
bmx5IG9uZSBUQyBhY3RpdmUsIHRoZSBjYWxpYnJhdGlvbiBjb2RlIGlzDQo+PiB3YWl0aW5nIGZv
ciBzb21lIGhhbmRzaGFrZSBmcm9tIGFub3RoZXIgIkNQVSINCj4+DQo+PiBUbyB0ZXN0IHRoZSBm
aXJzdCwgeW91IG1pZ2h0IGNvbnNpZGVyIGFkZGluZyBhIGtwcmludGYoKSB0byB0aGUgY2FzZSBv
Zg0KPj4gYSAic3B1cmlvdXMiIHRpbWVyLWxpa2UgaW50ZXJydXB0IGJlaW5nIGRldGVjdGVkIGFu
ZCBpZ25vcmVkLi4uDQo+IEkgaGF2ZSB0cmllZCBpdCAuIG9ubHkgb25lIGludGVycnVwdCBpcyBj
b21pbmcgYW5kIHBsYXRmb3JtIGhhbmRsZXINCj4gZGV0ZWN0IGl0IGFzIHRpbWVyIGludGVycnVw
dCBhbmQgYWNrbm93bGVkZ2VzIHByb3Blcmx5IC4geW91IGNhbiBzZWUgYQ0KPiB0aW1lIHN0YW1w
IGNoYW5nZSBpbiB0aGUgbG9ncy4NClRoYXQncyByZWFsbHkgc3RyYW5nZS4gIEFuZCB5b3VyIHRp
bWVyIGludGVycnVwdCBpcyBkZWZpbml0ZWx5IG9uIHRoZSANCmludGVycnVwdCB0aGF0IGNvcnJl
c3BvbmRzIHRvIHRoZSAweDQwMDAgbWFzaz8NCg0KSSBtYXkgaGF2ZSB3cml0dGVuIHRoZSBNVCBz
cGVjIGFuZCB0aGUgb3JpZ2luYWwgU01UQyBjb2RlLCBidXQgSSBkb24ndCANCmhhdmUgYSBjb3B5
IG9mIHRoZSBzcGVjLCBhbmQgaXQncyBiZWVuIGEgZmV3IHllYXJzLCBhbmQgSSBjYW4ndCANCmlu
dGVycHJldCB0aGUgTVZQIGFuZCBWUEUgY29udHJvbC9jb25maWcgdmFsdWVzLiBCdXQgSSBqdXN0
IGRvbid0IHNlZSANCmhvdyB0aGUgcHJvY2Vzc29yIGNvdWxkIG5vdCBiZSB0YWtpbmcgbW9yZSBp
bnRlcnJ1cHRzLiAgU3R1YXJ0IGRpZCANCmRlY29kZSB0aGUgZ2xvYmFsL1ZQRSBzdGF0ZSBlbm91
Z2ggdG8gb2JzZXJ2ZSB0aGF0IGdsb2JhbCBtdWx0aXRocmVhZGVkIA0KZXhlY3V0aW9uIHdhc24n
dCBlbmFibGVkLCB3aGljaCBpcyBpbmRlZWQgc3RyYW5nZSAtIGl0IHNob3VsZG4ndCBtYXR0ZXIg
DQpmb3Igc2luZ2xlLVRDIGV4ZWN1dGlvbiwgYnV0IEkgZG9uJ3QgcmVjYWxsIHRoZXJlIGJlaW5n
IGFueSBzcGVjaWFsLWNhc2UgDQppbiB0aGUgU01UQyBpbml0aWFsaXphdGlvbiB0aGF0IGJ5cGFz
c2VkIHRoYXQgZW5hYmxlLiAgVGhhdCBtYWtlcyBtZSANCnN1c3BlY3QgdGhhdCBtYXliZSBzb21l
b25lIGNoYW5nZWQgdGhlIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlIGluIGEgd2F5IA0KdGhhdCBi
eXBhc3NlcyBvbmUgb2YgdGhlIGNhbm9uaWNhbCBpbml0aWFsaXphdGlvbiBzdGVwcyBpbiBhIHdh
eSB0aGF0IA0Kd291bGQgYnJlYWsgU01UQywgYnV0IEkgZG9uJ3Qga25vdyB3aHkgdGhhdCB3b3Vs
ZCByZXN1bHQgaW4gdGhlIA0KaW50ZXJydXB0IGJlaGF2aW9yIHlvdSBvYnNlcnZlLg0KDQpJdCBt
aWdodCBiZSB5ZXQgYW5vdGhlciBibGluZCBhbGxleSwgYnV0IGNvdWxkIHlvdSBhZGQvYXJtIGRp
YWdub3N0aWMgDQpvdXRwdXQgZm9yIGVhY2ggb2YgdGhlIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9u
cyBpbiBzbXRjLmM/DQoNCkFoLCB5ZXMsIGFuZCBvbmUgb3RoZXIgdGhpbmcuICBZb3Ugc2hvdWxk
IGFkZCBhIGR1bXAgb2YgRXJyb3JFUEMgdG8gdGhlIA0KTVQgcmVnaXN0ZXIgZHVtcC4gIEkgZGlk
IGl0IGZvciBteXNlbGYgb25jZSB1cG9uIGEgdGltZSB3aGVuIEkgd2FzIA0KY29uZnJvbnRlZCB3
aXRoIGEgc2ltaWxhciBteXN0ZXJ5LCBidXQgbmV2ZXIgZmlsZWQgYSBwYXRjaC4gIElmIHlvdSdy
ZSANCmJyZWFraW5nIGluIHdpdGggTk1JLCB0aGF0IGNvdWxkIGhlbHAgaWRlbnRpZnkgbW9yZSBw
cmVjaXNlbHkgd2hlcmUgaXQncyANCmxvY2tpbmcgdXAuDQoNCllvdSByZWFsbHkgb3VnaHQgdG8g
dHJ5IHRvIGJvcnJvdyBhbiBFSlRBRyBwcm9iZS4gIEl0IHdvdWxkIHNhdmUgdXMgYm90aCANCmEg
bG90IG9mIHRpbWUuICBBbmQgbXkgdGltZSB0byB0cm91YmxlLXNob290IHRoaXMgd2l0aCB5b3Ug
aXMgbGltaXRlZC4NCg0KICAgICAgICAgICAgIFJlZ2FyZHMsDQoNCiAgICAgICAgICAgICBLZXZp
biBLLg0K
