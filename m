Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2018 12:42:26 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:44466 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994575AbeJJKmXdO4oI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2018 12:42:23 +0200
Date:   Wed, 10 Oct 2018 12:38:58 +0200
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU
 drivers
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh@kernel.org,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1539168142; bh=70zFuFVT1eGXfmhSKy1J7ZOlJQjvlsWVMzlg9TUlr4s=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=U52eezDgA0a621GLvMoIc0QlYTrPdBBWyHdPw5SLLpB76cpRBYAbUoRx/Udb5ZyKJ7L73p7TCBxfdJrqKFPVJi/4EkZ8RFjZWqgu+1KntvwW9I7Ku+SgPz/X/cCBGBq96EDyDANDKKsKaS9WuAElfZ6u1xbtqpTQChdNjCIQV+E=
Message-Id: <S23994575AbeJJKmXdO4oI/20181010104223Z+2351@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66741
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

IFsgLi4uIF0gCgo+IFBhdWwsIAo+Cj4gSSB0aGluayB0aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcg
d2l0aCB5b3VyIG1haWxlciBzaW5jZSB5b3VyIHJlcGxpZXMgCj4gYXJlIGJlaW5nIHNjYXR0ZXJl
ZCBhY3Jvc3MgbXkgaW5ib3ggdW4tdGhyZWFkZWQsIG1ha2luZyBjb252ZXJzYXRpb25zIAo+IHZl
cnkgZGlmZmljdWx0IHRvIGZvbGxvdy4gCgpPaCwgSSdtIHNvcnJ5IGFib3V0IHRoYXQuIEkgdXNl
IHRoZSBzdGFuZGFyZCBlbWFpbCBjbGllbnQgb2YgQW5kcm9pZCAoSSdtIG9uIHRoZSByb2FkKSwg
aXMgaXQga25vd24gZm9yIG5vdCBoYW5kbGluZyB0aHJlYWRzPwoKLSBQYXVs
