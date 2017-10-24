Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 15:44:11 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:55096 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990511AbdJXNoERCQml (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 15:44:04 +0200
Date:   Tue, 24 Oct 2017 15:43:41 +0200
Subject: Re: [3/3] MIPS: jz4780: DTS: Probe the jz4740-watchdog driver from
 devicetree
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        Krzysztof Kozlowski <krzk@kernel.org>, robh+dt@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1508852641; bh=gxudeMS66Th3Jo0dbxba+1Fc4q4HWbVa3iyokwgdaKM=; h=Date:Subject:From:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=dM6grnip5P6Y7M41cpe9EJAqp2nPFP5+YCJcheeiaonvekJzAs7eYBmJZOjoM+CNvMHGC5XlXXRz8W0xIVaVZZYVv02U0pfMuaC/Jla1fKEc82ptziNpRrUHei4XhwsQUK4XUEXtrbOoYgsNMsLEwaVY/sBWbJ4K53hC+Z0fA0U=
Message-Id: <S23990511AbdJXNoERCQml/20171024134404Z+1875@eddie.linux-mips.org>
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60531
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

SGksCgpMZSAyMiBvY3QuIDIwMTcgNToyNiBQTSwgR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2st
dXMubmV0PiBhIMOpY3JpdCA6Cj4KPiBPbiBGcmksIFNlcCAwOCwgMjAxNyBhdCAwODozNTo1NVBN
ICswMjAwLCBNYXRoaWV1IE1hbGF0ZXJyZSB3cm90ZTogCj4gPiBUaGUgano0NzQwLXdhdGNoZG9n
IGRyaXZlciBzdXBwb3J0cyBib3RoIGp6NDc0MCAmIGp6NDc4MC4gCj4gPiAKPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hdGhpZXUgTWFsYXRlcnJlIDxtYWxhdEBkZWJpYW4ub3JnPiAKPgo+IEFja2VkLWJ5
OiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+IAo+Cj4gPiAtLS0gCj4gPsKgIGFy
Y2gvbWlwcy9ib290L2R0cy9pbmdlbmljL2p6NDc4MC5kdHNpIHwgNSArKysrKyAKPiA+wqAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSAKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
bWlwcy9ib290L2R0cy9pbmdlbmljL2p6NDc4MC5kdHNpIGIvYXJjaC9taXBzL2Jvb3QvZHRzL2lu
Z2VuaWMvano0NzgwLmR0c2kgCj4gPiBpbmRleCA0ODUzZWY2N2IzYWIuLjMzZDdmNDkxODZkNiAx
MDA2NDQgCj4gPiAtLS0gYS9hcmNoL21pcHMvYm9vdC9kdHMvaW5nZW5pYy9qejQ3ODAuZHRzaSAK
PiA+ICsrKyBiL2FyY2gvbWlwcy9ib290L2R0cy9pbmdlbmljL2p6NDc4MC5kdHNpIAo+ID4gQEAg
LTIwNyw2ICsyMDcsMTEgQEAgCj4gPsKgIHN0YXR1cyA9ICJkaXNhYmxlZCI7IAo+ID7CoCB9OyAK
PiA+wqAgCj4gPiArIHdhdGNoZG9nOiBqejQ3ODAtd2F0Y2hkb2dAMTAwMDIwMDAgeyAKPiA+ICsg
Y29tcGF0aWJsZSA9ICJpbmdlbmljLGp6NDc0MC13YXRjaGRvZyI7IAo+ID4gKyByZWcgPSA8MHgx
MDAwMjAwMCAweDEwMD47IAo+ID4gKyB9OyAKPiA+ICsgCj4gPsKgIG5lbWM6IG5lbWNAMTM0MTAw
MDAgeyAKPiA+wqAgY29tcGF0aWJsZSA9ICJpbmdlbmljLGp6NDc4MC1uZW1jIjsgCj4gPsKgIHJl
ZyA9IDwweDEzNDEwMDAwIDB4MTAwMDA+OyAKClRoZSBub2RlIHNob3VsZCBiZSBuYW1lZCBqdXN0
ICIgd2F0Y2hkb2dALi4uIiwgSSB0aGluay4=
