Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 20:44:02 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:38697 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042634AbcFPSoBY8Sf5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jun 2016 20:44:01 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-149-135-nat.elisa-mobile.fi [85.76.149.135])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 090A42340FC;
        Thu, 16 Jun 2016 21:43:58 +0300 (EEST)
Date:   Thu, 16 Jun 2016 21:43:58 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Larry Finger <larry.finger@lwfinger.net>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Paul Wassi <p.wassi@gmx.at>
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
Message-ID: <20160616184358.GC8398@raspberrypi.musicnaut.iki.fi>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Thu, Jun 16, 2016 at 08:17:16AM +0200, Rafał Miłecki wrote:
> From time to time I test new kernels with ancient Linksys WRT300N v1.0
> device based on BCM4704 SoC.
> 
> I noticed that after updating kernel from 4.3 to 4.4 it doen't boot
> anymore. All I can see is the last CFE's (bootloader's) message:
> > Starting program at 0x80001000
> Enabling CONFIG_EARLY_PRINTK doesn't help.
> 
> After hours or bisecting and testing I found out that it's not caused
> by any /real/ code change but rather adding a kernel message. It seems
> that by adding enough print messages I can stop kernel from booting.
> 
> I didn't know what exactly to look at so I started with "objdump
> --syms vmlinux". I took 4.1.16 and 4.3.4 and tried adding to them
> various amount of unique pr_info messages in some random error code
> path (never executed). I noticed that address of .data was increasing
> which makes me believe that it's a matter of .rodata size or some
> affected size/offset in vmlinux.
> 1) 4.1.6: if .data starts at 80369000 of higher kernel doesn't boot.
> 2) 4.3.4: if .data starts at 80368000 of higher kernel doesn't boot.
> 
> Do you have any idea what this problem can be caused by? Any idea how
> to fix/workaround it? Can I provide any extra info?
> 
> It doesn't affect all BCM4704 devices. Hauke also has some router
> using this SoC and he couldn't reproduce this problem.
> On the other hand Paul also experiences some problems with his Linksys
> WRT54GL (BCM5352E), the last stable kernel for him seems to be 3.18.
> Not sure if it's related however.

WRT54GL with 16 MB RAM boots fine with 4.7-rc3. However, I've always had
the issue that the kernel size cannot exceed some limit, so you need to
craft a very minimal config. You can see the memory map at early boot,
and the kernel probably should not overlap with any memory used by CFE:

Total memory used by CFE:  0x80300000 - 0x803A39B0 (670128)
Initialized Data:          0x803398C0 - 0x8033BFD0 (10000)
BSS Area:                  0x8033BFD0 - 0x8033D9B0 (6624)
Local Heap:                0x8033D9B0 - 0x803A19B0 (409600)
Stack Area:                0x803A19B0 - 0x803A39B0 (8192)
Text (code) segment:       0x80300000 - 0x803398C0 (235712)
Boot area (physical):      0x003A4000 - 0x003E4000
Relocation Factor:         I:00000000 - D:00000000

Probably one workaround could be to change the load address?

A.
