Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2011 21:02:22 +0100 (CET)
Received: from gateway08.websitewelcome.com ([69.56.159.17]:42828 "HELO
        gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491026Ab1AHUCS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jan 2011 21:02:18 +0100
Received: (qmail 11715 invoked from network); 8 Jan 2011 20:01:45 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 8 Jan 2011 20:01:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=PwbZgVu+u5JJAW7ln0/Gj34FplnapnFhUOEQ34nGoG2V80l5z1YSQaHUXKZBH4fSQB5lfuLYe15D4fJkpYJnS3W3OKGkbOZk/JyVPTK/VUS9+p8y+tYziVdvCH8L2Lk3;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:1585 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PbezL-0000Wm-SJ; Sat, 08 Jan 2011 14:02:11 -0600
Message-ID: <4D28C2C7.2080005@paralogos.com>
Date:   Sat, 08 Jan 2011 12:02:15 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Linux MIPS org <linux-mips@linux-mips.org>,
        tsbogend@alpha.franken.de
Subject: Re: MIPS Malta and PCNet32 Driver
References: <4D28AFB4.7090108@paralogos.com>
In-Reply-To: <4D28AFB4.7090108@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

and, amusingly, from a stock 2.6.32.27 kernel that exhibits the problem,
I plugged in a PCI NIC and *both* interfaces came up happy.  :o/   One
might suspect that PCNet32 now assumes some level of initialization that
isn't being done in the platform code, and lucks out if a more
thoroughly paranoid driver gets loaded first.

/K.

On 1/8/2011 10:40 AM, Kevin D. Kissell wrote:
> As per an email to the linux-mips group from Thomas Schwinge on July 30,
> 2010, there's a problem using current (post 2.6.29) sources for a kernel
> with the pcnet32 driver with the PCNet32 chip on the MIPS Malta platform
> in some configurations.  The probe1 routine fails the test below and
> spits out the "No access methods" diagnostic:
>
> ...
>         /* NOTE: 16-bit check is first, otherwise some older PCnet chips
> fail */
>         if (pcnet32_wio_read_csr(ioaddr, 0) == 4 &&
> pcnet32_wio_check(ioaddr)) {
>                 a = &pcnet32_wio;
>         } else {
>                 pcnet32_dwio_reset(ioaddr);
>                 if (pcnet32_dwio_read_csr(ioaddr, 0) == 4
>                     && pcnet32_dwio_check(ioaddr)) {
>                         a = &pcnet32_dwio;
>                 } else {
>                         if (pcnet32_debug & NETIF_MSG_PROBE)
>                                 printk(KERN_ERR PFX "No access methods\n");
>                         goto err_release_region;
>                 }
>         }
>
> The chip is visible to the kernel and turns up in lspci:
>
> -bash-3.1# lspci -tv
> -[0000:00]-+-0a.0  Intel Corporation 82371AB/EB/MB PIIX4 ISA
>            +-0a.1  Intel Corporation 82371AB/EB/MB PIIX4 IDE
>            +-0a.2  Intel Corporation 82371AB/EB/MB PIIX4 USB
>            +-0a.3  Intel Corporation 82371AB/EB/MB PIIX4 ACPI
>            +-0b.0  Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE]
>            +-0c.0  Cirrus Logic Crystal CS4281 PCI Audio
>            +-11.0  MIPS Technologies, Inc. SOC-it 101 System Controller
>            \-13.0-[0000:01]----00.0  Matrox Graphics, Inc. G400/G450
> -bash-3.1# lspci -n
> 00:0a.0 0601: 8086:7110 (rev 02)
> 00:0a.1 0101: 8086:7111 (rev 01)
> 00:0a.2 0c03: 8086:7112 (rev 01)
> 00:0a.3 0680: 8086:7113 (rev 02)
> 00:0b.0 0200: 1022:2000 (rev 44)
> 00:0c.0 0401: 1013:6005 (rev 01)
> 00:11.0 0600: 153f:0001 (rev 01)
> 00:13.0 0604: 3388:0021 (rev 13)
> 01:00.0 0300: 102b:0525 (rev 85)
>
> I'm suspecting that the problem is at least as likely to be in the Malta
> PCI support as in the PCNet driver itself.  Is this phenomenon
> understood? Has there been a fix circulated for it?
>
>             Regards,
>
>             Kevin K.
>
