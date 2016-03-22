Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 03:44:37 +0100 (CET)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33025 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014181AbcCVCogCwBDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 03:44:36 +0100
Received: by mail-pf0-f170.google.com with SMTP id 4so158099084pfd.0
        for <linux-mips@linux-mips.org>; Mon, 21 Mar 2016 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=P7L/bM2RAA7DZNXPSQj0RVVTnw7TdCugnO5geW21Cu8=;
        b=WGJBmMLAXwdHTjE620zX3ymmWJNd1zEfRXx+wtwwLpJRkRF6336+zyN9O0ItQfEsU7
         zTXWPWo636QgY0bhokCC7T6lHiKcowJAOPEh+kjfQgWyb8BDGoRuAo3F1s5NH90h+A7X
         wJvuUc98WSKW0U8gG9fq2VLJovKpwuXL1u4WyxsiXfG6hb0A4/Bg9FC4vhryofldiqJ0
         TTOx2ZsPh5amO5n4WE7y+ThEGsljRHJEPTxDFdSVaGiXCzdbCEKXSQ8mgbdn9LzsAJVW
         sHTMKZgrH2eEzp0KIJfab6yEefOz0CljneUS0d+UELs2HifsSPhgFYdUCrYerAjqigXQ
         zw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=P7L/bM2RAA7DZNXPSQj0RVVTnw7TdCugnO5geW21Cu8=;
        b=Bw4ojiVm/2cHElnONeHkVoA5waxt+vs7eCMOz8UMC0uA/vUEndCeT0UXdixDCjm6ZL
         FZjgi0KgiUF7z06Z4XwDaQDCd6AmcVnvrqtsQzGSkU6cZ+1y1KslPggm6L8p3X4UQIsv
         7NF0wbrCEbM4ardVq1X5MO283Ah7UQChMYYfXWv4wjF6R/gd2KVxCrNveLPjxm0nnPUt
         1qF/ER7IFhKGupdnffazT9U9E9a0zFjFoYs2SFRBjZvoI/s4U62OszTdxfjBusJm6PEZ
         3peUW/KZvSHTC2ubeEqIq4fpkU6+N5utZCpjevZ4IT4aApfYofCkqo/zuZfBICwU7QZN
         R5Dg==
X-Gm-Message-State: AD7BkJJ0arZvSoPiCrwZ9wC9LTPmaUBwG1uUpiTitoIi/QlsKCkV2T6RDalkY+ugv+OdBw==
X-Received: by 10.98.93.205 with SMTP id n74mr50036157pfj.99.1458614669803;
        Mon, 21 Mar 2016 19:44:29 -0700 (PDT)
Received: from [192.168.1.20] (50-1-116-74.dsl.dynamic.fusionbroadband.com. [50.1.116.74])
        by smtp.gmail.com with ESMTPSA id 19sm43748181pfp.66.2016.03.21.19.44.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 19:44:29 -0700 (PDT)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Matthias Schiffer <mschiffer@universe-factory.net>,
        Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com
References: <56F07DA1.8080404@universe-factory.net>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F0B189.2080206@hurleysoftware.com>
Date:   Mon, 21 Mar 2016 19:44:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F07DA1.8080404@universe-factory.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

Hi Matthias,

On 03/21/2016 04:02 PM, Matthias Schiffer wrote:
> Hi,
> we're experiencing weird nondeterministic hangs during bootconsole/console
> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
> QCA953x likewise.
> 
> See the log below for the exact place it hangs; the log was taken in during
> a good boot; a bad boot will just hang forever at the marked location. The
> issue is extremely hard to debug, as changing the timing in any way (like
> adding additional printk) will usually make it work without problems. (Even
> recompiling the kernel with the same config, but different uname timestamp
> will make the occurence more or less likely)
> 
> My theory is the following:
> 
> As soon as ttyS0 is detected and installed as the console, there are two
> console drivers active on the serial port at the same time: early0 and
> ttyS0. I suspect that the hang occurs when the primitive early0
> implementation prom_putchar_ar71xx waits indefinitely on THRE, but the real
> driver has just reset the serial controller in a way that makes THRE never
> come.

Doubtful.

console writes are performed with ints disabled, as is the 8250 driver's
autoconfig probing. Since this is a UP platform, as long as you're not
using the DEBUG_AUTOCONF switch in the 8250 driver, I don't think there's
a way for the boot console to be outputting while the 8250 driver is
configuring.

> When the boot is successful, I also sometimes see just garbage
> instead of the message "serial8250.0: ttyS0 at MMIO 0x18020000...", which
> supports my idea that the kernel is trying to use the serial console while
> it is not correctly setup.
> 
> Is is possible that the first "console [ttyS0] disabled" message caused by
> the call chain
> 
>   serial8250_register_8250_port
>   uart_remove_one_port
>   unregister_console
> 
> should rather unregister early0 (as ttyS0 is not even registered at this
> point), so having both drivers active at the same time is avoided?

