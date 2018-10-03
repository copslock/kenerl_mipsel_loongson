Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2018 12:39:54 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:56744 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990757AbeJCKjwPaYBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2018 12:39:52 +0200
Date:   Wed, 03 Oct 2018 12:32:51 +0200
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU
 drivers
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, robh@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1538563191; bh=oiZ8SPzBg3lk5I6HWs/Gbwfc2mjKpzxxqVw6C4m6wNw=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Y8Gz5iEqiJ8xGOzuRFP3b0NBOJAUYf9+wULnUkscelwd0yMHiTYxv7ZBNPkP/RNllqXDViu4GIQgBq4knjjegLduZZq+CiPDBcY+6B/zYbgIEQus/79n7B/VwEJYL5X6VuKmTs3uepL1pGdIpBm2Is3Q2IQ8nu42POLpfmgjhfg=
Message-Id: <S23990757AbeJCKjwPaYBe/20181003103952Z+1106@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

CkxlIDEgb2N0LiAyMDE4IDEwOjQ4LCBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4gYSDDqWNyaXQgOgo+Cj4gT24gMzEvMDcvMjAxOCAwMDowMSwgUGF1bCBDZXJjdWVp
bCB3cm90ZTogCj4KPiBbIC4uLiBdIAo+Cj4gPj4+IMKgKy0gaW5nZW5pYyx0aW1lci1jaGFubmVs
OiBTcGVjaWZpZXMgdGhlIFRDVSBjaGFubmVsIHRoYXQgc2hvdWxkIGJlIAo+ID4+PiB1c2VkIGFz
IAo+ID4+PiDCoCvCoCBzeXN0ZW0gdGltZXIuIElmIG5vdCBwcm92aWRlZCwgdGhlIFRDVSBjaGFu
bmVsIDAgaXMgdXNlZCBmb3IgdGhlIAo+ID4+PiBzeXN0ZW0gdGltZXIuIAo+ID4+PiDCoCsgCj4g
Pj4+IMKgKy0gaW5nZW5pYyxjbG9ja3NvdXJjZS1jaGFubmVsOiBTcGVjaWZpZXMgdGhlIFRDVSBj
aGFubmVsIHRoYXQgCj4gPj4+IHNob3VsZCBiZSB1c2VkIAo+ID4+PiDCoCvCoCBhcyBjbG9ja3Nv
dXJjZSBhbmQgc2NoZWRfY2xvY2suIEl0IG11c3QgYmUgYSBkaWZmZXJlbnQgY2hhbm5lbCAKPiA+
Pj4gdGhhbiB0aGUgb25lIAo+ID4+PiDCoCvCoCB1c2VkIGFzIHN5c3RlbSB0aW1lci4gSWYgbm90
IHByb3ZpZGVkLCBuZWl0aGVyIGEgY2xvY2tzb3VyY2Ugbm9yIGEgCj4gPj4+IMKgK8KgIHNjaGVk
X2Nsb2NrIGlzIGluc3RhbnRpYXRlZC4gCj4gPj4gCj4gPj4gY2xvY2tzb3VyY2UgYW5kIHNjaGVk
X2Nsb2NrIGFyZSBMaW51eCBzcGVjaWZpYyBhbmQgZG9uJ3QgYmVsb25nIGluIERULiAKPiA+PiBZ
b3Ugc2hvdWxkIGRlZmluZSBwcm9wZXJ0aWVzIG9mIHRoZSBoYXJkd2FyZSBvciB1c2UgZXhpc3Rp
bmcgcHJvcGVydGllcyAKPiA+PiBsaWtlIGludGVycnVwdHMgb3IgY2xvY2tzIHRvIGZpZ3VyZSBv
dXQgd2hpY2ggY2hhbm5lbCB0byB1c2UuIEZvciAKPiA+PiBleGFtcGxlLCBpZiBzb21lIGNoYW5u
ZWxzIGRvbid0IGhhdmUgYW4gaW50ZXJydXB0LCB0aGVuIHVzZSB0aGVtIGZvciAKPiA+PiBjbG9j
a3NvdXJjZSBhbmQgbm90IGEgY2xvY2tldmVudC4gT3IgeW91IGNvdWxkIGhhdmUgdGltZXJzIHRo
YXQgcnVuIGluIAo+ID4+IGxvdy1wb3dlciBtb2RlcyBvciBub3QuIElmIGFsbCB0aGUgY2hhbm5l
bHMgYXJlIGlkZW50aWNhbCwgdGhlbiBpdCAKPiA+PiBzaG91bGRuJ3QgbWF0dGVyIHdoaWNoIG9u
ZXMgdGhlIE9TIHBpY2tzLiAKPgo+IEl0IGNhbid0IHdvcmsgaW4gdGhpcyBjYXNlIGJlY2F1c2Ug
dGhlIHBtdyBhbmQgdGhlIHRpbWVyIGRyaXZlciBhcmUgbm90IAo+IGNvbW11bmljYXRpbmcgYW5k
IHRoZSBmaXJzdCBvbmUgY2FuIHN0b2xlIGEgY2hhbm5lbCB0byB0aGUgbGFzdCBvbmUuIAoKSW4g
dGhhdCBwYXJ0aWN1bGFyIGNhc2UgdGhlIHRpbWVyIGRyaXZlciB3aWxsIGFsd2F5cyByZXF1ZXN0
IGl0cyBjaGFubmVscyBmaXJzdDsgd2l0aCBubyB0aW1lciBzZXQgdGhlIHN5c3RlbSBoYW5ncyBi
ZWZvcmUgc3Vic3lzX2luaXRjYWxsLCBhbmQgdGhlIFBXTSBkcml2ZXIgaXMgYSBzdWJub2RlIG9m
IHRoZSB0aW1lciBub2RlLCBzbyBpcyBwcm9iZWQgb25seSBhZnRlciB0aGUgdGltZXIgcHJvYmVk
LgoKPiA+IFdlIGFscmVhZHkgdGFsa2VkIGFib3V0IHRoYXQuIEFsbCB0aGUgVENVIGNoYW5uZWxz
IGNhbiBiZSB1c2VkIGZvciBQV00uIAo+ID4gVGhlIHByb2JsZW0gaXMgSSBjYW5ub3Qga25vdyBm
cm9tIHRoZSBkcml2ZXIncyBzY29wZSB3aGljaCBjaGFubmVscyB3aWxsIAo+ID4gYmUgZnJlZSBh
bmQgd2hpY2ggY2hhbm5lbHMgd2lsbCBiZSByZXF1ZXN0ZWQgZm9yIFBXTS4gWW91IHN1Z2dlc3Rl
ZCB0aGF0IEkgCj4gPiBwYXJzZSB0aGUgZGV2aWNldHJlZSBmb3IgY2xpZW50cywgYW5kIEkgZGlk
IHRoYXQgaW4gdGhlIFYzL1Y0IHBhdGNoc2V0LiBCdXQgCj4gPiBpdCBvbmx5IHdvcmtzIGZvciBj
bGllbnRzIHJlcXVlc3RpbmcgdGhyb3VnaCBkZXZpY2V0cmVlLCBub3QgZnJvbSBwbGF0Zm9ybSAK
PiA+IGNvZGUgb3IgZXZlbiBzeXNmcy4gCj4gPiAKPiA+IE9uZSB0aGluZyBJIGNhbiB0cnkgaXMg
dG8gZHluYW1pY2FsbHkgY2hhbmdlIHRoZSBjaGFubmVscyB0aGUgc3lzdGVtIHRpbWVyIAo+ID4g
YW5kIGNsb2Nrc291cmNlIGFyZSB1c2luZyB3aGVuIHRoZSBjdXJyZW50IG9uZXMgYXJlIHJlcXVl
c3RlZCBmb3IgUFdNLiBCdXQgCj4gPiB0aGF0IHNvdW5kcyBoYXJkY29yZS4uLiAKPgo+IFllcywg
aXQgaXMgOi8gCj4KPiBTb3JyeSBmb3IgbGV0dGluZyB5b3Ugd2FzdGluZyB0aW1lIGFuZCBlZmZv
cnQgdG8gd3JpdGUgYW4gb3ZlcmtpbGwgY29kZSAKPiBub3Qgc3VpdGFibGUgZm9yIHVwc3RyZWFt
LiAKPgo+IEEgdmVyeSBncm9zcyB0aG91Z2h0LCB3b3VsZG4ndCBiZSBwb3NzaWJsZSB0byAicmVn
aXN0ZXIiIGEgY2hhbm5lbCBmcm9tIAo+IHRoZSB0aW1lciBkcml2ZXIgY29kZSBpbiBhIHNoYXJl
ZCBkYXRhIGFyZWEgKGJ1dCB3ZWxsIHNlbGYtZW5jYXBzdWxhdGVkKSAKPiBhbmQgdGhlIHB3bSBj
b2RlIHdpbGwgY2hlY2sgc3VjaCBjaGFubmVsIGlzbid0IGluIHVzZSA/IAoKUHJvYmFibHksIGJ1
dCBpdCdzIHRoZSBjb250cmFyeSBJIG5lZWQgdG8gZG8uIFRoZSB0aW1lciBkcml2ZXIgY29kZSBj
YW4gdXNlIGFueSBjaGFubmVsLCBhbmQgcHJvYmVzIGZpcnN0LiBUaGUgUFdNIGRyaXZlciBjb2Rl
IG11c3QgdXNlIHNwZWNpZmljIGNoYW5uZWxzLCBhbmQgcHJvYmVzIGxhc3QuIFNvIGVpdGhlciB0
aGUgdGltZXIgZHJpdmVyIGtub3dzIHdoYXQgY2hhbm5lbHMgaXQgY2FuJ3QgdXNlLCB0aGFua3Mg
dG8gYSBkZXZpY2UgcHJvcGVydHksIG9yIGl0IGFkYXB0cyBpdHNlbGYgd2hlbiBhIGNoYW5uZWwg
aW4gdXNlIGlzIHJlcXVlc3RlZCBmb3IgUFdNLCB3aGljaCBpcyB3aGF0IEkgdHJpZWQgaW4gdjcu
CgpJIHRoaW5rIHdlIGNvdWxkIGZpbmQgYSB3YXkgdG8gdXNlIGEgZGV2aWNldHJlZSBwcm9wZXJ0
eSB0aGF0IGRvZXNuJ3QgdHJpZ2dlciBSb2IuIFRoYXQgd291bGQgc3RpbGwgYmUgdGhlIGVhc2ll
c3QgYW5kIGNsZWFuZXN0IHNvbHV0aW9uLiAKCk1heWJlICJpbmdlbmljLHJlc2VydmVkLWNoYW5u
ZWxzLW1hc2siLCB3aGljaCB3b3VsZCBjb250YWluIGEgbWFzayBvZiBjaGFubmVscyB0aGF0IGNh
biBvbmx5IGJlIHVzZWQgYnkgdGhlIHRpbWVyIGRyaXZlci4gQW5kIHdoYXQgdGhlIHRpbWVyIGRy
aXZlciBkb2VzIHdpdGggdGhlc2UgY2hhbm5lbHMsIHdvdWxkIGJlIHNwZWNpZmljIHRvIHRoZSBp
bXBsZW1lbnRhdGlvbiBhbmQgd291bGQgbm90IGFwcGVhciBpbiB0aGUgYmluZGluZ3MuIEkgaG9w
ZSBSb2IgY2FuIHdvcmsgd2l0aCB0aGF0LgoKLVBhdWw=
