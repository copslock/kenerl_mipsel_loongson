Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 09:18:18 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:15261 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133564AbVI0IR7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Sep 2005 09:17:59 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 4356EC05D
	for <linux-mips@linux-mips.org>; Tue, 27 Sep 2005 10:17:44 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 5EDCC1BC085
	for <linux-mips@linux-mips.org>; Tue, 27 Sep 2005 10:17:45 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 2B3011A18C6
	for <linux-mips@linux-mips.org>; Tue, 27 Sep 2005 10:17:46 +0200 (CEST)
Subject: Floating point performance
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 27 Sep 2005 10:17:07 +0200
Message-Id: <1127809027.26702.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

I've built soft float toolchain (with crosstool) and then build
MPlayer with it. The performance is very low. I cannot even
play the mp3 file with MPlayer on DBAU1200 with 400MHz CPU!

I used
GCC: 3.3.5
GLIBC: 2.3.5
BINUTILS: 2.16.1

I did some profiling and this is what I get:
-----------------------------------------------------------------------------------
Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total           
 time   seconds   seconds    calls   s/call   s/call  name    
 18.09     44.70    44.70                             __pack_f
 17.30     87.44    42.74                             _fpadd_parts
 15.82    126.54    39.10                             __mulsf3
 15.28    164.31    37.77                             __unpack_f
  6.49    180.36    16.05                             _fpadd_parts
  5.30    193.45    13.09    17424     0.00     0.00  dct64_1
  4.75    205.18    11.73                             __subsf3
  4.04    215.16     9.98                             __addsf3
  3.68    224.26     9.10    17424     0.00     0.00  synth_1to1
  1.90    228.96     4.70                             __pack_d
  1.20    231.92     2.96                             __unpack_d
  1.17    234.80     2.88                             __muldf3
-----------------------------------------------------------------------------------

As it seems, all the time is spent in the FP routines. 
I decided to use SF toolchain, because they should be faster
then FPU emulator (at least it is on ARM), but did no test
this with emulator.

Does anybody use MPlayer on MIPS? 
What performance do you get?
Any other suggestions?

BR,
Matej
