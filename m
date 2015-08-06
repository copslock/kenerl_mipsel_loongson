Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:50:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40966 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012684AbbHFQulnvX7Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:50:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E63E91D2571E8;
        Thu,  6 Aug 2015 17:50:32 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 17:50:35 +0100
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0235.001; Thu, 6 Aug 2015 17:50:35 +0100
From:   Govindraj Raja <Govindraj.Raja@imgtec.com>
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <Zdenko.Pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>
Subject: RE: [PATCH 6/6] clk: pistachio: correct critical clock list
Thread-Topic: [PATCH 6/6] clk: pistachio: correct critical clock list
Thread-Index: AQHQ0E6JN63wcJK3mkquGAwJ9h83np3/GuGAgAAUKPA=
Date:   Thu, 6 Aug 2015 16:50:34 +0000
Message-ID: <4BF5E8683E87FC4DA89822A5A3EB60CB6F2313@hhmail02.hh.imgtec.org>
References: <1438868890-7810-1-git-send-email-govindraj.raja@imgtec.com>
 <CAL1qeaHLqj+vicU8FbxSnJW81STP4uPbOMnM5m42ecBJu1Vokg@mail.gmail.com>
In-Reply-To: <CAL1qeaHLqj+vicU8FbxSnJW81STP4uPbOMnM5m42ecBJu1Vokg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.167.98]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Govindraj.Raja@imgtec.com
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

SGkgQW5kcmV3LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFicmVz
dGljQGdvb2dsZS5jb20gW21haWx0bzphYnJlc3RpY0Bnb29nbGUuY29tXSBPbiBCZWhhbGYgT2Yg
QW5kcmV3DQo+IEJyZXN0aWNrZXINCj4gU2VudDogMDYgQXVndXN0IDIwMTUgMDU6MzcgUE0NCj4g
VG86IEdvdmluZHJhaiBSYWphDQo+IENjOiBMaW51eC1NSVBTOyBsaW51eC1jbGtAdmdlci5rZXJu
ZWwub3JnOyBNaWtlIFR1cnF1ZXR0ZTsgU3RlcGhlbiBCb3lkOw0KPiBNaWNoYWVsIFR1cnF1ZXR0
ZTsgWmRlbmtvIFB1bGl0aWthOyBLZXZpbiBDZXJuZWtlZTsgUmFsZiBCYWVjaGxlOyBKYW1lcyBI
YXJ0bGV5Ow0KPiBEYW1pZW4gSG9yc2xleTsgSmFtZXMgSG9nYW47IEV6ZXF1aWVsIEdhcmNpYTsg
RXplcXVpZWwgR2FyY2lhDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNi82XSBjbGs6IHBpc3RhY2hp
bzogY29ycmVjdCBjcml0aWNhbCBjbG9jayBsaXN0DQo+IA0KPiBHb3ZpbmRyYWosDQo+IA0KPiBP
biBUaHUsIEF1ZyA2LCAyMDE1IGF0IDY6NDggQU0sIEdvdmluZHJhaiBSYWphIDxnb3ZpbmRyYWou
cmFqYUBpbWd0ZWMuY29tPg0KPiB3cm90ZToNCj4gPiBGcm9tOiAiRGFtaWVuLkhvcnNsZXkiIDxE
YW1pZW4uSG9yc2xleUBpbWd0ZWMuY29tPg0KPiA+DQo+ID4gQ3VycmVudCBjcml0aWNhbCBjbG9j
ayBsaXN0IGZvciBwaXN0YWNoaW8gZW5hYmxlcyBvbmx5IG1pcHMgYW5kIHN5cw0KPiA+IGNsb2Nr
cyBieSBkZWZhdWx0IGJ1dCB0aGVyZSBhbHNvIG90aGVyIGNsb2NrcyB0aGF0IGFyZSBub3QgY2xh
aW1lZCBieQ0KPiA+IGFueW9uZSBhbmQgbmVlZHMgdG8gYmUgZW5hYmxlZCBieSBkZWZhdWx0Lg0K
PiA+DQo+ID4gVGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBjcml0aWNhbCBjbG9ja3MgdGhhdCBuZWVk
cyB0byBlbmFibGVkIGJ5DQo+ID4gZGVmYXVsdC4NCj4gPg0KPiA+IEFkZCBhIHNlcGFyYXRlIHN0
cnVjdCB0byBkaXN0aW5ndWlzaCB0aGUgY3JpdGljYWwgY2xvY2tzIG9uZSBpcyBjb3JlDQo+ID4g
Y2xvY2sobWlwcykgYW5kIG90aGVycyBhcmUgZnJvbSBwZXJpcGhfY2xrXyoNCj4gPg0KPiA+IFJl
dmlld2VkLWJ5OiBBbmRyZXcgQnJlc3RpY2tlciA8YWJyZXN0aWNAY2hyb21pdW0ub3JnPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEV6ZXF1aWVsIEdhcmNpYSA8ZXplcXVpZWwuZ2FyY2lhQGltZ3RlYy5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFtaWVuLkhvcnNsZXkgPERhbWllbi5Ib3JzbGV5QGlt
Z3RlYy5jb20+DQo+IA0KPiBTaW5jZSB5b3UncmUgdGhlIG9uZSBzZW5kaW5nIHRoZSBwYXRjaCwg
eW91IHNob3VsZCBpbmNsdWRlIHlvdXIgU2lnbmVkLW9mZi1ieS4NCg0KVGhhbmtzIGZvciB0aGUg
cmV2aWV3LCBJIHdpbGwgZml4IHRoZSBjb21tZW50cyBhbmQgcG9zdCB2Mi4NCg0KLS0NClRoYW5r
cywNCkdvdmluZHJhai5SDQoNCg==