No.

Having both consoles active briefly at the handover is not really a problem;
all consoles are serialized with each other. Only one console can be outputting
at any one time.

The unregister_console() producing the bogus "ttyS0 disabled" message
is wrong but harmless.

That part happens because the 8250 driver creates phantom ports which are
unregistered as new ports are probed, but the ttyS0 console hadn't actually
been registered yet.


> Does this make any sense? Or do you have any other idea what might cause this?

I wonder if autoconfig probing (that's what discovers the uart port type)
is broken.

You could test this hypothesis by setting the port type directly and
set UPF_FIXED_TYPE; ie., in arch/mips/ath79/dev-common.c

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 516225d..3814a42 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -36,7 +36,8 @@ static struct plat_serial8250_port ath79_uart_data[] = {
 	{
 		.mapbase	= AR71XX_UART_BASE,
 		.irq		= ATH79_MISC_IRQ(3),
-		.flags		= AR71XX_UART_FLAGS,
+		.flags		= AR71XX_UART_FLAGS | UPF_FIXED_TYPE,
+		.type		= PORT_16550A,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
 	}, {


Regards,
Peter Hurley

> Thanks in advance,
> Matthias
> 
> 
> [1] https://dev.openwrt.org/ticket/21773
> [2] https://dev.openwrt.org/ticket/21857
> 
> 
>> [    0.000000] Linux version 3.18.27 (neoraider@avalon) (gcc version 4.8.3 (OpenWrt/Linaro GCC 4.8-2014.04 r47335) ) #6 Sun Mar 20 22:40:15 CET 2016
>> [    0.000000] bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
>> [    0.000000] SoC: Atheros AR7241 rev 1
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 02000000 @ 00000000 (usable)
>> [    0.000000] Initrd not found or empty - disabling initrd
>> [    0.000000] Zone ranges:
>> [    0.000000]   Normal   [mem 0x00000000-0x01ffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x00000000-0x01ffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x01ffffff]
>> [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
>> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
>> [    0.000000] Kernel command line:  board=TL-WR841N-v7 console=ttyS0,115200 rootfstype=squashfs,jffs2 noinitrd
>> [    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
>> [    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.000000] Writing ErrCtl register=00000000
>> [    0.000000] Readback ErrCtl register=00000000
>> [    0.000000] Memory: 28324K/32768K available (2573K kernel code, 133K rwdata, 540K rodata, 264K init, 193K bss, 4444K reserved)
>> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> [    0.000000] NR_IRQS:51
>> [    0.000000] Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:5.000MHz
>> [    0.000000] Calibrating delay loop... 265.42 BogoMIPS (lpj=1327104)
>> [    0.080000] pid_max: default: 32768 minimum: 301
>> [    0.080000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.090000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.100000] NET: Registered protocol family 16
>> [    0.100000] MIPS: machine is TP-LINK TL-WR841N/ND v7
>> [    0.550000] registering PCI controller with io_map_base unset
>> [    0.560000] PCI host bridge to bus 0000:00
>> [    0.570000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13ffffff]
>> [    0.570000] pci_bus 0000:00: root bus resource [io  0x0000]
>> [    0.580000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>> [    0.580000] pci 0000:00:00.0: fixup device configuration
>> [    0.590000] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1000ffff 64bit]
>> [    0.590000] pci 0000:00:00.0: using irq 40 for pin 1
>> [    0.600000] Switched to clocksource MIPS
>> [    0.600000] NET: Registered protocol family 2
>> [    0.610000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.610000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.620000] TCP: Hash tables configured (established 1024 bind 1024)
>> [    0.630000] TCP: reno registered
>> [    0.630000] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.640000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.640000] NET: Registered protocol family 1
>> [    0.650000] futex hash table entries: 256 (order: -1, 3072 bytes)
>> [    0.660000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> [    0.670000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
>> [    0.680000] msgmni has been set to 55
>> [    0.680000] io scheduler noop registered
>> [    0.690000] io scheduler deadline registered (default)
>> [    0.690000] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
>> [    0.700000] console [ttyS0] disabled
>>>> Boot will hang here <<<
>> [    0.730000] serial8250.0: ttyS0 at MMIO 0x18020000 (irq = 11, base_baud = 12500000) is a 16550A
>> [    0.740000] console [ttyS0] enabled
>> [    0.740000] console [ttyS0] enabled
>> [    0.740000] bootconsole [early0] disabled
>> [    0.740000] bootconsole [early0] disabled
> 
