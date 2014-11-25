Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 12:58:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18339 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007015AbaKYL62xqewj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 12:58:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4BA9A361A9EB5;
        Tue, 25 Nov 2014 11:58:20 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 25 Nov
 2014 11:58:22 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 25 Nov 2014 11:58:22 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 25 Nov 2014 11:58:21 +0000
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Thread-Topic: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Thread-Index: AQHQCKccMjcEYR4daUCalpz7M93HyA==
Date:   Tue, 25 Nov 2014 11:58:21 +0000
Message-ID: <104ADEDC18AE5E45870C06CF0304E344A50C91@LEMAIL01.le.imgtec.org>
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
 <54736A06.9070206@gmail.com>
 <20141124191301.GC6796@fuloong-minipc.musicnaut.iki.fi>
 <20141124194611.GD6796@fuloong-minipc.musicnaut.iki.fi>
 <54738CCA.4090302@gmail.com>
In-Reply-To: <54738CCA.4090302@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

T24gTW9uLCAyMDE0LTExLTI0IGF0IDExOjUzIC0wODAwLCBEYXZpZCBEYW5leSB3cm90ZToKPiBP
biAxMS8yNC8yMDE0IDExOjQ2IEFNLCBBYXJvIEtvc2tpbmVuIHdyb3RlOgo+ID4gSGksCj4gPgo+
ID4gT24gTW9uLCBOb3YgMjQsIDIwMTQgYXQgMDk6MTM6MDFQTSArMDIwMCwgQWFybyBLb3NraW5l
biB3cm90ZToKPiA+PiBPbiBNb24sIE5vdiAyNCwgMjAxNCBhdCAwOToyNToyNkFNIC0wODAwLCBE
YXZpZCBEYW5leSB3cm90ZToKPiA+Pj4gT24gMTEvMjQvMjAxNCAwNTo1MSBBTSwgSmFtZXMgQ293
Z2lsbCB3cm90ZToKPiA+Pj4+IEZyb206IE1hcmtvcyBDaGFuZHJhcyA8bWFya29zLmNoYW5kcmFz
QGltZ3RlYy5jb20+Cj4gPj4+Pgo+ID4+Pj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBVQk5UIEUyMDAg
Ym9hcmQgKEVkZ2VSb3V0ZXIvRWRnZVJvdXRlciBQcm8gOCBwb3J0KS4KPiA+Pj4+Cj4gPj4+PiBT
aWduZWQtb2ZmLWJ5OiBNYXJrb3MgQ2hhbmRyYXMgPG1hcmtvcy5jaGFuZHJhc0BpbWd0ZWMuY29t
Pgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgQ293Z2lsbCA8SmFtZXMuQ293Z2lsbEBpbWd0
ZWMuY29tPgo+ID4+Pgo+ID4+PiBOQUNLLgo+ID4+Pgo+ID4+PiBBcyBmYXIgYXMgSSBrbm93LCB0
aGVzZSBib2FyZHMgaGF2ZSBhIGJvb3QgbG9hZGVyIHRoYXQgc3VwcGxpZXMgYSBjb3JyZWN0Cj4g
Pj4+IGRldmljZSB0cmVlLCB0aGVyZSBzaG91bGQgYmUgbm8gbmVlZCB0byBoYWNrIHVwIHRoZSBr
ZXJuZWwgbGlrZSB0aGlzLgo+ID4+Pgo+ID4+PiBBcyBmYXIgYXMgSSBrbm93LCBBbmRyZWFzIGlz
IHJ1bm5pbmcgYSBrZXJuZWwub3JnIGtlcm5lbCBvbiB0aGVzZSBib2FyZHMKPiA+Pj4gd2l0aG91
dCBhbnl0aGluZyBsaWtlIHRoaXMuCj4gPj4KPiA+PiBJdCBnZXRzIGNhbGxlZCBmcm9tIE9jdGVv
biBFdGhlcm5ldCBkcml2ZXIgdGhyb3VnaCBjdm14X2hlbHBlcl9saW5rX2dldCgpCj4gPj4gZnJl
cXVlbnRseSBzbyB0aGUgY29uc29sZSBnZXRzIHNwYW1tZWQgYWJvdXQgdW5rbm93biBib2FyZCwg
YW5kIHByb2JhYmx5Cj4gPj4gYWxzbyB0aGUgbGluayBzdGF0dXMgaXMgYm9ndXMgYXMgYSByZXN1
bHQuCj4gPgo+ID4gSnVzdCB0ZXN0ZWQgd2l0aCAzLjE4LXJjNiBhbmQgdGhpcyBiZWhhdmlvdXIg
aGFzIGJlZW4gYXBwYXJlbnRseQo+ID4gZml4ZWQgc29tZWhvdy4gQ29vbC4KPiA+Cj4gCj4gSXQg
aXMgbWFnaWMhCj4gCj4gSWYgdGhlIGtlcm5lbCBpcyBidWlsdCB3aXRoIHRoZSBwcm9wZXIgZXRo
ZXJuZXQgcGh5IGRyaXZlcnMgKmFuZCogdGhlIAo+IGRldmljZSB0cmVlIGNvbnRhaW5zIHByb3Bl
ciBwaHkgdG9wb2xvZ3kgaW5mb3JtYXRpb24sIHRoZW4gdGhlIHBoeSAKPiBkcml2ZXJzIGhhbmRs
ZSBsaW5rIG1vbml0b3JpbmcgYW5kIG5vbmUgb2YgdGhlIGN2bXgtKiBjcmFwIGlzIHVzZWQuCj4g
Cj4gU28gZm9yIGFsbCBib2FyZHMgd2l0aCBib290bG9hZGVycyB0aGF0IHN1cHBseSBhIGRldmlj
ZSB0cmVlLCB0aGVyZSAKPiBzaG91bGQgbmV2ZXIgYmUgYW55IHJlYXNvbiB0byBwYXRjaCBpbiB0
aGUgaGFja3kgYm9hcmQgaWRlbnRpZmllcnMgdG8gCj4gdGhlIGtlcm5lbCBzb3VyY2VzLgoKWWVw
IHlvdSdyZSByaWdodCAtIGV2ZXJ5dGhpbmcgZG9lcyBzZWVtIHRvIHdvcmsuIEkgdGhpbmsgSSBt
dXN0IGhhdmUKbWVzc2VkIHVwIGRpZmZlcmVudCBrZXJuZWwgdmVyc2lvbnMgb3Igc29tZXRoaW5n
IHdoZW4gSSB0ZXN0ZWQgdGhpcwpiZWZvcmUuIFNvcnJ5IGZvciB0aGUgc3BhbSwgeW91IGNhbiBp
Z25vcmUgdGhpcyBwYXRjaC4KClRoYW5rcywKSmFtZXMK
