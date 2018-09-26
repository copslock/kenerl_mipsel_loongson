Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 09:07:19 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:49150 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990393AbeIZHHQAfnlt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 09:07:16 +0200
Date:   Wed, 26 Sep 2018 08:01:03 +0200
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1537945634; bh=LQXapE9YDbJqDuIoIRAkwR+2Lh0rEuYfZEpHFWjyx9I=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KfgpS8zYow+k73lyYDbWs9jmw6qAjk6gN0wH9VlrRPYd/CzKbCjwSAcTGUoCGjaKlyAfofsf0WGPBhWp4jyGr3OFG7W222ceQ4ndB/5hgMNAe37pwbDOl0tQosfX8IsZpO6vvAtyoMpMHIUYN3w188CPaKlo+SbB53Ft+WNQSNg=
Message-Id: <S23990393AbeIZHHQAfnlt/20180926070716Z+817@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66564
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

CkxlIDI1IHNlcHQuIDIwMTggMTA6MTIgUE0sIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fu
b0BsaW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBPbiAyNS8wOS8yMDE4IDE1OjM4LCBQYXVsIENl
cmN1ZWlsIHdyb3RlOiAKPiA+IAo+ID4gTGUgMjQgc2VwdC4gMjAxOCA5OjE0IEFNLCBEYW5pZWwg
TGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSDDqWNyaXQgOiAKPiA+PiAKPiA+
PiBPbiAyNC8wOS8yMDE4IDA4OjUzLCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+Pj4gCj4gPj4+
IExlIDI0IHNlcHQuIDIwMTggMDc6NTgsIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPiBhIMOpY3JpdCA6IAo+ID4+Pj4gCj4gPj4+PiBPbiAyNC8wOS8yMDE4IDA3OjQ5
LCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+Pj4+PiAKPiA+Pj4+PiBMZSAyNCBzZXB0LiAyMDE4
IDA3OjM1LCBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSAKPiA+
Pj4+PiDDqWNyaXQgOiAKPiA+Pj4+Pj4gCj4gPj4+Pj4+IE9uIDI0LzA5LzIwMTggMDc6MjQsIFBh
dWwgQ2VyY3VlaWwgd3JvdGU6IAo+ID4+Pj4+Pj4gSGkgRGFuaWVsLCAKPiA+Pj4+Pj4+IAo+ID4+
Pj4+Pj4gTGUgMjQgc2VwdC4gMjAxOCAwNToxMiwgRGFuaWVsIExlemNhbm8gCj4gPj4+Pj4+PiA8
ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gYSDDqWNyaXQgOiAKPiA+Pj4+Pj4+PiAKPiA+Pj4+
Pj4+PiBPbiAyMS8wOC8yMDE4IDE5OjE2LCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+Pj4+Pj4+
Pj4gVGhpcyBkcml2ZXIgaGFuZGxlcyB0aGUgVENVIChUaW1lciBDb3VudGVyIFVuaXQpIHByZXNl
bnQgb24gCj4gPj4+Pj4+Pj4+IHRoZSBJbmdlbmljIEpaNDd4eCBTb0NzLCBhbmQgcHJvdmlkZXMg
dGhlIGtlcm5lbCB3aXRoIGEgCj4gPj4+Pj4+Pj4+IHN5c3RlbSB0aW1lciwgYW5kIG9wdGlvbmFs
bHkgd2l0aCBhIGNsb2Nrc291cmNlIGFuZCBhIAo+ID4+Pj4+Pj4+PiBzY2hlZF9jbG9jay4gCj4g
Pj4+Pj4+Pj4+IAo+ID4+Pj4+Pj4+PiBJdCBhbHNvIHByb3ZpZGVzIGNsb2NrcyBhbmQgaW50ZXJy
dXB0IGhhbmRsaW5nIHRvIGNsaWVudCAKPiA+Pj4+Pj4+Pj4gZHJpdmVycy4gCj4gPj4+Pj4+Pj4g
Cj4gPj4+Pj4+Pj4gQ2FuIHlvdSBwcm92aWRlIGEgbXVjaCBtb3JlIGNvbXBsZXRlIGRlc2NyaXB0
aW9uIG9mIHRoZSB0aW1lciAKPiA+Pj4+Pj4+PiBpbiBvcmRlciB0byBtYWtlIG15IGxpZmUgZWFz
aWVyIGZvciB0aGUgcmV2aWV3IG9mIHRoaXMgcGF0Y2g/IAo+ID4+Pj4+Pj4gCj4gPj4+Pj4+PiBT
ZWUgcGF0Y2ggWzAzLzI0XSwgaXQgYWRkcyBhIGRvYyBmaWxlIHRoYXQgZGVzY3JpYmVzIHRoZSAK
PiA+Pj4+Pj4+IGhhcmR3YXJlLiAKPiA+Pj4+Pj4gCj4gPj4+Pj4+IFRoYW5rcywgSSB3ZW50IHRo
cm91Z2ggYnV0IGl0IGlzIGluY29tcGxldGUgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSAKPiA+Pj4+
Pj4gdGltZXIgZG8uIEkgd2lsbCByZXZlcnNlLWVuZ2luZWVyIHRoZSBjb2RlIGJ1dCBpdCB3b3Vs
ZCBoZWxwIGlmIHlvdSAKPiA+Pj4+Pj4gY2FuIGdpdmUgdGhlIGdyb3NzIGFwcHJvYWNoLiBXaHkg
bXVsdGlwbGUgY2hhbm5lbHMgPyBtdXRleGVzIGFuZCAKPiA+Pj4+Pj4gY29tcGxldGlvbiA/IAo+
ID4+Pj4+IAo+ID4+Pj4+IE11Y2ggb2YgdGhlIGNvbXBsZXhpdHkgaXMgYmVjYXVzZSBvZiB0aGUg
bXVsdGktcHVycG9zZSBuYXR1cmUgb2YgdGhlIAo+ID4+Pj4+IFRDVSBjaGFubmVscy4gRWFjaCBv
bmUgY2FuIGJlIHVzZWQgYXMgdGltZXIvY2xvY2tzb3VyY2UsIG9yIFBXTS4gCj4gPj4+Pj4gCj4g
Pj4+Pj4gVGhlIGRyaXZlciBzdGFydHMgYnkgdXNpbmcgY2hhbm5lbHMgMCBhbmQgMSBhcyBzeXN0
ZW0gdGltZXIgYW5kIAo+ID4+Pj4+IGNsb2Nrc291cmNlLCByZXNwZWN0aXZlbHksIHRoZSBvdGhl
ciBvbmVzIGJlaW5nIHVudXNlZCBmb3Igbm93LiBUaGVuLCAKPiA+Pj4+PiAqaWYqIHRoZSBQV00g
ZHJpdmVyIHJlcXVlc3RzIG9uZSBvZiB0aGUgY2hhbm5lbHMgaW4gdXNlIGJ5IHRoZSAKPiA+Pj4+
PiB0aW1lci9jbG9ja3NvdXJjZSBkcml2ZXIsIHNheSBjaGFubmVsIDAsIHRoZSB0aW1lci9jbG9j
a3NvdXJjZSBkcml2ZXIgCj4gPj4+Pj4gd2lsbCBkeW5hbWljYWxseSByZWFzc2lnbiB0aGUgc3lz
dGVtIHRpbWVyIHRvIGEgZnJlZSBjaGFubmVsLCBmcm9tIAo+ID4+Pj4+IGNoYW5uZWwgMCB0byBl
LmcuIGNoYW5uZWwgMi4gT25seSBpbiB0aGF0IGNhc2UgdGhlIGNvbXBsZXRpb24vbXV0ZXggCj4g
Pj4+Pj4gYXJlIGFjdHVhbGx5IHVzZWQuIAo+ID4+Pj4gCj4gPj4+PiBXaHkgZG8geW91IG5lZWQg
dG8gZG8gdGhpcz8gQ2FuJ3QgYmUgdGhlIGNoYW5uZWxzIGRlZGljYXRlZCBhbmQgcmVzZXJ2ZWQg
Cj4gPj4+PiBmb3IgY2xvY2tzb3VyY2UgYW5kIGNsb2NrZXZlbnQ/IAo+ID4+PiAKPiA+Pj4gVGhh
dCdzIHdoYXQgSSBoYWQgaW4gcGxhY2UgKGluZ2VuaWMsdGltZXItY2hhbm5lbCBhbmQgaW5nZW5p
YyxjbG9ja3NvdXJjZS1jaGFubmVsIERUIHByb3BlcnRpZXMpLCBidXQgUm9iIGRpZG4ndCB3YW50
IGFueSBsaW51eC1zcGVjaWZpYyBwcm9wZXJ0aWVzIGluIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmcg
OiggCj4gPj4gCj4gPj4gSXNuJ3QgcG9zc2libGUgdG8gc3BlY2lmeSB0aGUgY2hhbm5lbCB0byB1
c2UgaW4gdGhlIERUPyBsaWtlIHJlbmVzYXMxNiA/IAo+ID4gCj4gPiBUaGF0J3Mgd2hhdCBJIGRp
ZCBpbiBWNiAoYW5kIGJlZm9yZSksIGJ1dCBSb2IgZGlkIG5vdCB3YW50IG1lIHRvIGFkZCBwcm9w
ZXJ0aWVzIGZvciBMaW51eC1zcGVjaWZpYyBjb25jZXB0cyBzdWNoIGFzIGNsb2Nrc291cmNlLiAK
Pgo+IEhtbSwgSSByZW1lbWJlciBzb21ldGhpbmcgbGlrZSB0aGF0LCB5ZXMgYnV0IEkgZGlkIGEg
ZGVsZXRlIG9mIHRoZSAKPiBwcmV2aW91cyB2ZXJzaW9uIHdoZW4geW91IHBvc3RlZCB0aGUgdjcu
IENhbiB5b3UgZ2l2ZSBhIHBvaW50ZXIgdG8gaXRzIAo+IGFuc3dlciA/IAoKWWVzLCB0aGlzIHdh
cyBoaXMgYW5zd2VyOgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC83LzI1LzUwOAoKVGhlbiBt
aW5lOgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC83LzMwLzg4MwoKLVBhdWw=
