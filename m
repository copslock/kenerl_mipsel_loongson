Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 22:26:47 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:37825 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491000Ab1FNU0k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jun 2011 22:26:40 +0200
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p5EKPl81014228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 14 Jun 2011 13:25:47 -0700
Message-ID: <4DF7C3CA.9050902@zytor.com>
Date:   Tue, 14 Jun 2011 13:25:46 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Lennox Wu <lennox.wu@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11870

On 06/14/2011 12:08 PM, Ralf Baechle wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
> 
>        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
>                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> 
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly.  This is an attempt at cleaing the mess up.
> 
> I tried to faithfully aproximate the old behaviour but the existing
> behaviour seems inacurate if not wrong for some architectures or platforms.
> To improve on this I rely on comments from other arch and platforms
> maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> parallel port on the mainboard should probably should now do a
> select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> need it.
> 

Why on earth restrict it like that?  It's just a device driver, like
more or less any other device driver...

	-hpa
