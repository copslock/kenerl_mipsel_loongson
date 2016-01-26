Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 20:26:58 +0100 (CET)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33112 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011636AbcAZT0yw7098 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 20:26:54 +0100
Received: by mail-pf0-f171.google.com with SMTP id e65so103999313pfe.0;
        Tue, 26 Jan 2016 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eNPHYKqYj252LzW4T5U5LM9j30HAE/iUpLIrRUprH7o=;
        b=qsMDbZFmTZPdRA1fUhAWydRZypJGRSPXjtw2ncdNO0nGdxyovUlzsQ2+IOV5jKNKvy
         t0pcJS9fxGbnGTYFpCiMplebmRWhZUJngxSt76oQC+Pack5PxvbUmwDEYupbedr7R5FP
         sugQtkm9j1YXhKFa6S8hzaZXukC01Lruk14u5eloQM4fqTWCOCz+CFgf2unD+zrNpIdy
         rSo1+EfLer+PcT2Rg2DDEf/m8CWu4c59lDFLPEHeQ5iPOZK/ejabMWqkaMi9n219947Q
         nBiB8IgK4R51rLuXFz1UVsw667vXurIeAijVNHwT3EInzQNuqDpNeBTZ9A1Bds1MQEaZ
         s7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eNPHYKqYj252LzW4T5U5LM9j30HAE/iUpLIrRUprH7o=;
        b=FDMALDFGwmppwI2Avh2TyYLc70fRPt0SXfoW66rhyN1lZyx41whDz0jcIN8k52EeWi
         kdOPmk5arOSwYjrKiFAVG1Mw30mIjlORHpTwK8sK/dtmhR19rdBHcdRPDWMSSx+IYRLF
         U6h1AO3Ei/YLXwq/OeIdARKIDjZPc0tyEOYpO+JKLZtARQ37ZanO2q0MUiQWCGFyoRoR
         Ar21CRZfiy0vmWxu8a9bto7ifX4zkBIS69QYuu48G+rf52mbhA2H3Uf252QMBdBw2s26
         MjQaiJzEYynpfodJoQ5KURRxhi6yem2P3DV6Q60sYe3TEN4WQjG6eiLbmQbb1bzqeK0w
         c+Rg==
X-Gm-Message-State: AG10YOQyTsK2iZo5Rhw1st6eJVXcFOY5lnpG+94sK4JlBmZBUuL7/vL7ZXVRnRZBvvMrvw==
X-Received: by 10.98.75.22 with SMTP id y22mr36968817pfa.147.1453836408775;
        Tue, 26 Jan 2016 11:26:48 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:adba:d372:4bd6:cc17])
        by smtp.gmail.com with ESMTPSA id d8sm3585293pas.14.2016.01.26.11.26.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 11:26:48 -0800 (PST)
Date:   Tue, 26 Jan 2016 11:26:45 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>
Subject: Re: [PATCH 00/23] mtd: rework ECC layout definition
Message-ID: <20160126192645.GA46523@google.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi Boris,

On Mon, Dec 07, 2015 at 11:25:55PM +0100, Boris Brezillon wrote:
> Hello,
> 
> This patchset aims at getting rid of the nand_ecclayout limitations.
> struct nand_ecclayout is defining fixed eccpos and oobfree arrays which
> can only be increased by modifying the MTD_MAX_ECCPOS_ENTRIES_LARGE and
> MTD_MAX_OOBFREE_ENTRIES_LARGE macros.
> This approach forces us to modify the macro values each time we add a
> new NAND chip with a bigger OOB area, and increasing these arrays also
> penalize all platforms, even those who only support small NAND devices
> (with small OOB area).
> 
> The idea to overcome this limitation, is to define the ECC/OOB layout
> by the mean of two functions: ->eccpos() and ->oobfree(), which will
> basically return the same information has those stored in the
> nand_ecclayout struct.
> 
> Another advantage of this solution is that ECC layouts are usually
> following a repetitive pattern (i.e. leave X bytes free and put Y bytes
> of ECC per ECC chunk), which allows one to implement the ->eccpos()
> and ->oobfree() functions with a simple logic that can be applied
> to any size of OOB.

Thanks for the work! This definitely needed done. I imagined that it
might be best if we just changed the data structure format and have
drivers allocate it dynamically during probe(), but actually, I kinda
like generating it on the fly. The only concern I'd have is if there is
significant penalty to doing this sort of computation on the fly during
(e.g.) AUTO-layout OOB reads/writes. But I guess if there is such a
penalty, nothing would stop us from caching the results in the MTD/NAND
core code.

> Patches 1 to 10 are just cleanups or trivial fixes that can be taken
> independently.

There were some comments for patch 1, and I want to look more closely at
patch 10. But patches 2 to 9 are pushed to l2-mtd.git. Thanks!

> Patch 19 is just an aggregate of several smaller commits (one per
> driver), and has been submitted this way to limit the size of the
> series. If everybody agrees on this approach, I'll resubmit the series
> will those changes separated in different commits (as done here [1]).
> 
> Also note that the last two commits are removing the nand_ecclayout
> definition, thus preventing any new driver to use this structure.
> Of course, this step can be delayed if some of the previous patches
> are not accepted.

I haven't looked in detail at the second half of the series, but I like
the concept. I'll look closer once you fix up things in v2.

Thanks,
Brian

> Best Regards,
> 
> Boris
> 
> [1]https://github.com/bbrezillon/linux-sunxi/commits/nand/ecclayout2
