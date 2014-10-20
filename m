Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 07:27:20 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:49562 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011847AbaJTF1SzEQr5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Oct 2014 07:27:18 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id ADCB32800F7;
        Mon, 20 Oct 2014 07:26:13 +0200 (CEST)
Received: from dicker-alter.lan (p548C87CA.dip0.t-ipconnect.de [84.140.135.202])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon, 20 Oct 2014 07:26:13 +0200 (CEST)
Message-ID: <54449D31.9020108@openwrt.org>
Date:   Mon, 20 Oct 2014 07:27:13 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Alexandre Courbot <gnurou@gmail.com>,
        John Crispin <blogic@openwrt.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 2/5] GPIO: MIPS: ralink: add gpio driver for ralink rt2880
 SoC
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org> <1412972930-16777-2-git-send-email-blogic@openwrt.org> <CAAVeFu+BAwDOV1siPkRSOes0iJETLWcKEBBFrTn6o=d+CYQPPw@mail.gmail.com>
In-Reply-To: <CAAVeFu+BAwDOV1siPkRSOes0iJETLWcKEBBFrTn6o=d+CYQPPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi,


On 20/10/2014 06:41, Alexandre Courbot wrote:

On Sat, Oct 11, 2014 at 5:28 AM, John Crispin <blogic@openwrt.org> wrote:
> Add gpio driver for Ralink SoC. This driver makes the gpio core on

Makes the gpio core what?

> RT2880, RT305x, rt3352, rt3662, rt3883, rt5350 and mt7620 work.

work as it says in the last work of the sentence

[snip..]

> This (and the device tree bindings) seems the indicate that the 
> registers offset can vary depending on the chip and bank. The chip
> can be specified using the compatible property, as for the bank you
> can also require a property giving the bank number. With these two
> bits of information, this driver should be able to pick the right
> register layout out of an in-driver table. This would be much
> cleaner that letting the DT specify whatever layout it wants.

i tend to disagree. if we put the register offsets into the driver we
will have lots of static arrays (5 or 6) and with each new soc we need
to potentially need to patch the driver causing us in openwrt to carry
lots of patches and have to worry about upstreaming them. From my
understanding, the dts has this exact purpose, describing the hardware
and in turn reducing the boiler plate and static code in the drivers.
If have sent other drivers that do the same and was told there that
this is totally legit.

	John
