Received:  by oss.sgi.com id <S42366AbQIOKCM>;
	Fri, 15 Sep 2000 03:02:12 -0700
Received: from gw-nl4.philips.com ([192.68.44.36]:9478 "EHLO
        gw-nl4.philips.com") by oss.sgi.com with ESMTP id <S42361AbQIOKB4>;
	Fri, 15 Sep 2000 03:01:56 -0700
Received: from smtprelay-nl1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl4.philips.com with ESMTP id MAA02821;
          Fri, 15 Sep 2000 12:01:32 +0200 (MEST)
          (envelope-from niessena@natlab.research.philips.com)
Received: from smtprelay-eur1.philips.com(130.139.36.3) by gw-nl4.philips.com via mwrap (4.0a)
	id xma002818; Fri, 15 Sep 00 12:01:32 +0200
Received: from natlab.research.philips.com (prle.natlab.research.philips.com [130.139.161.112]) 
	by smtprelay-nl1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with SMTP id MAA11040; Fri, 15 Sep 2000 12:01:31 +0200 (MET DST)
Received: by natlab.research.philips.com; Fri, 15 Sep 2000 12:01:28 +0200
Received: by pc4755.natlab.research.philips.com; Fri, 15 Sep 2000 12:01:27 +0200
Date:   Fri, 15 Sep 2000 12:01:27 +0200
From:   Arnold Niessen <niessena@natlab.research.philips.com>
To:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-kernel@vger.kernel.org
Cc:     Evgeni Eskenazi <eskenazi@natlab.research.philips.com>
Subject: FPU problems porting 2.4.0 to Algorithmics P4032 MIPS board
Message-Id: <20000915120127.A1453@pc4755.natlab.research.philips.com>
Reply-To: Arnold Niessen <arnold.niessen@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vi
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello Ralf, others,

We are porting the new 2.4.0 series Linux kernel to Algorithmics 
P4032 board with MIPS processor (QED-RM5230).  We ported 
2.4.0-test5 kernel. We already succeeded in porting the following 
code, partly based on the changes made by MIPS Technologies
for the 2.2.12/P5064 patch:
      1. Memory management & timer related stuff
      2. Support for PCI devices
      3. Support of the onboard SCSI controller
      4. Support of the onboard Ethernet controller
      5. Support for the Serial lines
We've got a problem with the foating point support. With either 
soft or hard FP support, some FP operation generate an exception, 
e.g. cvt.w.d.

We tried both with and without support of FPE soft module, 
compiled for R46xx and R5000 processors (As far as I
understand there is no difference in FP support in the kernel 
for these processor types).

We did not have these problems with the (2.2.12 MIPS Technologies
based) port we made to this same board.

We would appreciate any ideas how to solve the problem.


Algorithmics P4032 board consists of:
1. QED - RM5230 (the documentation claims that it fully 
    supports MIPS IV level)
2. V3 V962PBC PCI adapter
3. Onboard Symbios 53c810a SCSI chipset
4. Onboard Tulip 21041 Ethernet controller
5. Combi I/O controller for 2 RS232 serial ports, centronics 
   parallel port and disk drive.

Best regards and thanks in advance,
Evgeni Eskenazi,
Arnold Niessen
-- 
A.J. Niessen                  | Philips Research Laboratories
Building WL 1.613             | Prof. Holstlaan 4
Phone: (+31-40-27)42715       | 5656 AA Eindhoven
Fax: (+31-40-27)44004         | The Netherlands
E-Mail:                   arnold.niessen@philips.com
E-Mail on mailing lists:  niessen@iae.nl
