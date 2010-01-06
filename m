Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2010 22:08:44 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:60268 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492226Ab0AFVIk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jan 2010 22:08:40 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NSd7J-0007fA-9X
        for linux-mips@linux-mips.org; Wed, 06 Jan 2010 22:08:33 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2010 22:08:33 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2010 22:08:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH 4/4] MTD: include ar7part in the list of partitions parsers
Date:   Wed, 6 Jan 2010 20:28:10 +0000
Message-ID:  <qb8f17-41q.ln1@chipmunk.wormnet.eu>
References:  <201001032117.37459.florian@openwrt.org> <1262552177.3181.5891.camel@macbook.infradead.org> <2ve717-7pt.ln1@chipmunk.wormnet.eu> <201001050941.42161.florian@openwrt.org>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Cc:     linux-mtd@lists.infradead.org
X-archive-position: 25521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4359

In gmane.linux.ports.mips.general Florian Fainelli <florian@openwrt.org> wrote:
>
>> [snipped]
>> 
>> It simply pulls apart the 'PROM' (aka ADAM2) config and uses that to
>> build the partition table.
> 
> This is indeed simple but if I recall right the rationale behind ar7part was 
> to create a sane partition layout no matter if the bootloader was ADAM2 or 
> PSPBoot and the root filesystem type. JFFS2 and squashfs do not have the same 
> erase-block size alignment constraints, ar7part deals with that too.
> 
I am not convinced that is a good idea, one main reason is ar7part.c has 
gotten terribly wrong the partition table ('loader' is too small[1] and 
'rootfs' overlaps with the 'linux' partition').

This is what I have from ADAM2's perspective:
----
Adam2_AR7WRD > printenv
[snipped]
mtd0                  0x900e0000,0x903f0000 <-- rootfs
mtd1                  0x90020000,0x900e0000 <-- kernel
mtd2                  0x90000000,0x90020000 <-- adam2 bootloader
mtd3                  0x903f0000,0x90400000 <-- configuration
mtd4                  0x90020000,0x903f0000 <-- kernel + rootfs
----

Linux spits out:
----
physmap platform flash device: 00800000 at 10000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cmdlinepart partition parsing not available
RedBoot partition parsing not available
4 ar7part partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000010000 : "loader"
0x0000003f0000-0x000000400000 : "config"
0x000000020000-0x0000003f0000 : "linux"
0x0000000d0000-0x0000003f0000 : "rootfs"
----

My patch munched on whatever prom_getenv() returned, which from what I 
can tell looking at arch/mips/ar7/prom.c will work for both PSPBoot and 
ADAM2?

Are there some strange mtd environment variables I am yet to see out in 
the wild or does my patch simply not work for PSPBoot primed kit?  If 
not can you give me some 'spiel' to play around with?

Cheers

[1] okay, ADAM2 weighs in at less than 64kiB however it is not outside 
	the realm of possibility someone will port u-boot to AR7 which 
	would benefit from the full 128kiB of space?

-- 
Alexander Clouter
.sigmonster says: A man who turns green has eschewed protein.
