Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 07:42:30 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:35604 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990502AbeENFmWl7aoO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 07:42:22 +0200
Date:   Fri, 11 May 2018 13:17:04 -0300
Subject: Re: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the
 jz4740-wdt driver
From:   Paul Cercueil <paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1526055435; bh=FdpTGXuQHMA5IawmJD0GNZOKEBgBJTnZaCfQGQ9ToKE=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=RNSDjGBoL5Et9RAGBZfOEZd9ayaxqr17FSs862dBWtOxNfhwNPihwBQaIknRF3jwi3UgJ8bLmwPIcvogXRTd5NXTkLEr3xyNISbAbSOwW0BsOlkJBWGMmc7owk0wGA4BfkJi1Vw5A/nDYZMRDZYkDsQ6qKTDgNq2tDTzlqo1XxA=
Message-Id: <S23990502AbeENFmWl7aoO/20180514054222Z+3226@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63895
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

SGkgSmFtZXMsCgpMZSAxMSBtYWkgMjAxOCAxMTo1MiwgSmFtZXMgSG9nYW4gPGpob2dhbkBrZXJu
ZWwub3JnPiBhIMOpY3JpdCA6Cj4KPiBPbiBUaHUsIE1heSAxMCwgMjAxOCBhdCAwODo0Nzo0OFBN
ICswMjAwLCBQYXVsIENlcmN1ZWlsIHdyb3RlOiAKPiA+IEFsc28gcmVtb3ZlIHRoZSB3YXRjaGRv
ZyBwbGF0Zm9ybV9kZXZpY2UgZnJvbSBwbGF0Zm9ybS5jLCBzaW5jZSBpdCAKPiA+IHdhc24ndCB1
c2VkIGFueXdoZXJlIGFueXdheS4gCj4KPiBOaXQ6IGl0J2QgYmUgc2xpZ2h0bHkgbmljZXIgSU1P
IGlmIHRoZSBwYXRjaCBib2R5IHdhcyBhIHN1cGVyc2V0IG9mIHRoZSAKPiBzdWJqZWN0IGxpbmUu
IEl0J3MgZmluZSB0byByZXBlYXQgd2hhdCB0aGUgc3ViamVjdCBzYXlzIHNpbmNlIHRoYXRzIAo+
IG1lYW50IHRvIHN1bW1hcmlzZSB0aGUgYm9keS4gCj4KPiA+IC1zdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlIGp6NDc0MF93ZHRfZGV2aWNlID0geyAKPgo+IFRoZXJlJ3MgYW4gZXh0ZXJuIGluIGFyY2gv
bWlwcy9pbmNsdWRlL2FzbS9tYWNoLWp6NDc0MC9wbGF0Zm9ybS5oIHRoYXQgCj4gc2hvdWxkIHBl
cmhhcHMgYmUgcmVtb3ZlZCBhbHNvPyAKCllvdSdyZSByaWdodC4gSXQgc2hvdWxkIGJlIHJlbW92
ZWQuCgo+IE90aGVyd2lzZSAKPiBBY2tlZC1ieTogSmFtZXMgSG9nYW4gPGpob2dhbkBrZXJuZWwu
b3JnPiAKPgo+IEknbSBoYXBweSB0byBhcHBseSBmb3IgNC4xOCB3aXRoIHRoYXQgY2hhbmdlIGlm
IHlvdSB3YW50IGl0IHRvIGdvIAo+IHRocm91Z2ggdGhlIE1JUFMgdHJlZS4gCgpZZXMgcGxlYXNl
IQoKPiBDaGVlcnMgCj4gSmFtZXMgCgpUaGFua3MsCi1QYXVs
