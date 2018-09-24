Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 07:49:56 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:34192 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990757AbeIXFtxjtm-O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 07:49:53 +0200
Date:   Mon, 24 Sep 2018 07:49:36 +0200
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1537768192; bh=FdQPg8WZcDslV+Tb4AwlFwWGgKtnlCUkDzGAPrEPd64=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=C4YaU7SezueDxixFXKa2bAK5DnM6gU5q/BhS5gsYxVq9rehf1i5AamfvgUnSkiAu59LlBpfL5VE8e44dCyByPaT+bhPBzdLM3vp/u245vawl4TFJy0dwO14096x1niApcUVKPgeJgKXmHUZ2Qd93sjIpCqtYRmaCBqdY4fPcPhE=
Message-Id: <S23990757AbeIXFtxjtm-O/20180924054953Z+442@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66496
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

CkxlIDI0IHNlcHQuIDIwMTggMDc6MzUsIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBPbiAyNC8wOS8yMDE4IDA3OjI0LCBQYXVsIENlcmN1
ZWlsIHdyb3RlOiAKPiA+IEhpIERhbmllbCwgCj4gPiAKPiA+IExlIDI0IHNlcHQuIDIwMTggMDU6
MTIsIERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPiBhIMOpY3JpdCA6
IAo+ID4+IAo+ID4+IE9uIDIxLzA4LzIwMTggMTk6MTYsIFBhdWwgQ2VyY3VlaWwgd3JvdGU6IAo+
ID4+PiBUaGlzIGRyaXZlciBoYW5kbGVzIHRoZSBUQ1UgKFRpbWVyIENvdW50ZXIgVW5pdCkgcHJl
c2VudCBvbiB0aGUgSW5nZW5pYyAKPiA+Pj4gSlo0N3h4IFNvQ3MsIGFuZCBwcm92aWRlcyB0aGUg
a2VybmVsIHdpdGggYSBzeXN0ZW0gdGltZXIsIGFuZCBvcHRpb25hbGx5IAo+ID4+PiB3aXRoIGEg
Y2xvY2tzb3VyY2UgYW5kIGEgc2NoZWRfY2xvY2suIAo+ID4+PiAKPiA+Pj4gSXQgYWxzbyBwcm92
aWRlcyBjbG9ja3MgYW5kIGludGVycnVwdCBoYW5kbGluZyB0byBjbGllbnQgZHJpdmVycy4gCj4g
Pj4gCj4gPj4gQ2FuIHlvdSBwcm92aWRlIGEgbXVjaCBtb3JlIGNvbXBsZXRlIGRlc2NyaXB0aW9u
IG9mIHRoZSB0aW1lciBpbiBvcmRlciAKPiA+PiB0byBtYWtlIG15IGxpZmUgZWFzaWVyIGZvciB0
aGUgcmV2aWV3IG9mIHRoaXMgcGF0Y2g/IAo+ID4gCj4gPiBTZWUgcGF0Y2ggWzAzLzI0XSwgaXQg
YWRkcyBhIGRvYyBmaWxlIHRoYXQgZGVzY3JpYmVzIHRoZSBoYXJkd2FyZS4gCj4KPiBUaGFua3Ms
IEkgd2VudCB0aHJvdWdoIGJ1dCBpdCBpcyBpbmNvbXBsZXRlIHRvIHVuZGVyc3RhbmQgd2hhdCB0
aGUgdGltZXIgCj4gZG8uIEkgd2lsbCByZXZlcnNlLWVuZ2luZWVyIHRoZSBjb2RlIGJ1dCBpdCB3
b3VsZCBoZWxwIGlmIHlvdSBjYW4gZ2l2ZSAKPiB0aGUgZ3Jvc3MgYXBwcm9hY2guIFdoeSBtdWx0
aXBsZSBjaGFubmVscyA/IG11dGV4ZXMgYW5kIGNvbXBsZXRpb24gPyAKCk11Y2ggb2YgdGhlIGNv
bXBsZXhpdHkgaXMgYmVjYXVzZSBvZiB0aGUgbXVsdGktcHVycG9zZSBuYXR1cmUgb2YgdGhlIFRD
VSBjaGFubmVscy4gRWFjaCBvbmUgY2FuIGJlIHVzZWQgYXMgdGltZXIvY2xvY2tzb3VyY2UsIG9y
IFBXTS4KClRoZSBkcml2ZXIgc3RhcnRzIGJ5IHVzaW5nIGNoYW5uZWxzIDAgYW5kIDEgYXMgc3lz
dGVtIHRpbWVyIGFuZCBjbG9ja3NvdXJjZSwgcmVzcGVjdGl2ZWx5LCB0aGUgb3RoZXIgb25lcyBi
ZWluZyB1bnVzZWQgZm9yIG5vdy4gVGhlbiwgKmlmKiB0aGUgUFdNIGRyaXZlciByZXF1ZXN0cyBv
bmUgb2YgdGhlIGNoYW5uZWxzIGluIHVzZSBieSB0aGUgdGltZXIvY2xvY2tzb3VyY2UgZHJpdmVy
LCBzYXkgY2hhbm5lbCAwLCB0aGUgdGltZXIvY2xvY2tzb3VyY2UgZHJpdmVyIHdpbGwgZHluYW1p
Y2FsbHkgcmVhc3NpZ24gdGhlIHN5c3RlbSB0aW1lciB0byBhIGZyZWUgY2hhbm5lbCwgZnJvbSBj
aGFubmVsIDAgdG8gZS5nLiBjaGFubmVsIDIuIE9ubHkgaW4gdGhhdCBjYXNlIHRoZSBjb21wbGV0
aW9uL211dGV4IGFyZSBhY3R1YWxseSB1c2VkLgoKLVBhdWw=
