Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 18:59:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6091 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006627AbbEVQ7cyD9Y6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 18:59:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 607AC852CBECF;
        Fri, 22 May 2015 17:59:26 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 17:58:28 +0100
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Fri, 22 May 2015 17:58:28 +0100
From:   James Hartley <James.Hartley@imgtec.com>
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Damien Horsley" <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Subject: RE: [PATCH 7/7] mips: pistachio: Allow to enable the external timer
 based clocksource
Thread-Topic: [PATCH 7/7] mips: pistachio: Allow to enable the external
 timer based clocksource
Thread-Index: AQHQlA+qn4NTNngiBUaByn6HDeB+iJ2IJd4AgAASJKA=
Date:   Fri, 22 May 2015 16:58:28 +0000
Message-ID: <72BC0C8BD7BB6F45988A99382E5FBAE5445286D0@hhmail02.hh.imgtec.org>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244618-15548-1-git-send-email-ezequiel.garcia@imgtec.com>
 <CAL1qeaG=LeQtSS_0w_=hXMNfG2dqTomL5hgifFXV-x1Jy9P1rw@mail.gmail.com>
In-Reply-To: <CAL1qeaG=LeQtSS_0w_=hXMNfG2dqTomL5hgifFXV-x1Jy9P1rw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.167.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Hartley@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYWJyZXN0aWNAZ29vZ2xl
LmNvbSBbbWFpbHRvOmFicmVzdGljQGdvb2dsZS5jb21dIE9uIEJlaGFsZiBPZg0KPiBBbmRyZXcg
QnJlc3RpY2tlcg0KPiBTZW50OiAyMiBNYXkgMjAxNSAxNzo1MA0KPiBUbzogRXplcXVpZWwgR2Fy
Y2lhDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaW51eC1NSVBTOyBEYW5p
ZWwgTGV6Y2FubzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEphbWVzIEhhcnRsZXk7
IEphbWVzIEhvZ2FuOyBUaG9tYXMgR2xlaXhuZXI7DQo+IERhbWllbiBIb3JzbGV5OyBHb3ZpbmRy
YWogUmFqYQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDcvN10gbWlwczogcGlzdGFjaGlvOiBBbGxv
dyB0byBlbmFibGUgdGhlIGV4dGVybmFsIHRpbWVyDQo+IGJhc2VkIGNsb2Nrc291cmNlDQo+IA0K
PiBPbiBUaHUsIE1heSAyMSwgMjAxNSBhdCAyOjQzIFBNLCBFemVxdWllbCBHYXJjaWENCj4gPGV6
ZXF1aWVsLmdhcmNpYUBpbWd0ZWMuY29tPiB3cm90ZToNCj4gPiBUaGlzIGNvbW1pdCBpbnRyb2R1
Y2VzIGEgbmV3IGNvbmZpZywgc28gdGhlIHVzZXIgY2FuIGNob29zZSB0byBlbmFibGUNCj4gPiB0
aGUgR2VuZXJhbCBQdXJwb3NlIFRpbWVyIGJhc2VkIGNsb2Nrc291cmNlLiBUaGlzIG9wdGlvbiBp
cyByZXF1aXJlZA0KPiA+IHRvIGhhdmUgQ1BVRnJlcSBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRXplcXVpZWwgR2FyY2lhIDxlemVxdWllbC5nYXJjaWFAaW1ndGVjLmNvbT4NCj4g
PiAtLS0NCj4gPiAgYXJjaC9taXBzL0tjb25maWcgICAgICAgICAgIHwgIDEgKw0KPiA+ICBhcmNo
L21pcHMvcGlzdGFjaGlvL0tjb25maWcgfCAxMyArKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9t
aXBzL3Bpc3RhY2hpby9LY29uZmlnDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL0tj
b25maWcgYi9hcmNoL21pcHMvS2NvbmZpZyBpbmRleA0KPiA+IGY1MDE2NjUuLjkxZjZjYTAgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9taXBzL0tjb25maWcNCj4gPiArKysgYi9hcmNoL21pcHMvS2Nv
bmZpZw0KPiA+IEBAIC05MzQsNiArOTM0LDcgQEAgc291cmNlICJhcmNoL21pcHMvamF6ei9LY29u
ZmlnIg0KPiA+ICBzb3VyY2UgImFyY2gvbWlwcy9qejQ3NDAvS2NvbmZpZyINCj4gPiAgc291cmNl
ICJhcmNoL21pcHMvbGFudGlxL0tjb25maWciDQo+ID4gIHNvdXJjZSAiYXJjaC9taXBzL2xhc2F0
L0tjb25maWciDQo+ID4gK3NvdXJjZSAiYXJjaC9taXBzL3Bpc3RhY2hpby9LY29uZmlnIg0KPiA+
ICBzb3VyY2UgImFyY2gvbWlwcy9wbWNzLW1zcDcxeHgvS2NvbmZpZyINCj4gPiAgc291cmNlICJh
cmNoL21pcHMvcmFsaW5rL0tjb25maWciDQo+ID4gIHNvdXJjZSAiYXJjaC9taXBzL3NnaS1pcDI3
L0tjb25maWciDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9waXN0YWNoaW8vS2NvbmZpZyBi
L2FyY2gvbWlwcy9waXN0YWNoaW8vS2NvbmZpZw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGlu
ZGV4IDAwMDAwMDAuLjk3NzMxZWENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9t
aXBzL3Bpc3RhY2hpby9LY29uZmlnDQo+ID4gQEAgLTAsMCArMSwxMyBAQA0KPiA+ICtjb25maWcg
UElTVEFDSElPX0dQVElNRVJfQ0xLU1JDDQo+ID4gKyAgICAgICBib29sICJFbmFibGUgR2VuZXJh
bCBQdXJwb3NlIFRpbWVyIGJhc2VkIGNsb2Nrc291cmNlIg0KPiA+ICsgICAgICAgZGVwZW5kcyBv
biBNQUNIX1BJU1RBQ0hJTw0KPiA+ICsgICAgICAgc2VsZWN0IENMS1NSQ19QSVNUQUNISU8NCj4g
PiArICAgICAgIHNlbGVjdCBNSVBTX0VYVEVSTkFMX1RJTUVSDQo+IA0KPiBXaHkgbm90IGp1c3Qg
c2VsZWN0IHRoZXNlIGluIHRoZSBNQUNIX1BJU1RBQ0hJTyBLY29uZmlnIGVudHJ5PyAgSXMgdGhl
cmUgYW55DQo+IGhhcm0gaW4gYWx3YXlzIGhhdmluZyB0aGUgUGlzdGFjaGlvIEdQVCBlbmFibGVk
Pw0KDQpJdCBkb2VzIG1lYW4gdGhhdCB0aGVyZSBhcmUgbGVzcyBHUFQncyBhdmFpbGFibGUgZm9y
IG90aGVyIHVzZXJzLCBhbmQgd2hpbHN0IEknbSBub3QgYXdhcmUgb2YgYW55IHVzZSBjYXNlcyB0
aGF0IGN1cnJlbnRseSByZXF1aXJlIGFsbCA0LCBwZXJoYXBzIGhhdmluZyB0aGUgZmxleGliaWxp
dHkgaXMgd29ydGggaXQuDQoNCkphbWVzDQo=
