Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 00:52:12 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:43026 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491794Ab0BVXwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 00:52:04 +0100
Received: by bwz7 with SMTP id 7so2099133bwz.24
        for <multiple recipients>; Mon, 22 Feb 2010 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=n3xuzzJyGKeYJbChfb3eiU9M/daetnwDOn1ZGgx05HY=;
        b=fziYWZkeca2Ytp2fZsoioWVwcSsppCePXMKvhgpxyQPNBjT5s7s+xT7Kp9nQ3ttgwT
         7TJ9E+jmB0roRptWYxzfok7lriwtnlauqbjzC2YEAeKsnkD7V6cFdM9eNXaoZMCKCz+Y
         sBsPQ30ol8UwfnW4mYSR92TjEzAFao8jedWKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=c3exOK+KdjEAw3FYAXLwAV/ai/W0b0qBBBEPZgsK8TXS/YaxQ8IppNkr0cwe64aglP
         NNgDPTP6IeIaXd5fZGc8vOAaoXZodeMRxtT4nznDl1g3vfU4hg0PiwEB4K0qe49VYLgY
         SH3+f0fK2EIy0WrBXJJLoZ2yMtAKVVHiklSt4=
Received: by 10.204.4.150 with SMTP id 22mr3273787bkr.192.1266882717400;
        Mon, 22 Feb 2010 15:51:57 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm1426838bwz.10.2010.02.22.15.51.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 15:51:55 -0800 (PST)
Date:   Tue, 23 Feb 2010 08:51:43 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: Reverting old hack
Message-Id: <20100223085143.aeb1fa53.yuasa@linux-mips.org>
In-Reply-To: <201002221355.28939.bjorn.helgaas@hp.com>
References: <20100220113134.GA27194@linux-mips.org>
        <1266677869.1320.8.camel@dc7800.home>
        <20100221164531.382b3785.yuasa@linux-mips.org>
        <201002221355.28939.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Bjorn,

On Mon, 22 Feb 2010 13:55:28 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Sunday 21 February 2010 12:45:31 am Yoichi Yuasa wrote:
> > > I'd like to understand the PCI architecture of Cobalt better.  Would you
> > > mind turning on CONFIG_PCI_DEBUG and posting the dmesg log?
> > 
> > If you want to know what happen, you can see my old e-mail. 
> > 
> > http://marc.info/?l=linux-kernel&m=118792430424186&w=2
> 
> There's not much detail there.  It would save me a lot of time if
> you could collect the complete dmesg log, /proc/iomem, and /proc/ioports.

It cannot boot without old hack.
I just got a console capture.

Yoichi

----
2> execute console=ttyS0,115200 root=/dev/sda2
elf32: 00080000 - 004220ef (800841f0) (ffffffff.80000000)
elf32: 80080000 (80080000) 3694756t + 114764t
net: interface down
Cobalt board ID: 5
pci 0000:00:07.0: BAR 6: assigned [mem 0x12000000-0x1203ffff pref]
pci 0000:00:0c.0: BAR 6: assigned [mem 0x12040000-0x1207ffff pref]
pci 0000:00:0a.0: BAR 0: assigned [mem 0x12080000-0x12080fff]
pci 0000:00:0a.0: BAR 0: set to [mem 0x12080000-0x12080fff] (PCI address [0x12080000-0x12080fff]
pci 0000:00:0a.1: BAR 0: assigned [mem 0x12081000-0x12081fff]
pci 0000:00:0a.1: BAR 0: set to [mem 0x12081000-0x12081fff] (PCI address [0x12081000-0x12081fff]
pci 0000:00:07.0: BAR 1: assigned [mem 0x12082000-0x120823ff]
pci 0000:00:07.0: BAR 1: set to [mem 0x12082000-0x120823ff] (PCI address [0x12082000-0x120823ff]
pci 0000:00:0c.0: BAR 1: assigned [mem 0x12082400-0x120827ff]
pci 0000:00:0c.0: BAR 1: set to [mem 0x12082400-0x120827ff] (PCI address [0x12082400-0x120827ff]
pci 0000:00:0a.2: BAR 0: assigned [mem 0x12082800-0x120828ff]
pci 0000:00:0a.2: BAR 0: set to [mem 0x12082800-0x120828ff] (PCI address [0x12082800-0x120828ff]
pci 0000:00:07.0: BAR 0: assigned [io  0x1000-0x107f]
pci 0000:00:07.0: BAR 0: set to [io  0x1000-0x107f] (PCI address [0x10001000-0x1000107f]
pci 0000:00:0c.0: BAR 0: assigned [io  0x1080-0x10ff]
pci 0000:00:0c.0: BAR 0: set to [io  0x1080-0x10ff] (PCI address [0x10001080-0x100010ff]
pci 0000:00:09.2: BAR 4: assigned [io  0x1400-0x141f]
pci 0000:00:09.2: BAR 4: set to [io  0x1400-0x141f] (PCI address [0x10001400-0x1000141f]
pci 0000:00:09.1: BAR 4: assigned [io  0x1420-0x142f]
pci 0000:00:09.1: BAR 4: set to [io  0x1420-0x142f] (PCI address [0x10001420-0x1000142f]
Switching to clocksource MIPS
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:00:09.0: Activating ISA DMA hang workarounds
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 245
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
fb0: Cobalt server LCD frame buffer device
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
_serial8250.0: ttyS0 at MMIO 0x1c800000 (irq = 21) is a ST16650V2_console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
loop: module loaded
pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]
pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]
pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
pata_via 0000:00:09.1: no available native port
physmap platform flash device: 00080000 at 1fc00000
Found: AMD AM29F040
physmap-flash.0: Found 1 x8 devices at 0x0 in 8-bit bank
number of JEDEC chips: 1
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition information
Creating 1 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000080000 : "firmware"
Linux Tulip driver version 1.1.15 (Feb 27, 2007)
PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21142/43 Tulip rev 65 at Port 0x1000, --:--:--:--:--:--, IRQ 19.
PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
tulip1: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth1: Digital DS21142/43 Tulip rev 65 at Port 0x1080, --:--:--:--:--:--, IRQ 20.
input: Cobalt buttons as /devices/platform/Cobalt buttons/input/input0
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day, 242 bytes nvram
Registered led device: qube::front
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
rtc_cmos rtc_cmos: setting system clock to 2010-02-21 23:19:20 UTC (1266794360)
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
