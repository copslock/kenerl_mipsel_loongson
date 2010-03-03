Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 11:25:14 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:35170 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab0CCKZL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Mar 2010 11:25:11 +0100
Received: by ewy23 with SMTP id 23so745755ewy.24
        for <linux-mips@linux-mips.org>; Wed, 03 Mar 2010 02:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=iNRHM8LCHKiOX3VyIVr1pxcx6UvEXFhdnBSF4BjBNvc=;
        b=HTAGd7LZlBn2fW//2f39MbzK8VV7oyYYkrjqNx3JaG5qFXuUH9lq73VCI7m1nIXNm8
         BAEe4AqQ2SK9yzxXc9rivdvoR/HUMtHr2sGqVQ4ipBufRJwCVME1QMJr2lj0M/7W++ma
         g1dhVl8G1sBZBqvxIPMRZKKTWNY6RU/Q2KrHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=DPXPvQUxJrwVXf1WCiqry0/9GZuH620zL0xJ0cZOtZQut67kvbl9PQmbkd8HsAzVb4
         SO/UuYE4DOG5EG0yDF8LOIjYWSeVyhnejiRzBkEtZ0fj4V6b1KBLAm22rD+LJYQyPNR3
         Oe0ygitq1Suwy80ALNnfx9lKoP0CvopXTHg2M=
Received: by 10.213.104.95 with SMTP id n31mr125720ebo.27.1267611905257;
        Wed, 03 Mar 2010 02:25:05 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 24sm1785410eyx.6.2010.03.03.02.25.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 02:25:02 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Dea_RU" <dryukovz@mail.ru>
Subject: Re: TI AR7 7200 - no boot
Date:   Wed, 3 Mar 2010 11:24:45 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <27766331.post@talk.nabble.com>
In-Reply-To: <27766331.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201003031124.46336.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Wednesday 03 March 2010 11:11:31 Dea_RU wrote:
> I build kernel 2.6.33 for TI AR7 cpu 7200 version.
> 
> boot halt on console init stage/
[snip]
> 
> CONFIG_MIPS=y
> 
> CONFIG_AR7=y
> CONFIG_LOONGSON_UART_BASE=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_ARCH_SUPPORTS_OPROFILE=y
> CONFIG_GENERIC_FIND_NEXT_BIT=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_TIME=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
> CONFIG_BOOT_RAW=y
[snip]
> 
> what wrong ????
> 
> kernels from open-wrt booting with log:
> ==============================
> (psbl)
> 
> Booting...
> Linux version 2.6.26.8 (agb@arrakis) (gcc version 4.1.2) #1 Wed Dec 2
> 15:14:35 UTC 2009
> console [early0] enabled
> CPU revision is: 00018448 (MIPS 4KEc)
> Clocks: Sync 2:1 mode
> Clocks: Setting CPU clock
> Adjusted requested frequency 211000000 to 211968000
> Clocks: base = 35328000, frequency = 211968000, prediv = 1, postdiv = 1,
> postdiv2 = -1, mul = 6
> Clocks: Setting DSP clock
> Clocks: base = 25000000, frequency = 105984000, prediv = 1, postdiv = 2,
> postdiv2 = 1, mul = 10
> Clocks: Setting USB clock
> Adjusted requested frequency 48000000 to 47863741
> Clocks: base = 105984000, frequency = 48000000, prediv = 1, postdiv = 31,
> postdiv2 = -1, mul = 14
> TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x11
> Determined physical RAM map:
>  memory: 01000000 @ 14000000 (usable)
> Initrd not found or empty - disabling initrd
> Zone PFN ranges:
>   Normal      81920 ->    86016
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:    81920 ->    86016
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
> Kernel command line: init=/etc/preinit rootfstype=squashfs,jffs2,
> console=ttyS0,9600n8
> Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
> Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
> PID hash table entries: 64 (order: 6, 256 bytes)
> Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
> Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Memory: 12560k/16384k available (2001k kernel code, 3824k reserved, 417k
> data, 124k init, 0k highmem)
> SLUB: Genslabs=6, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Mount-cache hash table entries: 512
> net_namespace: 644 bytes
> NET: Registered protocol family 16
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 512 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 512 bind 512)
> TCP reno registered
> NET: Registered protocol family 1
> squashfs: version 3.0 (2006/03/15) Phillip Lougher
> Registering mini_fo version $Id$
> JFFS2 version 2.2. (NAND) (SUMMARY)  Â© 2001-2006 Red Hat, Inc.
> msgmni has been set to 24
> io scheduler noop registered
> io scheduler deadline registered (default)
> Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
> serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a TI-AR7
> 

You have one of these devices with bogus UART, (there are quite some out there)
can you try with the following patch and tell me if that gives you an usable console:

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 246df7a..15cbeeb 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -551,6 +551,7 @@ static int __init ar7_register_uarts(void)
        uart_port.irq           = AR7_IRQ_UART0;
        uart_port.mapbase       = AR7_REGS_UART0;
        uart_port.membase       = ioremap(uart_port.mapbase, 256);
+       uart_port.flags         = UPF_IOREMAP | UPF_BOOT_AUTOCONF;

        res = early_serial_setup(&uart_port);
        if (res)
@@ -562,6 +563,7 @@ static int __init ar7_register_uarts(void)
                uart_port.irq           = AR7_IRQ_UART1;
                uart_port.mapbase       = UR8_REGS_UART1;
                uart_port.membase       = ioremap(uart_port.mapbase, 256);
+               uart_port.flags         = UPF_IOREMAP | UPF_BOOT_AUTOCONF;

                res = early_serial_setup(&uart_port);
                if (res)


Thanks.
-- 
Regards, Florian
