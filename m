Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 16:01:16 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59490 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990434AbeIYOBMlL6Bu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 16:01:12 +0200
Date:   Tue, 25 Sep 2018 15:38:35 +0200
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, od@zcrc.me,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1537884071; bh=CDczmZaAaQF0jT1Eq5AWCYcS9WssS2/ck0xWvHWlMYQ=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KS1QK4ePXPmbwv+qKq2iw5ItF8ROeR2/FYtpEcRH2Z8lk5qVuOx5SKKfQixf+u7YXQ/RKsQkBEBGc/6GkVgJgQvbYMBSbfeA9ugV3uBM+eS7GwOusPa7EvpHAHvjXjVaAUqRm+gsRAyJRhCVKc4GMZQVbPg7f0bf9uaJyQUmEBw=
Message-Id: <S23990434AbeIYOBMlL6Bu/20180925140112Z+681@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66548
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

CkxlIDI0IHNlcHQuIDIwMTggOToxNCBBTSwgRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc+IGEgw6ljcml0IDoKPgo+IE9uIDI0LzA5LzIwMTggMDg6NTMsIFBhdWwgQ2Vy
Y3VlaWwgd3JvdGU6IAo+ID4gCj4gPiBMZSAyNCBzZXB0LiAyMDE4IDA3OjU4LCBEYW5pZWwgTGV6
Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSDDqWNyaXQgOiAKPiA+PiAKPiA+PiBP
biAyNC8wOS8yMDE4IDA3OjQ5LCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+Pj4gCj4gPj4+IExl
IDI0IHNlcHQuIDIwMTggMDc6MzUsIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5h
cm8ub3JnPiBhIAo+ID4+PiDDqWNyaXQgOiAKPiA+Pj4+IAo+ID4+Pj4gT24gMjQvMDkvMjAxOCAw
NzoyNCwgUGF1bCBDZXJjdWVpbCB3cm90ZTogCj4gPj4+Pj4gSGkgRGFuaWVsLCAKPiA+Pj4+PiAK
PiA+Pj4+PiBMZSAyNCBzZXB0LiAyMDE4IDA1OjEyLCBEYW5pZWwgTGV6Y2FubyAKPiA+Pj4+PiA8
ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSDDqWNyaXQgOiAKPiA+Pj4+Pj4gCj4gPj4+Pj4+
IE9uIDIxLzA4LzIwMTggMTk6MTYsIFBhdWwgQ2VyY3VlaWwgd3JvdGU6IAo+ID4+Pj4+Pj4gVGhp
cyBkcml2ZXIgaGFuZGxlcyB0aGUgVENVIChUaW1lciBDb3VudGVyIFVuaXQpIHByZXNlbnQgb24g
Cj4gPj4+Pj4+PiB0aGUgSW5nZW5pYyBKWjQ3eHggU29DcywgYW5kIHByb3ZpZGVzIHRoZSBrZXJu
ZWwgd2l0aCBhIAo+ID4+Pj4+Pj4gc3lzdGVtIHRpbWVyLCBhbmQgb3B0aW9uYWxseSB3aXRoIGEg
Y2xvY2tzb3VyY2UgYW5kIGEgCj4gPj4+Pj4+PiBzY2hlZF9jbG9jay4gCj4gPj4+Pj4+PiAKPiA+
Pj4+Pj4+IEl0IGFsc28gcHJvdmlkZXMgY2xvY2tzIGFuZCBpbnRlcnJ1cHQgaGFuZGxpbmcgdG8g
Y2xpZW50IAo+ID4+Pj4+Pj4gZHJpdmVycy4gCj4gPj4+Pj4+IAo+ID4+Pj4+PiBDYW4geW91IHBy
b3ZpZGUgYSBtdWNoIG1vcmUgY29tcGxldGUgZGVzY3JpcHRpb24gb2YgdGhlIHRpbWVyIAo+ID4+
Pj4+PiBpbiBvcmRlciB0byBtYWtlIG15IGxpZmUgZWFzaWVyIGZvciB0aGUgcmV2aWV3IG9mIHRo
aXMgcGF0Y2g/IAo+ID4+Pj4+IAo+ID4+Pj4+IFNlZSBwYXRjaCBbMDMvMjRdLCBpdCBhZGRzIGEg
ZG9jIGZpbGUgdGhhdCBkZXNjcmliZXMgdGhlIAo+ID4+Pj4+IGhhcmR3YXJlLiAKPiA+Pj4+IAo+
ID4+Pj4gVGhhbmtzLCBJIHdlbnQgdGhyb3VnaCBidXQgaXQgaXMgaW5jb21wbGV0ZSB0byB1bmRl
cnN0YW5kIHdoYXQgdGhlIAo+ID4+Pj4gdGltZXIgZG8uIEkgd2lsbCByZXZlcnNlLWVuZ2luZWVy
IHRoZSBjb2RlIGJ1dCBpdCB3b3VsZCBoZWxwIGlmIHlvdSAKPiA+Pj4+IGNhbiBnaXZlIHRoZSBn
cm9zcyBhcHByb2FjaC4gV2h5IG11bHRpcGxlIGNoYW5uZWxzID8gbXV0ZXhlcyBhbmQgCj4gPj4+
PiBjb21wbGV0aW9uID8gCj4gPj4+IAo+ID4+PiBNdWNoIG9mIHRoZSBjb21wbGV4aXR5IGlzIGJl
Y2F1c2Ugb2YgdGhlIG11bHRpLXB1cnBvc2UgbmF0dXJlIG9mIHRoZSAKPiA+Pj4gVENVIGNoYW5u
ZWxzLiBFYWNoIG9uZSBjYW4gYmUgdXNlZCBhcyB0aW1lci9jbG9ja3NvdXJjZSwgb3IgUFdNLiAK
PiA+Pj4gCj4gPj4+IFRoZSBkcml2ZXIgc3RhcnRzIGJ5IHVzaW5nIGNoYW5uZWxzIDAgYW5kIDEg
YXMgc3lzdGVtIHRpbWVyIGFuZCAKPiA+Pj4gY2xvY2tzb3VyY2UsIHJlc3BlY3RpdmVseSwgdGhl
IG90aGVyIG9uZXMgYmVpbmcgdW51c2VkIGZvciBub3cuIFRoZW4sIAo+ID4+PiAqaWYqIHRoZSBQ
V00gZHJpdmVyIHJlcXVlc3RzIG9uZSBvZiB0aGUgY2hhbm5lbHMgaW4gdXNlIGJ5IHRoZSAKPiA+
Pj4gdGltZXIvY2xvY2tzb3VyY2UgZHJpdmVyLCBzYXkgY2hhbm5lbCAwLCB0aGUgdGltZXIvY2xv
Y2tzb3VyY2UgZHJpdmVyIAo+ID4+PiB3aWxsIGR5bmFtaWNhbGx5IHJlYXNzaWduIHRoZSBzeXN0
ZW0gdGltZXIgdG8gYSBmcmVlIGNoYW5uZWwsIGZyb20gCj4gPj4+IGNoYW5uZWwgMCB0byBlLmcu
IGNoYW5uZWwgMi4gT25seSBpbiB0aGF0IGNhc2UgdGhlIGNvbXBsZXRpb24vbXV0ZXggCj4gPj4+
IGFyZSBhY3R1YWxseSB1c2VkLiAKPiA+PiAKPiA+PiBXaHkgZG8geW91IG5lZWQgdG8gZG8gdGhp
cz8gQ2FuJ3QgYmUgdGhlIGNoYW5uZWxzIGRlZGljYXRlZCBhbmQgcmVzZXJ2ZWQgCj4gPj4gZm9y
IGNsb2Nrc291cmNlIGFuZCBjbG9ja2V2ZW50PyAKPiA+IAo+ID4gVGhhdCdzIHdoYXQgSSBoYWQg
aW4gcGxhY2UgKGluZ2VuaWMsdGltZXItY2hhbm5lbCBhbmQgaW5nZW5pYyxjbG9ja3NvdXJjZS1j
aGFubmVsIERUIHByb3BlcnRpZXMpLCBidXQgUm9iIGRpZG4ndCB3YW50IGFueSBsaW51eC1zcGVj
aWZpYyBwcm9wZXJ0aWVzIGluIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmcgOiggCj4KPiBJc24ndCBw
b3NzaWJsZSB0byBzcGVjaWZ5IHRoZSBjaGFubmVsIHRvIHVzZSBpbiB0aGUgRFQ/IGxpa2UgcmVu
ZXNhczE2ID8gCgpUaGF0J3Mgd2hhdCBJIGRpZCBpbiBWNiAoYW5kIGJlZm9yZSksIGJ1dCBSb2Ig
ZGlkIG5vdCB3YW50IG1lIHRvIGFkZCBwcm9wZXJ0aWVzIGZvciBMaW51eC1zcGVjaWZpYyBjb25j
ZXB0cyBzdWNoIGFzIGNsb2Nrc291cmNlLgoKLVBhdWw=
