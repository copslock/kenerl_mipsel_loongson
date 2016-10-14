Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 19:39:28 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:34676 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992104AbcJNRjUSed2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 19:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=bsHJoywenf7OIHpnMco4EJci6Vs29AbX+PZY72oYK0M=; b=FvnWC5gJNZ43mXTFEHkxMdomvg
        mzQf7eMcQd/+wkpyRgQ380LDlxge3ub263tx5N/NdFqwAzQw4mt8lcVeNisxJNJcQSjZmEkhujSQa
        3Tsq1Pr+QlbW6QZupRKy/nP1mq8/cj7e6VIMbU8MLL+zD33t9FZDyCY2U7lDP2HWwRAXTTsmVcHuq
        IMdyot7aHuJliX81sHBbx15QqVwjdJHX94jDlpUfbDDlZQ00hNXAelItMaqfR1BeHOJ4Fusu5xDZM
        ofjjyB0H+ZfsDgr4YuPW4ZP1kfX2zZJJE0VWI7i5PvOCHcU/UYPOAXM1hPb5VeU5H2woHdd8SsEfe
        sd2knvug==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50696 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1bv6Rn-0036VI-Cx; Fri, 14 Oct 2016 17:39:09 +0000
Date:   Fri, 14 Oct 2016 10:39:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [2/2] MIPS: malta: Fixup reboot
Message-ID: <20161014173910.GA28660@roeck-us.net>
References: <20161014091732.27536-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161014091732.27536-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Oct 14, 2016 at 10:17:32AM +0100, Paul Burton wrote:
> Commit 10b6ea0959de ("MIPS: Malta: Use syscon-reboot driver to reboot")
> converted the Malta board to use the generic syscon-reboot driver to
> handle reboots, but incorrectly used the value 0x4d rather than 0x42 as
> the magic to write to the reboot register.
> 
> I also incorrectly believed that syscon/regmap would default to native
> endianness, but this isn't the case. Force this by specifying with a
> native-endian property in the devicetree.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 10b6ea0959de ("MIPS: Malta: Use syscon-reboot driver to reboot")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> Hi Guenter,
> 
> Apologies for that! Hopefully this fixes it up for you. I've tested QEMU
> in both endiannesses & it now works for me, as well as real hardware.
> 
Fixes the problem if applied together with 'mfd: syscon: Support
native-endian regmaps'. Both patches are needed.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> Hi Ralf,
> 
> Apologies for the brokenness! Feel free to apply this as a fixup if it's
> not too late, otherwise it would be great to get into mainline ASAP.
> ---
>  arch/mips/boot/dts/mti/malta.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
> index 85468bf..48f696a 100644
> --- a/arch/mips/boot/dts/mti/malta.dts
> +++ b/arch/mips/boot/dts/mti/malta.dts
> @@ -94,12 +94,13 @@
>  	fpga_regs: system-controller@1f000000 {
>  		compatible = "mti,malta-fpga", "syscon", "simple-mfd";
>  		reg = <0x1f000000 0x1000>;
> +		native-endian;
>  
>  		reboot {
>  			compatible = "syscon-reboot";
>  			regmap = <&fpga_regs>;
>  			offset = <0x500>;
> -			mask = <0x4d>;
> +			mask = <0x42>;
>  		};
>  	};
>  
