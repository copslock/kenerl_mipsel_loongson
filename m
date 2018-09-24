Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 08:54:21 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:34808 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990757AbeIXGySG2ZJD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 08:54:18 +0200
Date:   Mon, 24 Sep 2018 08:53:57 +0200
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        od@zcrc.me, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1537772056; bh=I3s5OmNYDZIJLvF/kaBVfADADuQjzAmQqmW0/sf+h4U=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=XvG2c+NnW1KINHSgjFqR9+XeCmdrlj2lVj1Xd9R4xfdJA//Z3u16ou7g23o3BHDILcU3+2JlhYDwBuQ5dPViwydtk4ypS8rS1uY/Et52kJhgYMUvjmDS82O+j4Wd6GKtiJSkGiJ5ZFIgH+VKfIqC12sTR7XE/J5b07Q6AFPitVQ=
Message-Id: <S23990757AbeIXGySG2ZJD/20180924065418Z+449@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66498
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

CkxlIDI0IHNlcHQuIDIwMTggMDc6NTgsIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBPbiAyNC8wOS8yMDE4IDA3OjQ5LCBQYXVsIENlcmN1
ZWlsIHdyb3RlOiAKPiA+IAo+ID4gTGUgMjQgc2VwdC4gMjAxOCAwNzozNSwgRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IGEgCj4gPiDDqWNyaXQgOiAKPiA+PiAKPiA+
PiBPbiAyNC8wOS8yMDE4IDA3OjI0LCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+Pj4gSGkgRGFu
aWVsLCAKPiA+Pj4gCj4gPj4+IExlIDI0IHNlcHQuIDIwMTggMDU6MTIsIERhbmllbCBMZXpjYW5v
IAo+ID4+PiA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSDDqWNyaXQgOiAKPiA+Pj4+IAo+
ID4+Pj4gT24gMjEvMDgvMjAxOCAxOToxNiwgUGF1bCBDZXJjdWVpbCB3cm90ZTogCj4gPj4+Pj4g
VGhpcyBkcml2ZXIgaGFuZGxlcyB0aGUgVENVIChUaW1lciBDb3VudGVyIFVuaXQpIHByZXNlbnQg
b24gCj4gPj4+Pj4gdGhlIEluZ2VuaWMgSlo0N3h4IFNvQ3MsIGFuZCBwcm92aWRlcyB0aGUga2Vy
bmVsIHdpdGggYSAKPiA+Pj4+PiBzeXN0ZW0gdGltZXIsIGFuZCBvcHRpb25hbGx5IHdpdGggYSBj
bG9ja3NvdXJjZSBhbmQgYSAKPiA+Pj4+PiBzY2hlZF9jbG9jay4gCj4gPj4+Pj4gCj4gPj4+Pj4g
SXQgYWxzbyBwcm92aWRlcyBjbG9ja3MgYW5kIGludGVycnVwdCBoYW5kbGluZyB0byBjbGllbnQg
Cj4gPj4+Pj4gZHJpdmVycy4gCj4gPj4+PiAKPiA+Pj4+IENhbiB5b3UgcHJvdmlkZSBhIG11Y2gg
bW9yZSBjb21wbGV0ZSBkZXNjcmlwdGlvbiBvZiB0aGUgdGltZXIgCj4gPj4+PiBpbiBvcmRlciB0
byBtYWtlIG15IGxpZmUgZWFzaWVyIGZvciB0aGUgcmV2aWV3IG9mIHRoaXMgcGF0Y2g/IAo+ID4+
PiAKPiA+Pj4gU2VlIHBhdGNoIFswMy8yNF0sIGl0IGFkZHMgYSBkb2MgZmlsZSB0aGF0IGRlc2Ny
aWJlcyB0aGUgCj4gPj4+IGhhcmR3YXJlLiAKPiA+PiAKPiA+PiBUaGFua3MsIEkgd2VudCB0aHJv
dWdoIGJ1dCBpdCBpcyBpbmNvbXBsZXRlIHRvIHVuZGVyc3RhbmQgd2hhdCB0aGUgCj4gPj4gdGlt
ZXIgZG8uIEkgd2lsbCByZXZlcnNlLWVuZ2luZWVyIHRoZSBjb2RlIGJ1dCBpdCB3b3VsZCBoZWxw
IGlmIHlvdSAKPiA+PiBjYW4gZ2l2ZSB0aGUgZ3Jvc3MgYXBwcm9hY2guIFdoeSBtdWx0aXBsZSBj
aGFubmVscyA/IG11dGV4ZXMgYW5kIAo+ID4+IGNvbXBsZXRpb24gPyAKPiA+IAo+ID4gTXVjaCBv
ZiB0aGUgY29tcGxleGl0eSBpcyBiZWNhdXNlIG9mIHRoZSBtdWx0aS1wdXJwb3NlIG5hdHVyZSBv
ZiB0aGUgCj4gPiBUQ1UgY2hhbm5lbHMuIEVhY2ggb25lIGNhbiBiZSB1c2VkIGFzIHRpbWVyL2Ns
b2Nrc291cmNlLCBvciBQV00uIAo+ID4gCj4gPiBUaGUgZHJpdmVyIHN0YXJ0cyBieSB1c2luZyBj
aGFubmVscyAwIGFuZCAxIGFzIHN5c3RlbSB0aW1lciBhbmQgCj4gPiBjbG9ja3NvdXJjZSwgcmVz
cGVjdGl2ZWx5LCB0aGUgb3RoZXIgb25lcyBiZWluZyB1bnVzZWQgZm9yIG5vdy4gVGhlbiwgCj4g
PiAqaWYqIHRoZSBQV00gZHJpdmVyIHJlcXVlc3RzIG9uZSBvZiB0aGUgY2hhbm5lbHMgaW4gdXNl
IGJ5IHRoZSAKPiA+IHRpbWVyL2Nsb2Nrc291cmNlIGRyaXZlciwgc2F5IGNoYW5uZWwgMCwgdGhl
IHRpbWVyL2Nsb2Nrc291cmNlIGRyaXZlciAKPiA+IHdpbGwgZHluYW1pY2FsbHkgcmVhc3NpZ24g
dGhlIHN5c3RlbSB0aW1lciB0byBhIGZyZWUgY2hhbm5lbCwgZnJvbSAKPiA+IGNoYW5uZWwgMCB0
byBlLmcuIGNoYW5uZWwgMi4gT25seSBpbiB0aGF0IGNhc2UgdGhlIGNvbXBsZXRpb24vbXV0ZXgg
Cj4gPiBhcmUgYWN0dWFsbHkgdXNlZC4gCj4KPiBXaHkgZG8geW91IG5lZWQgdG8gZG8gdGhpcz8g
Q2FuJ3QgYmUgdGhlIGNoYW5uZWxzIGRlZGljYXRlZCBhbmQgcmVzZXJ2ZWQgCj4gZm9yIGNsb2Nr
c291cmNlIGFuZCBjbG9ja2V2ZW50PyAKClRoYXQncyB3aGF0IEkgaGFkIGluIHBsYWNlIChpbmdl
bmljLHRpbWVyLWNoYW5uZWwgYW5kIGluZ2VuaWMsY2xvY2tzb3VyY2UtY2hhbm5lbCBEVCBwcm9w
ZXJ0aWVzKSwgYnV0IFJvYiBkaWRuJ3Qgd2FudCBhbnkgbGludXgtc3BlY2lmaWMgcHJvcGVydGll
cyBpbiB0aGUgZGV2aWNldHJlZSBiaW5kaW5nIDooCgotUGF1bA==
