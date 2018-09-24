Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 07:24:30 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:39548 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990422AbeIXFY1K0-ZF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 07:24:27 +0200
Date:   Mon, 24 Sep 2018 07:24:06 +0200
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1537766665; bh=G+ZzTtSXxnIvaqblfrinIVcwcDjZ/0MiZAc5iJCgsnQ=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=W06BjDb4IuQHdZF0Zh19O76jbn0dDFqnXkqKZ8dT9g6zWE0TLuheIQgfs1ojYTFMzK1FWZlISXFo0ZEKFk5CWzyct2CygPmro01y45fSOT9C9SDuEdTtqklxiR2QYXOpcuWzT0X7PjV0O0VPcUcfqg/8aUkIYKfy4iST0ebo+Lw=
Message-Id: <S23990422AbeIXFY1K0-ZF/20180924052427Z+437@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66494
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

SGkgRGFuaWVsLAoKTGUgMjQgc2VwdC4gMjAxOCAwNToxMiwgRGFuaWVsIExlemNhbm8gPGRhbmll
bC5sZXpjYW5vQGxpbmFyby5vcmc+IGEgw6ljcml0IDoKPgo+IE9uIDIxLzA4LzIwMTggMTk6MTYs
IFBhdWwgQ2VyY3VlaWwgd3JvdGU6IAo+ID4gVGhpcyBkcml2ZXIgaGFuZGxlcyB0aGUgVENVIChU
aW1lciBDb3VudGVyIFVuaXQpIHByZXNlbnQgb24gdGhlIEluZ2VuaWMgCj4gPiBKWjQ3eHggU29D
cywgYW5kIHByb3ZpZGVzIHRoZSBrZXJuZWwgd2l0aCBhIHN5c3RlbSB0aW1lciwgYW5kIG9wdGlv
bmFsbHkgCj4gPiB3aXRoIGEgY2xvY2tzb3VyY2UgYW5kIGEgc2NoZWRfY2xvY2suIAo+ID4gCj4g
PiBJdCBhbHNvIHByb3ZpZGVzIGNsb2NrcyBhbmQgaW50ZXJydXB0IGhhbmRsaW5nIHRvIGNsaWVu
dCBkcml2ZXJzLiAKPgo+IENhbiB5b3UgcHJvdmlkZSBhIG11Y2ggbW9yZSBjb21wbGV0ZSBkZXNj
cmlwdGlvbiBvZiB0aGUgdGltZXIgaW4gb3JkZXIgCj4gdG8gbWFrZSBteSBsaWZlIGVhc2llciBm
b3IgdGhlIHJldmlldyBvZiB0aGlzIHBhdGNoPyAKClNlZSBwYXRjaCBbMDMvMjRdLCBpdCBhZGRz
IGEgZG9jIGZpbGUgdGhhdCBkZXNjcmliZXMgdGhlIGhhcmR3YXJlLgoKPiBUaGFua3MgCj4KPiDC
oCAtLSBEYW5pZWwgCgpUaGFua3MsCi1QYXVs
