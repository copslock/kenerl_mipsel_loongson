Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 17:32:42 +0100 (BST)
Received: from host31.ipowerweb.com ([IPv6:::ffff:12.129.198.131]:7400 "EHLO
	host31.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8225229AbTGXQck>; Thu, 24 Jul 2003 17:32:40 +0100
Received: from rrcs-central-24-123-115-42.biz.rr.com ([24.123.115.42] helo=radium)
	by host31.ipowerweb.com with esmtp (Exim 3.36 #1)
	id 19fj15-0000Fl-00; Thu, 24 Jul 2003 09:32:31 -0700
From: "Lyle Bainbridge" <lyle@zevion.com>
To: "'David Kesselring'" <dkesselr@mmc.atmel.com>,
	<linux-mips@linux-mips.org>
Subject: RE: boot requirements
Date: Thu, 24 Jul 2003 11:32:28 -0500
Message-ID: <000001c35201$2dbcd1e0$2a737b18@radium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <Pine.GSO.4.44.0307241019450.23101-100000@ares.mmc.atmel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host31.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - zevion.com
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Hi,

Creating a simple boot loader:

Well firstly, you'll need to at least implement some
initialization code specific to your processor. Typically
for MIPS this would involve initializing CP0, the cache
and TLB. Then perhaps some peripheral initialization such
as clocks, static memory and SDRAM controllers.  Then the
stack pointer needs to be set to a suitable location
being carefull to word align.

Ok, well that's just the reset code for your processor.
What you need to fo for the Linux kernel depends on where it
is stored and whether it is compressed. Loading from a disk
requires a slightly less than trivial bootloader. For the
sake of discussion I'll assume the kernel is located in flash:

For compressed kernel in flash with ELF header:
  a. Uncompress the kernel to RAM.
  b. Read the ELF header to determine layout of sections
     and kernel entry point.
  c. Copy sections to memory as specified in ELF header.
  d. Jump to kernel entry point.
  e. Kernel does the rest :)

If the kernel is not compress then obviously this step can
be skipped. This is a pretty minimal boot loader and easy
to implement.

> I am trying to determine what has to be included in our boot 
> code to start linux. I didn't think I needed to port yamon. 
> What does yamon or pmon provide for starting or 
> debugging(gdb) linux? Does the processor need to be in a 
> specific state or context before jumping from the boot code 
> to the linux downloaded image? If someone can point me to a 
> simple example, I would greatly appreciate it.
> 
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
> 
