Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2018 14:51:44 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:34526 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993060AbeJCMvljDK1k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2018 14:51:41 +0200
Date:   Wed, 03 Oct 2018 14:51:26 +0200
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU
 drivers
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, robh@kernel.org,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1538571100; bh=MoHWfelmrhlFMJVlX1Yqn+k9DxKvCHaRMwk3sSgKScw=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=fNq1f2LKvLLUXnZjRLo6vjUe3r14sBSsGk7D2NUM4MVXVQn6ZOnPsvfB06n3wP6ifZxHZsaUaMJ++xfNPmvM9MuWpc9Io4F9cL1pRFeQWyjT22oFgtMsskc7019XK/EW/viCoH+lYDhEr1Q+fCSuWT1Pf9Vzwm3UOad5clC7278=
Message-Id: <S23993060AbeJCMvljDK1k/20181003125141Z+1130@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66663
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

CkxlIDMgb2N0LiAyMDE4IDI6NDcgUE0sIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBPbiAwMy8xMC8yMDE4IDEyOjMyLCBQYXVsIENlcmN1
ZWlsIHdyb3RlOiAKPiA+IAo+ID4gTGUgMSBvY3QuIDIwMTggMTA6NDgsIERhbmllbCBMZXpjYW5v
IDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPiBhIAo+ID4gw6ljcml0IDogCj4gPj4gCj4gPj4g
T24gMzEvMDcvMjAxOCAwMDowMSwgUGF1bCBDZXJjdWVpbCB3cm90ZTogCj4gPj4gCj4gPj4gWyAu
Li4gXSAKPiA+PiAKPiA+Pj4+PiArLSBpbmdlbmljLHRpbWVyLWNoYW5uZWw6IFNwZWNpZmllcyB0
aGUgVENVIGNoYW5uZWwgdGhhdCAKPiA+Pj4+PiBzaG91bGQgYmUgdXNlZCBhcyArwqAgc3lzdGVt
IHRpbWVyLiBJZiBub3QgcHJvdmlkZWQsIHRoZSBUQ1UgCj4gPj4+Pj4gY2hhbm5lbCAwIGlzIHVz
ZWQgZm9yIHRoZSBzeXN0ZW0gdGltZXIuICsgKy0gCj4gPj4+Pj4gaW5nZW5pYyxjbG9ja3NvdXJj
ZS1jaGFubmVsOiBTcGVjaWZpZXMgdGhlIFRDVSBjaGFubmVsIHRoYXQgCj4gPj4+Pj4gc2hvdWxk
IGJlIHVzZWQgK8KgIGFzIGNsb2Nrc291cmNlIGFuZCBzY2hlZF9jbG9jay4gSXQgbXVzdCBiZSAK
PiA+Pj4+PiBhIGRpZmZlcmVudCBjaGFubmVsIHRoYW4gdGhlIG9uZSArwqAgdXNlZCBhcyBzeXN0
ZW0gdGltZXIuIElmIAo+ID4+Pj4+IG5vdCBwcm92aWRlZCwgbmVpdGhlciBhIGNsb2Nrc291cmNl
IG5vciBhICvCoCBzY2hlZF9jbG9jayBpcyAKPiA+Pj4+PiBpbnN0YW50aWF0ZWQuIAo+ID4+Pj4g
Cj4gPj4+PiBjbG9ja3NvdXJjZSBhbmQgc2NoZWRfY2xvY2sgYXJlIExpbnV4IHNwZWNpZmljIGFu
ZCBkb24ndCBiZWxvbmcgCj4gPj4+PiBpbiBEVC4gWW91IHNob3VsZCBkZWZpbmUgcHJvcGVydGll
cyBvZiB0aGUgaGFyZHdhcmUgb3IgdXNlIAo+ID4+Pj4gZXhpc3RpbmcgcHJvcGVydGllcyBsaWtl
IGludGVycnVwdHMgb3IgY2xvY2tzIHRvIGZpZ3VyZSBvdXQgCj4gPj4+PiB3aGljaCBjaGFubmVs
IHRvIHVzZS4gRm9yIGV4YW1wbGUsIGlmIHNvbWUgY2hhbm5lbHMgZG9uJ3QgaGF2ZSAKPiA+Pj4+
IGFuIGludGVycnVwdCwgdGhlbiB1c2UgdGhlbSBmb3IgY2xvY2tzb3VyY2UgYW5kIG5vdCBhIAo+
ID4+Pj4gY2xvY2tldmVudC4gT3IgeW91IGNvdWxkIGhhdmUgdGltZXJzIHRoYXQgcnVuIGluIGxv
dy1wb3dlciAKPiA+Pj4+IG1vZGVzIG9yIG5vdC4gSWYgYWxsIHRoZSBjaGFubmVscyBhcmUgaWRl
bnRpY2FsLCB0aGVuIGl0IAo+ID4+Pj4gc2hvdWxkbid0IG1hdHRlciB3aGljaCBvbmVzIHRoZSBP
UyBwaWNrcy4gCj4gPj4gCj4gPj4gSXQgY2FuJ3Qgd29yayBpbiB0aGlzIGNhc2UgYmVjYXVzZSB0
aGUgcG13IGFuZCB0aGUgdGltZXIgZHJpdmVyIGFyZSAKPiA+PiBub3QgY29tbXVuaWNhdGluZyBh
bmQgdGhlIGZpcnN0IG9uZSBjYW4gc3RvbGUgYSBjaGFubmVsIHRvIHRoZSBsYXN0IAo+ID4+IG9u
ZS4gCj4gPiAKPiA+IEluIHRoYXQgcGFydGljdWxhciBjYXNlIHRoZSB0aW1lciBkcml2ZXIgd2ls
bCBhbHdheXMgcmVxdWVzdCBpdHMgCj4gPiBjaGFubmVscyBmaXJzdDsgd2l0aCBubyB0aW1lciBz
ZXQgdGhlIHN5c3RlbSBoYW5ncyBiZWZvcmUgCj4gPiBzdWJzeXNfaW5pdGNhbGwsIGFuZCB0aGUg
UFdNIGRyaXZlciBpcyBhIHN1Ym5vZGUgb2YgdGhlIHRpbWVyIG5vZGUsIAo+ID4gc28gaXMgcHJv
YmVkIG9ubHkgYWZ0ZXIgdGhlIHRpbWVyIHByb2JlZC4gCj4gPiAKPiA+Pj4gV2UgYWxyZWFkeSB0
YWxrZWQgYWJvdXQgdGhhdC4gQWxsIHRoZSBUQ1UgY2hhbm5lbHMgY2FuIGJlIHVzZWQgCj4gPj4+
IGZvciBQV00uIFRoZSBwcm9ibGVtIGlzIEkgY2Fubm90IGtub3cgZnJvbSB0aGUgZHJpdmVyJ3Mg
c2NvcGUgCj4gPj4+IHdoaWNoIGNoYW5uZWxzIHdpbGwgYmUgZnJlZSBhbmQgd2hpY2ggY2hhbm5l
bHMgd2lsbCBiZSByZXF1ZXN0ZWQgCj4gPj4+IGZvciBQV00uIFlvdSBzdWdnZXN0ZWQgdGhhdCBJ
IHBhcnNlIHRoZSBkZXZpY2V0cmVlIGZvciBjbGllbnRzLCAKPiA+Pj4gYW5kIEkgZGlkIHRoYXQg
aW4gdGhlIFYzL1Y0IHBhdGNoc2V0LiBCdXQgaXQgb25seSB3b3JrcyBmb3IgCj4gPj4+IGNsaWVu
dHMgcmVxdWVzdGluZyB0aHJvdWdoIGRldmljZXRyZWUsIG5vdCBmcm9tIHBsYXRmb3JtIGNvZGUg
b3IgCj4gPj4+IGV2ZW4gc3lzZnMuIAo+ID4+PiAKPiA+Pj4gT25lIHRoaW5nIEkgY2FuIHRyeSBp
cyB0byBkeW5hbWljYWxseSBjaGFuZ2UgdGhlIGNoYW5uZWxzIHRoZSAKPiA+Pj4gc3lzdGVtIHRp
bWVyIGFuZCBjbG9ja3NvdXJjZSBhcmUgdXNpbmcgd2hlbiB0aGUgY3VycmVudCBvbmVzIGFyZSAK
PiA+Pj4gcmVxdWVzdGVkIGZvciBQV00uIEJ1dCB0aGF0IHNvdW5kcyBoYXJkY29yZS4uLiAKPiA+
PiAKPiA+PiBZZXMsIGl0IGlzIDovIAo+ID4+IAo+ID4+IFNvcnJ5IGZvciBsZXR0aW5nIHlvdSB3
YXN0aW5nIHRpbWUgYW5kIGVmZm9ydCB0byB3cml0ZSBhbiBvdmVya2lsbCAKPiA+PiBjb2RlIG5v
dCBzdWl0YWJsZSBmb3IgdXBzdHJlYW0uIAo+ID4+IAo+ID4+IEEgdmVyeSBncm9zcyB0aG91Z2h0
LCB3b3VsZG4ndCBiZSBwb3NzaWJsZSB0byAicmVnaXN0ZXIiIGEgY2hhbm5lbCAKPiA+PiBmcm9t
IHRoZSB0aW1lciBkcml2ZXIgY29kZSBpbiBhIHNoYXJlZCBkYXRhIGFyZWEgKGJ1dCB3ZWxsIAo+
ID4+IHNlbGYtZW5jYXBzdWxhdGVkKSBhbmQgdGhlIHB3bSBjb2RlIHdpbGwgY2hlY2sgc3VjaCBj
aGFubmVsIGlzbid0IAo+ID4+IGluIHVzZSA/IAo+ID4gCj4gPiBQcm9iYWJseSwgYnV0IGl0J3Mg
dGhlIGNvbnRyYXJ5IEkgbmVlZCB0byBkby4gVGhlIHRpbWVyIGRyaXZlciBjb2RlIAo+ID4gY2Fu
IHVzZSBhbnkgY2hhbm5lbCwgYW5kIHByb2JlcyBmaXJzdC4gVGhlIFBXTSBkcml2ZXIgY29kZSBt
dXN0IHVzZSAKPiA+IHNwZWNpZmljIGNoYW5uZWxzLCBhbmQgcHJvYmVzIGxhc3QuIFNvIGVpdGhl
ciB0aGUgdGltZXIgZHJpdmVyIGtub3dzIAo+ID4gd2hhdCBjaGFubmVscyBpdCBjYW4ndCB1c2Us
IHRoYW5rcyB0byBhIGRldmljZSBwcm9wZXJ0eSwgb3IgaXQgYWRhcHRzIAo+ID4gaXRzZWxmIHdo
ZW4gYSBjaGFubmVsIGluIHVzZSBpcyByZXF1ZXN0ZWQgZm9yIFBXTSwgd2hpY2ggaXMgd2hhdCBJ
IAo+ID4gdHJpZWQgaW4gdjcuIAo+Cj4gV2hlbiB5b3Ugc2F5ICJtdXN0IHVzZSBzcGVjaWZpYyBj
aGFubmVscyIsIHdoZXJlIGlzIGNvbWluZyB0aGlzIAo+IGluZm9ybWF0aW9uID8gCgpJZiB0aGUg
YmFja2xpZ2h0IGZvciB0aGUgTENEIGlzIGNvbm5lY3RlZCB0byB0aGUgcGluIHRoYXQgY29ycmVz
cG9uZHMgdG8gUFdNMSwgdGhlbiB5b3UgbXVzdCB1c2UgdGhlIFRDVSBjaGFubmVsIDEuIEl0J3Mg
dGhhdCBzaW1wbGUuCgo+ID4gSSB0aGluayB3ZSBjb3VsZCBmaW5kIGEgd2F5IHRvIHVzZSBhIGRl
dmljZXRyZWUgcHJvcGVydHkgdGhhdCBkb2Vzbid0IAo+ID4gdHJpZ2dlciBSb2IuIFRoYXQgd291
bGQgc3RpbGwgYmUgdGhlIGVhc2llc3QgYW5kIGNsZWFuZXN0IHNvbHV0aW9uLiAKPiA+IAo+ID4g
TWF5YmUgImluZ2VuaWMscmVzZXJ2ZWQtY2hhbm5lbHMtbWFzayIsIHdoaWNoIHdvdWxkIGNvbnRh
aW4gYSBtYXNrIG9mIAo+ID4gY2hhbm5lbHMgdGhhdCBjYW4gb25seSBiZSB1c2VkIGJ5IHRoZSB0
aW1lciBkcml2ZXIuIEFuZCB3aGF0IHRoZSAKPiA+IHRpbWVyIGRyaXZlciBkb2VzIHdpdGggdGhl
c2UgY2hhbm5lbHMsIHdvdWxkIGJlIHNwZWNpZmljIHRvIHRoZSAKPiA+IGltcGxlbWVudGF0aW9u
IGFuZCB3b3VsZCBub3QgYXBwZWFyIGluIHRoZSBiaW5kaW5ncy4gSSBob3BlIFJvYiBjYW4gCj4g
PiB3b3JrIHdpdGggdGhhdC4gCj4gPiAKPiA+IC1QYXVsIAo+ID4g
