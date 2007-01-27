Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2007 17:29:36 +0000 (GMT)
Received: from mx5.wp.pl ([212.77.101.9]:33873 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20037612AbXA0R3b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2007 17:29:31 +0000
Received: (wp-smtpd smtp.wp.pl 5302 invoked from network); 27 Jan 2007 18:28:27 +0100
Received: from apn-237-18.gprsbal.plusgsm.pl (HELO [87.251.237.18]) (laurentp@[87.251.237.18])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <florian.fainelli@int-evry.fr>; 27 Jan 2007 18:28:27 +0100
Message-ID: <45BB8C5D.50405@wp.pl>
Date:	Sat, 27 Jan 2007 18:31:09 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	Florian Fainelli <florian.fainelli@int-evry.fr>,
	linux-mips@linux-mips.org
Subject: Re: RTL-8186 follow-up
References: <5C1FD43E5F1B824E83985A74F396286E041B10FB@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <45BA94FF.4080301@wp.pl> <45BB4DF8.7070006@wp.pl> <200701271354.41905.florian.fainelli@int-evry.fr>
In-Reply-To: <200701271354.41905.florian.fainelli@int-evry.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

<cut>
1). I have added modules found in KERNEL_SRC/rtl8186 (that i wrote about
in other post), to image, but trying to load them gives "unresolved
symbol" errors:

<example>
# insmod ip_nat_l2tp
Using /lib/modules/2.4.18-MIPS-01.00/ip_nat_l2tp.o
insmod: unresolved symbol kmalloc
insmod: unresolved symbol create_proc_entry
insmod: unresolved symbol ip_nat_helper_register
insmod: unresolved symbol ip_nat_helper_unregister
insmod: unresolved symbol csum_partial
insmod: unresolved symbol sprintf
</example>

This problem is very of interest, because there are modules for IP_SEC,
and a module rtl8186 (NIC driver??) that is much SMALLER that module
with the same name rtl8186 generated during kernel compilation. There is
also module named wireless_ag_net.

2). Is there some possibility to "recover" using serial port if it
happens to corrupt kernel to point to not have network access? (I mean
NOT using JTAG).??

3). Florian, could you help me to "reverse engineer" Edimax-supplied
firmware image? AFAIR it is composed of header, compressed vmlinux and
compressed initrd. But how to find at what offset those images are?, and
how are they compressed.

W.P.
