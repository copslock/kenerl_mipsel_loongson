Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 16:37:41 +0100 (BST)
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([IPv6:::ffff:65.32.5.131]:53150
	"EHLO ms-smtp-01.tampabay.rr.com") by linux-mips.org with ESMTP
	id <S8225297AbVHKPhU>; Thu, 11 Aug 2005 16:37:20 +0100
Received: from [192.168.1.50] (57.85.118.70.cfl.res.rr.com [70.118.85.57])
	by ms-smtp-01.tampabay.rr.com (8.12.10/8.12.7) with ESMTP id j7BFfPEg010255
	for <linux-mips@linux-mips.org>; Thu, 11 Aug 2005 11:41:27 -0400 (EDT)
Message-ID: <42FB71D4.9040408@gentoo.org>
Date:	Thu, 11 Aug 2005 11:42:12 -0400
From:	Aaron Walker <ka0ttic@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050807)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: IP30 hang on warm boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <ka0ttic@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ka0ttic@gentoo.org
Precedence: bulk
X-list: linux-mips

Gentoo has been running flawlessly on this IP30 for the last month I've had it,
except for one thing.  I've noticed that when I reboot, it hangs at the below
denoted spot:

<dmesg>
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)


 >>> HANGS HERE


IOC3 SuperIO: registered IOC3 at 900000001f600000, IRQ 12 (chip 0).
ttyS0 at IOC3 0x1f620178 (irq = 64) is a 16550A
ttyS1 at IOC3 0x1f620170 (irq = 65) is a 16550A
Found DS2502 NIC registration number 21:e5:b0:02:00:00, CRC 9b.
Ethernet address is 08:00:69:13:6f:e1.
eth0: link up, 100Mbps, full-duplex, lpa 0x01E1
eth0: Using PHY 1, vendor 0x15f42, model 2, rev 3.
eth0: IOC3 SSRAM has 128 kbyte.
qla1280: QLA1040 found on PCI bus 0, dev 0
PCI: Enabling device 0000:00:00.0 (0006 -> 0007)
</dmesg>

This happens every single warm boot, and never on a cold boot.  This box is
running gentoo's mips-sources-2.6.12 kernel (l-m.org cvs 20050703).  I've 
posted the actual config[1] if it helps.

[1] http://dev.gentoo.org/~ka0ttic/mips/ip30/ip30-config

Thanks
-- 
Science and religion are in full accord but science and faith are in complete
discord.

Aaron Walker <ka0ttic@gentoo.org>
[ BSD | commonbox | cron | cvs-utils | mips | netmon | shell-tools | vim ]
