Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 20:11:49 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44534 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDXTLs>;
	Thu, 24 Apr 2003 20:11:48 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3OJBeE28953;
	Thu, 24 Apr 2003 12:11:40 -0700
Date: Thu, 24 Apr 2003 12:11:40 -0700
From: Jun Sun <jsun@mvista.com>
To: Jeff Baitis <baitisj@evolution.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Au1500 PCI autoconfig issues with multiple PCI devices?
Message-ID: <20030424121140.G28275@mvista.com>
References: <20030424114832.O10148@luca.pas.lab>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030424114832.O10148@luca.pas.lab>; from baitisj@evolution.com on Thu, Apr 24, 2003 at 11:48:32AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



On Thu, Apr 24, 2003 at 11:48:32AM -0700, Jeff Baitis wrote:
> Hi ya'll:
> 
> This is the first time I've tried multiple PCI devices on the Au1500. I have a
> PCI->CardBus bridge and a 3Com ethernet plugged into the Au1500's PCI bus. I'm
> using the linux_2_4 branch.
>
<snip>

Try this patch and let me know the results.

BTW, I did not know Au1500 has a cardbus controller.  I was under impression
it is a PCMCIA controller.  Interesting.

Jun

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru link/arch/mips/kernel/pci_auto.c.orig link/arch/mips/kernel/pci_auto.c
--- link/arch/mips/kernel/pci_auto.c.orig	Thu Apr 10 14:13:57 2003
+++ link/arch/mips/kernel/pci_auto.c	Thu Apr 24 12:10:16 2003
@@ -354,8 +354,8 @@
 	 * configured by this routine to happily live behind a
 	 * P2P bridge in a system.
 	 */
-	pciauto_upper_memspc += 0x00400000;
-	pciauto_upper_iospc += 0x00004000;
+	pciauto_lower_memspc += 0x00400000;
+	pciauto_lower_iospc += 0x00004000;
 
 	/* Align memory and I/O to 4KB and 4 byte boundaries. */
 	pciauto_lower_memspc = (pciauto_lower_memspc + (0x1000 - 1))

--x+6KMIRAuhnl3hBn--
