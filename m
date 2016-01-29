Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 00:15:49 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:38325 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008981AbcA2XPr5PWlL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 00:15:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BG6Zwum+Yf/hLNJHYe7I7gWZta39Uq9Xjg/nhZMGqn8=;
        b=rR/QA64IxfX94LinYZgR57ZePm7vpBrfW0tJr/28GASy7RNShHU64g84tp1gbjfMJ4STTlsgUgccPGRTxvCLlhELtqDhWPF2+RSi+HdnlCwi8jx5mdDpd0uyr/HE1jNdksxep8/v6KK6EUaD/sywVOevQUgiwY5siuGj997k6X8=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:45802)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1aPIGQ-0006jD-6B; Fri, 29 Jan 2016 23:15:38 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1aPIGM-0004Zk-Sw; Fri, 29 Jan 2016 23:15:34 +0000
Date:   Fri, 29 Jan 2016 23:15:34 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Marek <mmarek@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Message-ID: <20160129231534.GT10826@n2100.arm.linux.org.uk>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <19656457.qoKNGRmV4Q@wuerfel>
 <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
 <4727572.ddrMioV3Fi@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4727572.ddrMioV3Fi@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Fri, Jan 29, 2016 at 10:54:02PM +0100, Arnd Bergmann wrote:
> Now that I think about it, I guess platforms that use values above
> 0xfee00000 can also easily get into trouble as that conflicts with the
> PCI I/O space, the fixmap or other special areas documented in
> Documentation/arm/memory.txt. We have a bunch of those:
> 
>         default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
>         default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
>         default 0xfee82340 if ARCH_IOP13XX
>         default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
>         default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
>         default 0xfef36000 if DEBUG_HIGHBANK_UART
>         default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
>         default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
>         default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>         default 0xfefff700 if ARCH_IOP33X
>         default 0xff003000 if DEBUG_U300_UART
>         default 0xffd01000 if DEBUG_HIP01_UART
> 
> The HIP01 is the only one that looks actively dangerous here (clashes with
> fixmap), the others are probably all fine but it would be nice to stay out
> of that area completely.

That's wrong.  Given it's PCI bus architecture and it's IO space, at least
one of those above is perfectly valid.  0x3f8 into IO space might ring a
bell... if not the COM1 certainly should. :)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
