Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2016 13:24:07 +0200 (CEST)
Received: from asavdk4.altibox.net ([109.247.116.15]:51835 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026277AbcEGLYGDFVSQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2016 13:24:06 +0200
Received: from ravnborg.org (unknown [188.228.89.252])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D11AC802C9;
        Sat,  7 May 2016 13:23:57 +0200 (CEST)
Date:   Sat, 7 May 2016 13:23:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     zengzhaoxiu@163.com
Cc:     akpm@linux-foundation.org, linux@horizon.com, peterz@infradead.org,
        jjuran@gmail.com, James.Bottomley@HansenPartnership.com,
        geert@linux-m68k.org, dalias@libc.org, davem@davemloft.net,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of
 Euclidean
Message-ID: <20160507112308.GA2612@ravnborg.org>
References: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=Fo6lhzfq c=1 sm=1 tr=0
        a=Ij76tQDYWdb01v2+RnYW5w==:117 a=Ij76tQDYWdb01v2+RnYW5w==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=wggRaunBjXu032dz5hIA:9 a=CjuIK1q_8ugA:10
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 57ffaf2..ca675ed 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -42,6 +42,7 @@ config SPARC
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
>  	select ARCH_HAS_SG_CHAIN
> +	select CPU_NO_EFFICIENT_FFS
>  
>  config SPARC32
>  	def_bool !64BIT

sparc64 have an efficient ffs implementation.
We use run-time patching to use the proper version
depending on the actual sparc cpu.

As this is determinded at config time, then let the
sparc cpu that has the efficient ffs benefit from this.

In other words - select CPU_NO_EFFICIENT_FFS only for SPARC32.

	Sam
