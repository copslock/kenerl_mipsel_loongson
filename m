Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 14:53:02 +0200 (CEST)
Received: from [202.56.196.162] ([202.56.196.162]:51045 "EHLO
	brahma.intotoind.com") by linux-mips.org with ESMTP
	id <S1123891AbSJQMxB>; Thu, 17 Oct 2002 14:53:01 +0200
Received: (from rajeshbv@localhost)
	by brahma.intotoind.com (8.11.6/8.11.6) id g9HCqDn20758;
	Thu, 17 Oct 2002 18:22:13 +0530
Received: from localhost (rajeshbv@localhost)
	by brahma.intotoind.com (8.11.6/8.11.6) with ESMTP id g9HCqBR20751;
	Thu, 17 Oct 2002 18:22:11 +0530
X-Authentication-Warning: brahma.intotoind.com: rajeshbv owned process doing -bs
Date: Thu, 17 Oct 2002 18:22:11 +0530 (IST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
X-X-Sender: <rajeshbv@brahma.intotoind.com>
To: <linux-mips@linux-mips.org>
cc: <rajeshbv@intotoinc.com>
Subject: Problems in Remote Debugging
Message-ID: <Pine.LNX.4.33.0210171821230.20688-100000@brahma.intotoind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by AMaViS perl-11
Return-Path: <rajeshbv@intotoinc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajeshbv@intotoinc.com
Precedence: bulk
X-list: linux-mips

Hi All,

I am using "insmod" part of busybox version 0.51 to insert my driver 
module into 2.4.3 linux on 79S334 board.

For remote debugging we need to do insert the module with "-m" option, 
which is not supported by this version of busybox.
So can anybody who are working with this option, can send across the 
binary for me. I want the LITTLE ENDIAN version.

Secondly, i am using "mips_fp_le-gdb" from montavista for remote 
debugging. The problem i am facing with this gdb is "Ctrl+C" is not 
working. Is there any alternative to make it work ?

Regards,
--Rajesh
