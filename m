Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2003 20:23:57 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:24540 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225202AbTCNUX4>;
	Fri, 14 Mar 2003 20:23:56 +0000
Received: (qmail 5876 invoked by uid 6180); 14 Mar 2003 20:23:52 -0000
Date: Fri, 14 Mar 2003 12:23:52 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Success! Full CardBus/EXCA on PCI->Cardbus Bridge + DbAU1500
Message-ID: <20030314122352.F20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Everyone:

Thank you very much for helping this green hand get up to speed on the MIPS
platform.  I have successfully configured card services to work with the
current linux_2_4 CVS, in conjunction with a TI PCI1510 PCI->CardBus bridge.

There are a few card services options that you will need, in order to replicate
my work:

1. The pcmcia_core cis_speed needs to be set to a fairly low value.
   I have successfully used `modprobe pcmcia_core cis_speed=10` and 
   `modprobe pcmcia_core cis_speed=1.`

2. The PCMCIA memory window must map into the memory window assigned
   by the PCI device autoconfiguration. Since my `lspci -v` shows:

   00:0d.0 CardBus bridge: Texas Instruments: Unknown device ac56
       Subsystem: Unknown device 5678:1234
       Flags: bus master, medium devsel, latency 168, IRQ 1
       Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
       Bus: primary=00, secondary=05, subordinate=00, sec-latency=176
       Memory window 0: 40001000-40002000 (prefetchable)
       Memory window 1: 40400000-407ff000
       I/O window 0: 00004000-000040ff
       I/O window 1: 00004400-000044ff
       16-bit legacy interface ports at 0001
 
   I configured /etc/pcmcia/config.opts as follows:

       #
       # Local PCMCIA Configuration File
       #
       #----------------------------------------------------------------------
       
       # System resources available for PCMCIA devices
       # remember to modprobe pcmcia_core cis_speed=10
       
       include port 0x100-0x4ff, port 0xc00-0xcff
       include memory 0x40000000-0x40ffffff

       #-------------------------- eof 


Special thanks to Pete for answering so many of my questions.


I hope you find this information useful!



Best regards,

Jeff



-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
