Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2018 15:40:00 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:50988 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994583AbeJCNj5ykjs8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2018 15:39:57 +0200
Date:   Wed, 03 Oct 2018 15:39:45 +0200
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU
 drivers
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        robh@kernel.org, linux-mips@linux-mips.org,
        Stephen Boyd <sboyd@kernel.org>,
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1538573996; bh=LsfeG2IB3HkH2xgyHFXzOvzz2TP/FE7HM11cFsLe0Qo=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=lvIMPPy7RLL+u6/fh7NxgMc4fSyG1A73AcaqYS3Kumm+xqU49O06KvaGhAjXcIVWbBJOAjh38xJfgt7FEVzJjthmklXEm25X+ahSknzWpdQp0+7ln1w4QRqENwz2rl1aM/fOWv7GzX6uh6UtKEtx2veDBVzeifRhlirBE1AztjY=
Message-Id: <S23994583AbeJCNj5ykjs8/20181003133957Z+1137@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66665
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

CkxlIDMgb2N0LiAyMDE4IDM6MDIgUE0sIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBPbiAwMy8xMC8yMDE4IDE0OjUxLCBQYXVsIENlcmN1
ZWlsIHdyb3RlOiAKPiA+IAo+ID4gTGUgMyBvY3QuIDIwMTggMjo0NyBQTSwgRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IGEgCj4gPiDDqWNyaXQgOiAKPiA+PiAKPiA+
PiBPbiAwMy8xMC8yMDE4IDEyOjMyLCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+Pj4gCj4gPj4+
IExlIDEgb2N0LiAyMDE4IDEwOjQ4LCBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4gCj4gPj4+IGEgw6ljcml0IDogCj4gPj4+PiAKPiA+Pj4+IE9uIDMxLzA3LzIwMTgg
MDA6MDEsIFBhdWwgQ2VyY3VlaWwgd3JvdGU6IAo+ID4+Pj4gCj4gPj4+PiBbIC4uLiBdIAo+ID4+
Pj4gCj4gPj4+Pj4+PiArLSBpbmdlbmljLHRpbWVyLWNoYW5uZWw6IFNwZWNpZmllcyB0aGUgVENV
IGNoYW5uZWwgdGhhdCAKPiA+Pj4+Pj4+wqAgc2hvdWxkIGJlIHVzZWQgYXMgK8KgIHN5c3RlbSB0
aW1lci4gSWYgbm90IHByb3ZpZGVkLCB0aGUgCj4gPj4+Pj4+PiBUQ1UgY2hhbm5lbCAwIGlzIHVz
ZWQgZm9yIHRoZSBzeXN0ZW0gdGltZXIuICsgKy0gCj4gPj4+Pj4+PiBpbmdlbmljLGNsb2Nrc291
cmNlLWNoYW5uZWw6IFNwZWNpZmllcyB0aGUgVENVIGNoYW5uZWwgCj4gPj4+Pj4+PiB0aGF0IHNo
b3VsZCBiZSB1c2VkICvCoCBhcyBjbG9ja3NvdXJjZSBhbmQgc2NoZWRfY2xvY2suIEl0IAo+ID4+
Pj4+Pj4gbXVzdCBiZSBhIGRpZmZlcmVudCBjaGFubmVsIHRoYW4gdGhlIG9uZSArwqAgdXNlZCBh
cyAKPiA+Pj4+Pj4+IHN5c3RlbSB0aW1lci4gSWYgbm90IHByb3ZpZGVkLCBuZWl0aGVyIGEgY2xv
Y2tzb3VyY2Ugbm9yIAo+ID4+Pj4+Pj4gYSArwqAgc2NoZWRfY2xvY2sgaXMgaW5zdGFudGlhdGVk
LiAKPiA+Pj4+Pj4gCj4gPj4+Pj4+IGNsb2Nrc291cmNlIGFuZCBzY2hlZF9jbG9jayBhcmUgTGlu
dXggc3BlY2lmaWMgYW5kIGRvbid0IAo+ID4+Pj4+PiBiZWxvbmcgaW4gRFQuIFlvdSBzaG91bGQg
ZGVmaW5lIHByb3BlcnRpZXMgb2YgdGhlIGhhcmR3YXJlIAo+ID4+Pj4+PiBvciB1c2UgZXhpc3Rp
bmcgcHJvcGVydGllcyBsaWtlIGludGVycnVwdHMgb3IgY2xvY2tzIHRvIAo+ID4+Pj4+PiBmaWd1
cmUgb3V0IHdoaWNoIGNoYW5uZWwgdG8gdXNlLiBGb3IgZXhhbXBsZSwgaWYgc29tZSAKPiA+Pj4+
Pj4gY2hhbm5lbHMgZG9uJ3QgaGF2ZSBhbiBpbnRlcnJ1cHQsIHRoZW4gdXNlIHRoZW0gZm9yIAo+
ID4+Pj4+PiBjbG9ja3NvdXJjZSBhbmQgbm90IGEgY2xvY2tldmVudC4gT3IgeW91IGNvdWxkIGhh
dmUgdGltZXJzIAo+ID4+Pj4+PiB0aGF0IHJ1biBpbiBsb3ctcG93ZXIgbW9kZXMgb3Igbm90LiBJ
ZiBhbGwgdGhlIGNoYW5uZWxzIGFyZSAKPiA+Pj4+Pj4gaWRlbnRpY2FsLCB0aGVuIGl0IHNob3Vs
ZG4ndCBtYXR0ZXIgd2hpY2ggb25lcyB0aGUgT1MgCj4gPj4+Pj4+IHBpY2tzLiAKPiA+Pj4+IAo+
ID4+Pj4gSXQgY2FuJ3Qgd29yayBpbiB0aGlzIGNhc2UgYmVjYXVzZSB0aGUgcG13IGFuZCB0aGUg
dGltZXIgZHJpdmVyIAo+ID4+Pj4gYXJlIG5vdCBjb21tdW5pY2F0aW5nIGFuZCB0aGUgZmlyc3Qg
b25lIGNhbiBzdG9sZSBhIGNoYW5uZWwgdG8gCj4gPj4+PiB0aGUgbGFzdCBvbmUuIAo+ID4+PiAK
PiA+Pj4gSW4gdGhhdCBwYXJ0aWN1bGFyIGNhc2UgdGhlIHRpbWVyIGRyaXZlciB3aWxsIGFsd2F5
cyByZXF1ZXN0IGl0cyAKPiA+Pj7CoCBjaGFubmVscyBmaXJzdDsgd2l0aCBubyB0aW1lciBzZXQg
dGhlIHN5c3RlbSBoYW5ncyBiZWZvcmUgCj4gPj4+IHN1YnN5c19pbml0Y2FsbCwgYW5kIHRoZSBQ
V00gZHJpdmVyIGlzIGEgc3Vibm9kZSBvZiB0aGUgdGltZXIgCj4gPj4+IG5vZGUsIHNvIGlzIHBy
b2JlZCBvbmx5IGFmdGVyIHRoZSB0aW1lciBwcm9iZWQuIAo+ID4+PiAKPiA+Pj4+PiBXZSBhbHJl
YWR5IHRhbGtlZCBhYm91dCB0aGF0LiBBbGwgdGhlIFRDVSBjaGFubmVscyBjYW4gYmUgCj4gPj4+
Pj4gdXNlZCBmb3IgUFdNLiBUaGUgcHJvYmxlbSBpcyBJIGNhbm5vdCBrbm93IGZyb20gdGhlIGRy
aXZlcidzIAo+ID4+Pj4+IHNjb3BlIHdoaWNoIGNoYW5uZWxzIHdpbGwgYmUgZnJlZSBhbmQgd2hp
Y2ggY2hhbm5lbHMgd2lsbCBiZSAKPiA+Pj4+PiByZXF1ZXN0ZWQgZm9yIFBXTS4gWW91IHN1Z2dl
c3RlZCB0aGF0IEkgcGFyc2UgdGhlIGRldmljZXRyZWUgCj4gPj4+Pj4gZm9yIGNsaWVudHMsIGFu
ZCBJIGRpZCB0aGF0IGluIHRoZSBWMy9WNCBwYXRjaHNldC4gQnV0IGl0IAo+ID4+Pj4+IG9ubHkg
d29ya3MgZm9yIGNsaWVudHMgcmVxdWVzdGluZyB0aHJvdWdoIGRldmljZXRyZWUsIG5vdCAKPiA+
Pj4+PiBmcm9tIHBsYXRmb3JtIGNvZGUgb3IgZXZlbiBzeXNmcy4gCj4gPj4+Pj4gCj4gPj4+Pj4g
T25lIHRoaW5nIEkgY2FuIHRyeSBpcyB0byBkeW5hbWljYWxseSBjaGFuZ2UgdGhlIGNoYW5uZWxz
IHRoZSAKPiA+Pj4+PsKgIHN5c3RlbSB0aW1lciBhbmQgY2xvY2tzb3VyY2UgYXJlIHVzaW5nIHdo
ZW4gdGhlIGN1cnJlbnQgb25lcyAKPiA+Pj4+PiBhcmUgcmVxdWVzdGVkIGZvciBQV00uIEJ1dCB0
aGF0IHNvdW5kcyBoYXJkY29yZS4uLiAKPiA+Pj4+IAo+ID4+Pj4gWWVzLCBpdCBpcyA6LyAKPiA+
Pj4+IAo+ID4+Pj4gU29ycnkgZm9yIGxldHRpbmcgeW91IHdhc3RpbmcgdGltZSBhbmQgZWZmb3J0
IHRvIHdyaXRlIGFuIAo+ID4+Pj4gb3ZlcmtpbGwgY29kZSBub3Qgc3VpdGFibGUgZm9yIHVwc3Ry
ZWFtLiAKPiA+Pj4+IAo+ID4+Pj4gQSB2ZXJ5IGdyb3NzIHRob3VnaHQsIHdvdWxkbid0IGJlIHBv
c3NpYmxlIHRvICJyZWdpc3RlciIgYSAKPiA+Pj4+IGNoYW5uZWwgZnJvbSB0aGUgdGltZXIgZHJp
dmVyIGNvZGUgaW4gYSBzaGFyZWQgZGF0YSBhcmVhIChidXQgCj4gPj4+PiB3ZWxsIHNlbGYtZW5j
YXBzdWxhdGVkKSBhbmQgdGhlIHB3bSBjb2RlIHdpbGwgY2hlY2sgc3VjaCAKPiA+Pj4+IGNoYW5u
ZWwgaXNuJ3QgaW4gdXNlID8gCj4gPj4+IAo+ID4+PiBQcm9iYWJseSwgYnV0IGl0J3MgdGhlIGNv
bnRyYXJ5IEkgbmVlZCB0byBkby4gVGhlIHRpbWVyIGRyaXZlciAKPiA+Pj4gY29kZSBjYW4gdXNl
IGFueSBjaGFubmVsLCBhbmQgcHJvYmVzIGZpcnN0LiBUaGUgUFdNIGRyaXZlciBjb2RlIAo+ID4+
PiBtdXN0IHVzZSBzcGVjaWZpYyBjaGFubmVscywgYW5kIHByb2JlcyBsYXN0LiBTbyBlaXRoZXIg
dGhlIHRpbWVyIAo+ID4+PiBkcml2ZXIga25vd3Mgd2hhdCBjaGFubmVscyBpdCBjYW4ndCB1c2Us
IHRoYW5rcyB0byBhIGRldmljZSAKPiA+Pj4gcHJvcGVydHksIG9yIGl0IGFkYXB0cyBpdHNlbGYg
d2hlbiBhIGNoYW5uZWwgaW4gdXNlIGlzIHJlcXVlc3RlZCAKPiA+Pj4gZm9yIFBXTSwgd2hpY2gg
aXMgd2hhdCBJIHRyaWVkIGluIHY3LiAKPiA+PiAKPiA+PiBXaGVuIHlvdSBzYXkgIm11c3QgdXNl
IHNwZWNpZmljIGNoYW5uZWxzIiwgd2hlcmUgaXMgY29taW5nIHRoaXMgCj4gPj4gaW5mb3JtYXRp
b24gPyAKPiA+IAo+ID4gSWYgdGhlIGJhY2tsaWdodCBmb3IgdGhlIExDRCBpcyBjb25uZWN0ZWQg
dG8gdGhlIHBpbiB0aGF0IGNvcnJlc3BvbmRzIAo+ID4gdG8gUFdNMSwgdGhlbiB5b3UgbXVzdCB1
c2UgdGhlIFRDVSBjaGFubmVsIDEuIEl0J3MgdGhhdCBzaW1wbGUuIAo+Cj4gSXMgaXQgYSBydW50
aW1lIGRldGVjdGlvbiBvciBpcyBpdCBoYXJkY29kZWQgc29tZXdoZXJlID8gCj4KPiAoanVzdCB0
cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUgd2hvbGUgcGljdHVyZSkgCgpUaGUgUFdNIGNoYW5uZWwg
Y2FuIGJlIGhhcmRjb2RlZCBpbiB0aGUgInB3bXMiIHByb3BlcnR5IG9mIHRoZSBjbGllbnRzLiBJ
dCBjYW4gYWxzbyBiZSBoYXJkY29kZWQgaW4gcGxhdGZvcm0gY29kZSwgb3Igc2ltcGx5IHJlcXVl
c3RlZCBmcm9tIHN5c2ZzLgoKPiA+Pj4gSSB0aGluayB3ZSBjb3VsZCBmaW5kIGEgd2F5IHRvIHVz
ZSBhIGRldmljZXRyZWUgcHJvcGVydHkgdGhhdCAKPiA+Pj4gZG9lc24ndCB0cmlnZ2VyIFJvYi4g
VGhhdCB3b3VsZCBzdGlsbCBiZSB0aGUgZWFzaWVzdCBhbmQgY2xlYW5lc3QgCj4gPj4+IHNvbHV0
aW9uLiAKPiA+Pj4gCj4gPj4+IE1heWJlICJpbmdlbmljLHJlc2VydmVkLWNoYW5uZWxzLW1hc2si
LCB3aGljaCB3b3VsZCBjb250YWluIGEgCj4gPj4+IG1hc2sgb2YgY2hhbm5lbHMgdGhhdCBjYW4g
b25seSBiZSB1c2VkIGJ5IHRoZSB0aW1lciBkcml2ZXIuIEFuZCAKPiA+Pj4gd2hhdCB0aGUgdGlt
ZXIgZHJpdmVyIGRvZXMgd2l0aCB0aGVzZSBjaGFubmVscywgd291bGQgYmUgc3BlY2lmaWMgCj4g
Pj4+IHRvIHRoZSBpbXBsZW1lbnRhdGlvbiBhbmQgd291bGQgbm90IGFwcGVhciBpbiB0aGUgYmlu
ZGluZ3MuIEkgCj4gPj4+IGhvcGUgUm9iIGNhbiB3b3JrIHdpdGggdGhhdC4gCj4gPj4+IAo+ID4+
PiAtUGF1bCAKPgo+Cj4gLS0gCj4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg
4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcyAKPgo+IEZvbGxvdyBMaW5hcm86
wqAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfCAKPiA8
aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8IAo+IDxodHRwOi8vd3d3
LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nIAo+Cg==
