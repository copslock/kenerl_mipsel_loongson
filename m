Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 13:11:00 +0000 (GMT)
Received: from exprod8og51.obsmtp.com ([64.18.3.84]:5536 "HELO
	exprod8og51.obsmtp.com") by ftp.linux-mips.org with SMTP
	id S20021662AbXCPNKy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 13:10:54 +0000
Received: from source ([12.110.134.31]) by exprod8ob51.obsmtp.com ([64.18.7.12]) with SMTP;
	Fri, 16 Mar 2007 06:09:16 PDT
Received: from PKONING-LAPTOP.equallogic.com ([172.16.1.118]) by M31.equallogic.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 16 Mar 2007 09:09:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17914.38675.653000.256@gargle.gargle.HOWL>
Date:	Fri, 16 Mar 2007 09:09:39 -0400
From:	Paul Koning <pkoning@equallogic.com>
To:	bug-binutils@gnu.org, linux-mips@linux-mips.org, hjl@lucon.org
Subject: Re: 'final link failed: Bad value' when building Linux/MIPS kernels.
References: <45FA027E.2080901@realitydiluted.com>
X-Mailer: VM 7.07 under 21.4 (patch 19) "Constant Variable" XEmacs Lucid
X-OriginalArrivalTime: 16 Mar 2007 13:09:39.0544 (UTC) FILETIME=[5AAA2D80:01C767CC]
Return-Path: <pkoning@equallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkoning@equallogic.com
Precedence: bulk
X-list: linux-mips

>>>>> "Steven" == Steven J Hill <sjhill@realitydiluted.com> writes:

 Steven> Greetings.  I have been chasing down a binutils regression
 Steven> that is preventing me from building a Linux/MIPS kernel using
 Steven> a gcc-4.2 based toolchain. Here is the snippet of output when
 Steven> building a 2.6.12 kernel for my platform:

 Steven>      LD      drivers/mtd/maps/built-in.o
 Steven>      LD      drivers/mtd/nand/built-in.o
 Steven>      LD      drivers/mtd/built-in.o
 Steven>    mipsel-linux-uclibc-ld: final link failed: Bad value
 Steven>    make[1]: *** [drivers/mtd/built-in.o] Error 1
 Steven>    make: *** [_module_drivers/mtd] Error 2

I've run into the same message when building things for a NetBSD/MIPS
target.   I had assumed it was some error on my end.  

The problem with this message is that it is completely content-free.
It doesn't contain a meaningful problem statement, and it doesn't say
anything at all about where the problem is.  It doesn't even indicate
what input file triggered the problem!   How is a user supposed to fix
a failed build when this error message appears?  

    paul
