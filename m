Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2007 15:44:43 +0000 (GMT)
Received: from mx1.wp.pl ([212.77.101.5]:27006 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20037577AbXA0Poi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2007 15:44:38 +0000
Received: (wp-smtpd smtp.wp.pl 885 invoked from network); 27 Jan 2007 16:43:34 +0100
Received: from apn-237-18.gprsbal.plusgsm.pl (HELO [87.251.237.18]) (laurentp@[87.251.237.18])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <florian.fainelli@int-evry.fr>; 27 Jan 2007 16:43:34 +0100
Message-ID: <45BB73C7.2000308@wp.pl>
Date:	Sat, 27 Jan 2007 16:46:15 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	Florian Fainelli <florian.fainelli@int-evry.fr>,
	linux-mips@linux-mips.org
Subject: Re: RTL-8186 follow-up
References: <5C1FD43E5F1B824E83985A74F396286E041B10FB@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <45BA94FF.4080301@wp.pl> <45BB4DF8.7070006@wp.pl> <200701271354.41905.florian.fainelli@int-evry.fr>
In-Reply-To: <200701271354.41905.florian.fainelli@int-evry.fr>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

U¿ytkownik Florian Fainelli napisa³:

<cut>

>>Which kernel did you run ? Which toolchain did you use ?

1). I used a toolchain found on Edimax site, I have described in earlier
post. It seems to be:
         gcc: mips-linux-gcc (GCC) 3.3.3,
        binutils: GNU ld version 2.14.90.0.7 20031029, compiled for/with
uClibc 0.9.26. Whole toolchain is in package named lexra-nnop-v5.
          kernel source: 2.4.18, apart normal kernel tree, there are two
directories: /rtl8186/ containing several modules:->

-rw-r--r-- 1 root root  14012 kwi 21  2005 fast_nat.o
-rw-r--r-- 1 root root   3804 kwi 21  2005 ip_conntrack_ipsec.o
-rw-r--r-- 1 root root   6532 kwi 21  2005 ip_nat_ipsec.o
-rw-r--r-- 1 root root   4100 kwi 21  2005 ip_nat_l2tp.o
-rw-r--r-- 1 root root 284100 kwi 21  2005 ipsec.o
-rw-r--r-- 1 root root  34692 kwi 21  2005 mtdlink_gw.o
-rw-r--r-- 1 root root  30152 kwi 21  2005 mtdlink.o
-rw-r--r-- 1 root root  17352 kwi 21  2005 rtl8186.o
-rw-r--r-- 1 root root 386016 kwi 21  2005 wireless_ag_net.o

and a directory rtkload with scripts and program cvimg.

2). On net i have uploaded some files from /proc directory - again from
1.48 firmware.

3). If you have more questions/proposals do not hesitate. Only one thing
to remember: i'm NOT a C programmer, i only try to little modify Edimax
firmware to use it as cheap RS-232->Ethernet converter.

W.P.
