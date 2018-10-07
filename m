Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Oct 2018 21:14:40 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40676 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993030AbeJGTOh2xZYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Oct 2018 21:14:37 +0200
Date:   Sun, 07 Oct 2018 21:14:07 +0200
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU
 drivers
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, robh@kernel.org,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1538939675; bh=fnt4MJ6YPBDmbl9QXYDE1XyUACeR0yhGZtwR9KmIwWE=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=SjZcJJWVJ0ZmeaR4tZTYHMhszOE1SorhpuaQZPhHLAEA4xTIu5u+IqYFvgsIHo0YkoR8QZvJ8MvinqvSARgvaqaUdLb3JV+8wSe/nZawMdMghQLRnaU9QchOZIfdQBTSN/WbXQiFyNHOalk11wleypIs8tgeOwijbLBuQDXPnsE=
Message-Id: <S23993030AbeJGTOh2xZYe/20181007191437Z+1908@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66715
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

CkxlIDYgb2N0LiAyMDE4IDExOjIwIEFNLCBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJl
bGxvbmlAYm9vdGxpbi5jb20+IGEgw6ljcml0IDoKPgo+IE9uIDAzLzEwLzIwMTggMTI6MzI6NTEr
MDIwMCwgUGF1bCBDZXJjdWVpbCB3cm90ZTogCj4gPiAKPiA+IExlIDEgb2N0LiAyMDE4IDEwOjQ4
LCBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSDDqWNyaXQgOiAK
PiA+ID4gCj4gPiA+IE9uIDMxLzA3LzIwMTggMDA6MDEsIFBhdWwgQ2VyY3VlaWwgd3JvdGU6IAo+
ID4gPiAKPiA+ID4gWyAuLi4gXSAKPiA+ID4gCj4gPiA+ID4+PiDCoCstIGluZ2VuaWMsdGltZXIt
Y2hhbm5lbDogU3BlY2lmaWVzIHRoZSBUQ1UgY2hhbm5lbCB0aGF0IHNob3VsZCBiZSAKPiA+ID4g
Pj4+IHVzZWQgYXMgCj4gPiA+ID4+PiDCoCvCoCBzeXN0ZW0gdGltZXIuIElmIG5vdCBwcm92aWRl
ZCwgdGhlIFRDVSBjaGFubmVsIDAgaXMgdXNlZCBmb3IgdGhlIAo+ID4gPiA+Pj4gc3lzdGVtIHRp
bWVyLiAKPiA+ID4gPj4+IMKgKyAKPiA+ID4gPj4+IMKgKy0gaW5nZW5pYyxjbG9ja3NvdXJjZS1j
aGFubmVsOiBTcGVjaWZpZXMgdGhlIFRDVSBjaGFubmVsIHRoYXQgCj4gPiA+ID4+PiBzaG91bGQg
YmUgdXNlZCAKPiA+ID4gPj4+IMKgK8KgIGFzIGNsb2Nrc291cmNlIGFuZCBzY2hlZF9jbG9jay4g
SXQgbXVzdCBiZSBhIGRpZmZlcmVudCBjaGFubmVsIAo+ID4gPiA+Pj4gdGhhbiB0aGUgb25lIAo+
ID4gPiA+Pj4gwqArwqAgdXNlZCBhcyBzeXN0ZW0gdGltZXIuIElmIG5vdCBwcm92aWRlZCwgbmVp
dGhlciBhIGNsb2Nrc291cmNlIG5vciBhIAo+ID4gPiA+Pj4gwqArwqAgc2NoZWRfY2xvY2sgaXMg
aW5zdGFudGlhdGVkLiAKPiA+ID4gPj4gCj4gPiA+ID4+IGNsb2Nrc291cmNlIGFuZCBzY2hlZF9j
bG9jayBhcmUgTGludXggc3BlY2lmaWMgYW5kIGRvbid0IGJlbG9uZyBpbiBEVC4gCj4gPiA+ID4+
IFlvdSBzaG91bGQgZGVmaW5lIHByb3BlcnRpZXMgb2YgdGhlIGhhcmR3YXJlIG9yIHVzZSBleGlz
dGluZyBwcm9wZXJ0aWVzIAo+ID4gPiA+PiBsaWtlIGludGVycnVwdHMgb3IgY2xvY2tzIHRvIGZp
Z3VyZSBvdXQgd2hpY2ggY2hhbm5lbCB0byB1c2UuIEZvciAKPiA+ID4gPj4gZXhhbXBsZSwgaWYg
c29tZSBjaGFubmVscyBkb24ndCBoYXZlIGFuIGludGVycnVwdCwgdGhlbiB1c2UgdGhlbSBmb3Ig
Cj4gPiA+ID4+IGNsb2Nrc291cmNlIGFuZCBub3QgYSBjbG9ja2V2ZW50LiBPciB5b3UgY291bGQg
aGF2ZSB0aW1lcnMgdGhhdCBydW4gaW4gCj4gPiA+ID4+IGxvdy1wb3dlciBtb2RlcyBvciBub3Qu
IElmIGFsbCB0aGUgY2hhbm5lbHMgYXJlIGlkZW50aWNhbCwgdGhlbiBpdCAKPiA+ID4gPj4gc2hv
dWxkbid0IG1hdHRlciB3aGljaCBvbmVzIHRoZSBPUyBwaWNrcy4gCj4gPiA+IAo+ID4gPiBJdCBj
YW4ndCB3b3JrIGluIHRoaXMgY2FzZSBiZWNhdXNlIHRoZSBwbXcgYW5kIHRoZSB0aW1lciBkcml2
ZXIgYXJlIG5vdCAKPiA+ID4gY29tbXVuaWNhdGluZyBhbmQgdGhlIGZpcnN0IG9uZSBjYW4gc3Rv
bGUgYSBjaGFubmVsIHRvIHRoZSBsYXN0IG9uZS4gCj4gPiAKPiA+IEluIHRoYXQgcGFydGljdWxh
ciBjYXNlIHRoZSB0aW1lciBkcml2ZXIgd2lsbCBhbHdheXMgcmVxdWVzdCBpdHMgY2hhbm5lbHMg
Zmlyc3Q7IHdpdGggbm8gdGltZXIgc2V0IHRoZSBzeXN0ZW0gaGFuZ3MgYmVmb3JlIHN1YnN5c19p
bml0Y2FsbCwgYW5kIHRoZSBQV00gZHJpdmVyIGlzIGEgc3Vibm9kZSBvZiB0aGUgdGltZXIgbm9k
ZSwgc28gaXMgcHJvYmVkIG9ubHkgYWZ0ZXIgdGhlIHRpbWVyIHByb2JlZC4gCj4gPiAKPiA+ID4g
PiBXZSBhbHJlYWR5IHRhbGtlZCBhYm91dCB0aGF0LiBBbGwgdGhlIFRDVSBjaGFubmVscyBjYW4g
YmUgdXNlZCBmb3IgUFdNLiAKPiA+ID4gPiBUaGUgcHJvYmxlbSBpcyBJIGNhbm5vdCBrbm93IGZy
b20gdGhlIGRyaXZlcidzIHNjb3BlIHdoaWNoIGNoYW5uZWxzIHdpbGwgCj4gPiA+ID4gYmUgZnJl
ZSBhbmQgd2hpY2ggY2hhbm5lbHMgd2lsbCBiZSByZXF1ZXN0ZWQgZm9yIFBXTS4gWW91IHN1Z2dl
c3RlZCB0aGF0IEkgCj4gPiA+ID4gcGFyc2UgdGhlIGRldmljZXRyZWUgZm9yIGNsaWVudHMsIGFu
ZCBJIGRpZCB0aGF0IGluIHRoZSBWMy9WNCBwYXRjaHNldC4gQnV0IAo+ID4gPiA+IGl0IG9ubHkg
d29ya3MgZm9yIGNsaWVudHMgcmVxdWVzdGluZyB0aHJvdWdoIGRldmljZXRyZWUsIG5vdCBmcm9t
IHBsYXRmb3JtIAo+ID4gPiA+IGNvZGUgb3IgZXZlbiBzeXNmcy4gCj4gPiA+ID4gCj4gPiA+ID4g
T25lIHRoaW5nIEkgY2FuIHRyeSBpcyB0byBkeW5hbWljYWxseSBjaGFuZ2UgdGhlIGNoYW5uZWxz
IHRoZSBzeXN0ZW0gdGltZXIgCj4gPiA+ID4gYW5kIGNsb2Nrc291cmNlIGFyZSB1c2luZyB3aGVu
IHRoZSBjdXJyZW50IG9uZXMgYXJlIHJlcXVlc3RlZCBmb3IgUFdNLiBCdXQgCj4gPiA+ID4gdGhh
dCBzb3VuZHMgaGFyZGNvcmUuLi4gCj4gPiA+IAo+ID4gPiBZZXMsIGl0IGlzIDovIAo+ID4gPiAK
PiA+ID4gU29ycnkgZm9yIGxldHRpbmcgeW91IHdhc3RpbmcgdGltZSBhbmQgZWZmb3J0IHRvIHdy
aXRlIGFuIG92ZXJraWxsIGNvZGUgCj4gPiA+IG5vdCBzdWl0YWJsZSBmb3IgdXBzdHJlYW0uIAo+
ID4gPiAKPiA+ID4gQSB2ZXJ5IGdyb3NzIHRob3VnaHQsIHdvdWxkbid0IGJlIHBvc3NpYmxlIHRv
ICJyZWdpc3RlciIgYSBjaGFubmVsIGZyb20gCj4gPiA+IHRoZSB0aW1lciBkcml2ZXIgY29kZSBp
biBhIHNoYXJlZCBkYXRhIGFyZWEgKGJ1dCB3ZWxsIHNlbGYtZW5jYXBzdWxhdGVkKSAKPiA+ID4g
YW5kIHRoZSBwd20gY29kZSB3aWxsIGNoZWNrIHN1Y2ggY2hhbm5lbCBpc24ndCBpbiB1c2UgPyAK
PiA+IAo+ID4gUHJvYmFibHksIGJ1dCBpdCdzIHRoZSBjb250cmFyeSBJIG5lZWQgdG8gZG8uIFRo
ZSB0aW1lciBkcml2ZXIgY29kZSBjYW4gdXNlIGFueSBjaGFubmVsLCBhbmQgcHJvYmVzIGZpcnN0
LiBUaGUgUFdNIGRyaXZlciBjb2RlIG11c3QgdXNlIHNwZWNpZmljIGNoYW5uZWxzLCBhbmQgcHJv
YmVzIGxhc3QuIFNvIGVpdGhlciB0aGUgdGltZXIgZHJpdmVyIGtub3dzIHdoYXQgY2hhbm5lbHMg
aXQgY2FuJ3QgdXNlLCB0aGFua3MgdG8gYSBkZXZpY2UgcHJvcGVydHksIG9yIGl0IGFkYXB0cyBp
dHNlbGYgd2hlbiBhIGNoYW5uZWwgaW4gdXNlIGlzIHJlcXVlc3RlZCBmb3IgUFdNLCB3aGljaCBp
cyB3aGF0IEkgdHJpZWQgaW4gdjcuIAo+ID4gCj4gPiBJIHRoaW5rIHdlIGNvdWxkIGZpbmQgYSB3
YXkgdG8gdXNlIGEgZGV2aWNldHJlZSBwcm9wZXJ0eSB0aGF0IGRvZXNuJ3QgdHJpZ2dlciBSb2Iu
IFRoYXQgd291bGQgc3RpbGwgYmUgdGhlIGVhc2llc3QgYW5kIGNsZWFuZXN0IHNvbHV0aW9uLiAK
PiA+IAo+ID4gTWF5YmUgImluZ2VuaWMscmVzZXJ2ZWQtY2hhbm5lbHMtbWFzayIsIHdoaWNoIHdv
dWxkIGNvbnRhaW4gYSBtYXNrIG9mIGNoYW5uZWxzIHRoYXQgY2FuIG9ubHkgYmUgdXNlZCBieSB0
aGUgdGltZXIgZHJpdmVyLiBBbmQgd2hhdCB0aGUgdGltZXIgZHJpdmVyIGRvZXMgd2l0aCB0aGVz
ZSBjaGFubmVscywgd291bGQgYmUgc3BlY2lmaWMgdG8gdGhlIGltcGxlbWVudGF0aW9uIGFuZCB3
b3VsZCBub3QgYXBwZWFyIGluIHRoZSBiaW5kaW5ncy4gSSBob3BlIFJvYiBjYW4gd29yayB3aXRo
IHRoYXQuIAo+ID4gCj4KPiBSb2IgZGlkIGFjayB0aGUgZm9sbG93aW5nIGJpbmRpbmc6IAo+Cj4g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1l
bC10Y2IudHh0IAo+Cj4gYW5vdGhlciBzdWJkZXZpY2UgaXMgYSBQV00gKG5vdCBkb2N1bWVudGVk
IGhlcmUpLiAKCkknbSBub3Qgc3VyZSB0aGF0IGl0IHdvdWxkIGJlIHRoZSBjbGVhbmVzdCBpbiBt
eSBjYXNlLCBteSBQV00gYW5kIHdhdGNoZG9nIHN1Yi1ub2RlcyBhbHJlYWR5IHNwZWNpZnkgbWVt
b3J5IHJlc291cmNlcyBpbiB0aGVpciAicmVnIiBwcm9wZXJ0eS4gQW5kIGlmIEkgYWRkIG1lbW9y
eSByZXNvdXJjZXMgdG8gdGhlIHNhbWUgInRpbWVycyIgc3ViLW5vZGVzIGFzIGluIHlvdXIgZXhh
bXBsZSwgdGhlIHJhbmdlcyB3aWxsIG92ZXJsYXAgYW5kIFJvYiBzdGlsbCB3b24ndCBiZSBoYXBw
eSA6KQoKLVBhdWw=
