Received:  by oss.sgi.com id <S42299AbQFSXCH>;
	Mon, 19 Jun 2000 16:02:07 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:57173 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42239AbQFSXBu>;
	Mon, 19 Jun 2000 16:01:50 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA21332
	for <linux-mips@oss.sgi.com>; Mon, 19 Jun 2000 15:56:52 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA78826 for <linux-mips@oss.sgi.com>; Mon, 19 Jun 2000 16:01:18 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA46334
	for <linux@engr.sgi.com>;
	Mon, 19 Jun 2000 15:59:28 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07184
	for <linux@engr.sgi.com>; Mon, 19 Jun 2000 15:59:20 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id PAA19464;
	Mon, 19 Jun 2000 15:58:40 -0700
Message-ID: <394EA5A0.B882F66A@mvista.com>
Date:   Mon, 19 Jun 2000 15:58:40 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: R5000 support (specifically two-way set-associative cache...)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I looked into the R5000 support and have a couple of questions:

1. Is R5000, specifically NEC Vr5000, fully supported?  I have seen
CONFIG_CPU_R5000 defined, but it does not appear to do much.

2. Specifically, NEC Vr5000 has two-way set-associative cache.  I
browsed through the cache code, and got concerned that I don't see any
code that seems to take care of that.  Do I miss something?

3. I understand Geert has a port to DDB5074 (with Vr5000 CPU).  Is this
port completed (including all interrupts, PCI related stuff).  Is this
port reliable?


Thanks a lot.

Jun
