Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2016 18:30:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010653AbcAMRaYurg9r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2016 18:30:24 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id DC2AFD8B25FD8;
        Wed, 13 Jan 2016 17:30:15 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0235.001; Wed, 13 Jan 2016 17:30:18 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     James Hogan <James.Hogan@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "Linux MIPS Mailing List" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH] ld-version: fix it on Fedora
Thread-Topic: [PATCH] ld-version: fix it on Fedora
Thread-Index: AQHRTiSm06OWSy7R702Mpze/gPXRWp75re5g
Date:   Wed, 13 Jan 2016 17:30:18 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F45D04AA7@HHMAIL01.hh.imgtec.org>
References: <1452189189-31188-1-git-send-email-mst@redhat.com>
 <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com>
In-Reply-To: <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.14.109]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Daniel.Sanders@imgtec.com
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

SGksDQoNClRoZSB2ZXJzaW9uIG51bWJlciB0aGF0J3MgZ2l2aW5nIG1lIHByb2JsZW1zIGlzIDIu
MjQuNTEuMjAxNDAyMTcgd2hpY2ggbGQtdmVyc2lvbi5zaCBjb252ZXJ0cyB0byAyMDM2OTMxNzAw
ICgyMDAwMDAwMCsyNDAwMDAwKzUxMDAwMCsyMDE0MDIxNzAwKS4NCg0KQXQgdGhlIG1vbWVudCwg
SSdtIHdvbmRlcmluZyB3aGV0aGVyIHdlIHJlYWxseSBuZWVkIHRvIGhhbmRsZSBtb3JlIHRoYW4g
dGhyZWUgdmVyc2lvbiBudW1iZXIgY29tcG9uZW50cy4gQW5vdGhlciB0aG91Z2h0IGlzIHRoYXQg
dGhlIGNvbXBhcmlzb24gY291bGQgYmUgaW5zaWRlIGxkLXZlcnNpb24uc2ggKG9yIGEgcmVwbGFj
ZW1lbnQpIHNvIHRoYXQgaXQgY2FuIGNvbXBhcmUgdGhlIGFycmF5IG9mIHZlcnNpb24gY29tcG9u
ZW50cyBkaXJlY3RseSBpbnN0ZWFkIG9mIHVzaW5nIGEgY29uc3RydWN0ZWQgaW50ZWdlciBhcyBh
IHByb3h5Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGphbWVzQGFs
YmFuYXJ0cy5jb20gW21haWx0bzpqYW1lc0BhbGJhbmFydHMuY29tXSBPbiBCZWhhbGYgT2YNCj4g
SmFtZXMgSG9nYW4NCj4gU2VudDogMTMgSmFudWFyeSAyMDE2IDE3OjA2DQo+IFRvOiBNaWNoYWVs
IFMuIFRzaXJraW4NCj4gQ2M6IExLTUw7IE1pY2hhbCBNYXJlazsgbGludXgta2J1aWxkQHZnZXIu
a2VybmVsLm9yZzsgTGludXggTUlQUyBNYWlsaW5nDQo+IExpc3Q7IFJhbGYgQmFlY2hsZTsgRGFu
aWVsIFNhbmRlcnMNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbGQtdmVyc2lvbjogZml4IGl0IG9u
IEZlZG9yYQ0KPiANCj4gQ2MnaW5nIERhbmllbCwgd2hvIGhhcyBoaXQgZnVydGhlciBicmVha2Fn
ZSBkdWUgdG8gdW51c3VhbCB2ZXJzaW9uIG51bWJlcnMuDQo+IA0KPiBPbiA3IEphbnVhcnkgMjAx
NiBhdCAxNzo1NSwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
ID4gT24gRmVkb3JhIDIzLCBsZCAtLXZlcnNpb24gb3V0cHV0czoNCj4gPiBHTlUgbGQgdmVyc2lv
biAyLjI1LTE1LmZjMjMNCj4gPg0KPiA+IEJ1dCBsZC12ZXJzaW9uLnNoIGZhaWxzIHRvIHBhcnNl
IHRoaXMsIHNvIGUuZy4gIG1pcHMgYnVpbGQgZmFpbHMgdG8NCj4gPiBlbmFibGUgVkRTTywgcHJp
bnRpbmcgYSB3YXJuaW5nIHRoYXQgYmludXRpbHMgPj0gMi4yNCBpcyByZXF1aXJlZC4NCj4gPg0K
PiA+IFRvIGZpeCwgdGVhY2ggbGQtdmVyc2lvbiB0byBwYXJzZSB0aGlzIGZvcm1hdC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+
ID4gLS0tDQo+ID4NCj4gPiBXaGljaCB0cmVlIHNob3VsZCB0aGlzIGJlIG1lcmdlZCB0aHJvdWdo
PyBNaW5lPyBNSVBTPw0KPiA+DQo+ID4gIHNjcmlwdHMvbGQtdmVyc2lvbi5zaCB8IDIgKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3NjcmlwdHMvbGQtdmVyc2lvbi5zaCBiL3NjcmlwdHMvbGQtdmVyc2lvbi5zaA0KPiA+IGluZGV4
IDE5ODU4MGQuLjI1ZDIzYzggMTAwNzU1DQo+ID4gLS0tIGEvc2NyaXB0cy9sZC12ZXJzaW9uLnNo
DQo+ID4gKysrIGIvc2NyaXB0cy9sZC12ZXJzaW9uLnNoDQo+ID4gQEAgLTIsNiArMiw4IEBADQo+
ID4gICMgZXh0cmFjdCBsaW5rZXIgdmVyc2lvbiBudW1iZXIgZnJvbSBzdGRpbiBhbmQgdHVybiBp
bnRvIHNpbmdsZSBudW1iZXINCj4gPiAgICAgICAgIHsNCj4gPiAgICAgICAgIGdzdWIoIi4qKSIs
ICIiKTsNCj4gPiArICAgICAgIGdzdWIoIi4qdmVyc2lvbiAiLCAiIik7DQo+ID4gKyAgICAgICBn
c3ViKCItLioiLCAiIik7DQo+ID4gICAgICAgICBzcGxpdCgkMSxhLCAiLiIpOw0KPiA+ICAgICAg
ICAgcHJpbnQgYVsxXSoxMDAwMDAwMCArIGFbMl0qMTAwMDAwICsgYVszXSoxMDAwMCArIGFbNF0q
MTAwICsgYVs1XTsNCj4gPiAgICAgICAgIGV4aXQNCj4gPiAtLQ0KPiA+IE1TVA0KPiA+DQo=
