Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2003 23:13:00 +0100 (BST)
Received: from turbonet-2.nethere.net ([IPv6:::ffff:66.63.144.170]:54431 "HELO
	mail.correlant.com") by linux-mips.org with SMTP
	id <S8225227AbTFKWM6>; Wed, 11 Jun 2003 23:12:58 +0100
Received: from tcernius (212.82.218.209.transedge.com [209.218.82.212])
	by mail.correlant.com (Postfix) with SMTP
	id 3A5FDBC118; Wed, 11 Jun 2003 15:12:58 -0700 (PDT)
From: "Tom Cernius" <tcernius@correlant.com>
To: <ppopov@mvista.com>
Cc: <linux-mips@linux-mips.org>
Subject: FW: Db1500 PCI Auto Scan Question
Date: Wed, 11 Jun 2003 15:12:18 -0700
Message-ID: <000201c33066$8623dac0$d452dad1@correlant.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <tcernius@correlant.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tcernius@correlant.com
Precedence: bulk
X-list: linux-mips

Hello,

   I am porting my first PCI driver for a PCI card hosted by the AMD Db1500
"Zinfandel" development board.
   This driver had been previously working on another host, where
CONFIG_PCI_AUTO was not enabled.

    My PCI card REQUIRES 0xFF000000 and 0x90000000 be programmed into BAR0
and BAR1 respectively.
    My PCI card has nothing programmed into BAR0 and BAR1 at power-up.
    My host Linux kernel was built with CONFIG_PCI, CONFIG_NEW_PCI, and
CONFIG_PCI_AUTO turned on in the .config file.

     I noticed that during boot, the kernel tickles my devices BAR's and
then writes these BARs with addresses in the range of
     4000 0000 thru 43FF FFFF

     I have tried everything and although I am able to write the proper
(0xFF00 0000 and 0x9000 0000) addresses into the BAR's,
     I have been unable to successfully read anything from my PCI cards CPU
Register/Sdram space.

     I suspect that it is NOT possible to use hardcoded PCI BAR addresses
with the MIPS processor AND CONFIG_PCI_AUTO turned on,
     as the kernel expects (and configures the PCI BARS of) PCI devices to
reside in the address space 0x4000 0000 thru 0x43FF FFFF ??

     I tried disabling the device, updating my BARS, reenabling in the
driver code (a loadable module).
     I tried writing the BARS just prior to tickling in the
linux/arch/mips/kernel/pci_auto.c code.
     I tried writing the BARS as soon as my device/vendor id are detected
also in the linux/arch/mips/kernel/pci_auto.c code.

Thanks,
Tom
