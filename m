Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 17:08:59 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:59899 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491098Ab1FOPIx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 17:08:53 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f:0:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p5FF8Arv008610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Wed, 15 Jun 2011 08:08:11 -0700
Message-ID: <4DF8CAD5.1090902@zytor.com>
Date:   Wed, 15 Jun 2011 08:08:05 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        microblaze-uclinux@itee.uq.edu.au,
        Chris Metcalf <cmetcalf@tilera.com>,
        Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        Kyle McMartin <kyle@mcmartin.ca>,
        Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org> <4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com> <20110615074749.GB28989@n2100.arm.linux.org.uk>
In-Reply-To: <20110615074749.GB28989@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 30412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12416

On 06/15/2011 12:47 AM, Russell King - ARM Linux wrote:
>>
>> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
>> are ubiquitous across just about every platform.
>>
>> Floppy is special (in the short bus sense), since it is closely tied to
>> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.
> 
> No it doesn't.  It depends on the ISA DMA API, not that the machine has
> ISA DMA.
> 
> I have a platform which has no ISA DMA but uses the floppy driver.  Please
> don't break it.

OK, even more case in point, then.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
