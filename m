Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 17:17:21 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:36670 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491108Ab1FOPRQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 17:17:16 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f:0:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.14.4/8.14.4) with ESMTP id p5FFGgbU010508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Wed, 15 Jun 2011 08:16:43 -0700
Message-ID: <4DF8CCD5.3080005@zytor.com>
Date:   Wed, 15 Jun 2011 08:16:37 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
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
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "microblaze-uclinux@itee.uq.edu.au" 
        <microblaze-uclinux@itee.uq.edu.au>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org> <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com> <4DF8359F.10809@zytor.com> <20110615073935.GA28989@n2100.arm.linux.org.uk>
In-Reply-To: <20110615073935.GA28989@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 30413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12422

On 06/15/2011 12:39 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2011 at 09:31:27PM -0700, H. Peter Anvin wrote:
>> On 06/14/2011 03:08 PM, Luck, Tony wrote:
>>> I took a look at the back of all my ia64 systems - none of them
>>> have a parallel port.  It seems unlikely that new systems will
>>> start adding parallel ports :-)
>>>
>>> So even if I had a printer (or other device) that used a parallel
>>> port, I have no way to test it.
>>
>> If it has PCI slots, it can have a parallel port.
> 
> Is that a clue about where a select statement should be?

Not really, because it's a sufficient condition, not a required one.

All a platform needs to expose a PC-style parallel port interface is a
minimum of 3 contiguous I/O locations, and although in the PC they are
I/O mapped, they don't need to be.

The basic (SPP) parallel port interface is really just a glorified set
of GPIOs and could at least in theory be implemented as-is on any
platform with contiguous GPIO ports.  The faster modes (EPP and ECP) do
contain logic, and ECP depends on the ISA DMA API (thanks to Russell for
pointing out that actual ISA DMA is not required, any slave DMA solution
will do.)


	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
