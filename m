Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 15:33:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51812 "EHLO localhost"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011987AbbKIOdUDDNfK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Nov 2015 15:33:20 +0100
Date:   Mon, 9 Nov 2015 14:33:19 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
In-Reply-To: <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com> <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 14 Sep 2015, Bartlomiej Zolnierkiewicz wrote:

> This patch disables deprecated IDE subsystem in sb1250_swarm_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).

 Someone forgot to enable BLK_DEV_PLATFORM, it would seem, at the time the 
host driver was converted to a PATA platform device (back in 2008, commit 
2fef357c).  Frankly I don't think this config file has been recently (as 
in "since 2008") properly maintained, the last time I revalidated it was 
shortly before the conversion and nobody else bothered since then.  I'll 
give it a shot to modernise it at the earliest opportunity, I have other 
stuff to sort out with this system outstanding.

 For the record, I have this in .config I've most recently used (with
3.19.0):

CONFIG_HAVE_IDE=y
CONFIG_IDE=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_HAVE_PATA_PLATFORM=y

and the driver does register and sees the devices there:

[...]
pata-swarm: PATA interface at GenBus slot 4
futex hash table entries: 512 (order: 1, 49152 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
duart0 at MMIO 0x10060100 (irq = 8, base_baud = 5000000) is a SB1250 DUART
duart1 at MMIO 0x10060200 (irq = 9, base_baud = 5000000) is a SB1250 DUART
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
ide-cd driver 5.00
Probing IDE interface ide0...
hda: TOSHIBA MK2016GAP, ATA DISK drive
hdb: ST380011A, ATA DISK drive
ide0 at 0x90000000100b3e00-0x90000000100b3ee0,0x90000000100b7ec0 on irq 36
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB), CHS=38760/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdb: max request size: 1024KiB
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 > hdb4
[...]

I can check if things still work correctly when routed through libata, 
although it'll have to wait a couple of weeks yet at the least as I have 
wired my SWARM for hardware debugging, making it not immediately bootable 
and I'll be departing soon (i.e. I have no time for complicated fiddling).  
The host driver itself is actually in arch/mips/sibyte/swarm/platform.c 
BTW.

 Note to self: it would be nice if physical rather than virtual MMIO 
addresses were reported too.

  Maciej
