Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 01:03:45 +0000 (GMT)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:7568 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036464AbYBRBDn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 01:03:43 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 74AAF5BC006;
	Mon, 18 Feb 2008 03:03:42 +0200 (EET)
Date:	Mon, 18 Feb 2008 03:03:14 +0200
From:	Adrian Bunk <adrian.bunk@movial.fi>
To:	linux-mips@linux-mips.org
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: mips: compile testing of 2.6.25-rc2
Message-ID: <20080218010314.GO1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <adrian.bunk@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adrian.bunk@movial.fi
Precedence: bulk
X-list: linux-mips

I did a compile testing of all mips defconfigs in 2.6.25-rc2.

The results were:


Systems without a defconfig:

CONFIG_BCM47XX
CONFIG_SGI_IP28
CONFIG_SIBYTE_CRHINE
CONFIG_SIBYTE_CARMEL
CONFIG_SIBYTE_CRHONE
CONFIG_SIBYTE_RHONE
CONFIG_SIBYTE_LITTLESUR
CONFIG_SIBYTE_SENTOSA

Can people using these systems provide defconfig's for them?
A defconfig is nothing special, it's enough to simply put the .config 
used for one machine into arch/mips/configs/ .


Patches sent for 2.6.25-rc2 regressions:

bigsur_defconfig [1]
rm200_defconfig [2]


Bug reports sent for 2.6.25-rc2 regressions:

cobalt_defconfig [3.4]
db1200_defconfig [5]
db1550_defconfig [5]
pb1550_defconfig [5]
yosemite_defconfig [6]
CONFIG_BCM47XX [7]


Broken before 2.6.24:

decstation_defconfig
  CC      arch/mips/dec/time.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/dec/time.c: In function 'plat_time_init':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/dec/time.c:164: error: 'mips_timer_ack' undeclared (first use in this function)

msp71xx_defconfig
  CC      arch/mips/pmc-sierra/msp71xx/msp_setup.o
arch/mips/pmc-sierra/msp71xx/msp_setup.c:24:22: error: msp_gpio.h: No such file or directory


Missing support in upstream gcc:

sb1250-swarm_defconfig
  CC [M]  fs/configfs/inode.o
cc1: error: unrecognized command line option "-msb1-pass1-workarounds"

CONFIG_SGI_IP28
  CALL    /home/bunk/linux/kernel-2.6/git/linux-2.6/scripts/checksyscalls.sh
cc1: error: unrecognized command line option "-mr10k-cache-barrier=1"

I tried with a plain gcc 4.2.3, and grep'ed in the gcc SVN head.
I don't know which special gcc versions have these options added, but 
when they are used by the kernel they should also go into upstream gcc.


Patch sent for removal of obsolete defconfig:

qemu_defconfig [8]


cu
Adrian

BTW: Please Cc me on replies.

[1] http://lkml.org/lkml/2008/2/17/296
[2] http://lkml.org/lkml/2008/2/17/346
[3] http://lkml.org/lkml/2008/2/17/295
[4] http://lkml.org/lkml/2008/2/17/293
[5] http://lkml.org/lkml/2008/2/17/299
[6] http://lkml.org/lkml/2008/2/17/383
[7] http://lkml.org/lkml/2008/2/17/297
[8] http://lkml.org/lkml/2008/2/17/298

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
