Received:  by oss.sgi.com id <S305156AbPKHSY3>;
	Mon, 8 Nov 1999 10:24:29 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:33888 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbPKHSYQ>;
	Mon, 8 Nov 1999 10:24:16 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA10236698
	for <linuxmips@oss.sgi.com>; Mon, 8 Nov 1999 10:29:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA11993
	for linux-list;
	Mon, 8 Nov 1999 10:03:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA05908
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Nov 1999 10:03:38 -0800 (PST)
	mail_from (fpound@fallschurch.esys.com)
Received: from igate1.fallschurch.esys.com (igate1.fallschurch.esys.com [198.4.96.17]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA10059684
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Nov 1999 10:03:37 -0800 (PST)
	mail_from (fpound@fallschurch.esys.com)
Received: by igate1.fallschurch.esys.com; id NAA12915; Mon, 8 Nov 1999 13:03:29 -0500 (EST)
Received: from unknown(199.170.244.43) by igate1.fallschurch.esys.com via smap (4.1)
	id xmad12431; Mon, 8 Nov 99 13:03:06 -0500
Received: from mailhub.fcd.esys.com (mailhub.fcd.esys.com [199.170.224.9])
	by igate5.fcd.esys.com (8.9.3/8.9.3) with ESMTP id NAA15100
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Nov 1999 13:00:30 -0500 (EST)
Received: from crackle.ssw.fcd.esys.com (crackle.ssw.fcd.esys.com [192.53.95.21])
	by mailhub.fcd.esys.com (8.9.3/8.9.3) with ESMTP id NAA01155;
	Mon, 8 Nov 1999 13:00:56 -0500 (EST)
Received: from fallschurch.esys.com (ws237091.fcd.esys.com [199.170.237.91])
	by crackle.ssw.fcd.esys.com (8.9.0/8.9.0) with ESMTP id MAA16265;
	Mon, 8 Nov 1999 12:59:42 -0500 (EST)
Message-ID: <38270F9F.BA484C3C@fallschurch.esys.com>
Date:   Mon, 08 Nov 1999 12:59:59 -0500
From:   "Frank B. Pound" <fpound@fallschurch.esys.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To:     Jeff Harrell <jharrell@ti.com>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: SGI, MIPS, Hardhat Linux question...
References: <19991102.21303700@jharrell_dt.>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I got the same message when trying to compile the ftape driver on an x86
box.  
It's been a long time since I tried it but I do distinctly remember
tracing it to
what you were talking about.
 
"It seems to have problems with the #include <asm/current.h>." 
I'm not sure if your problem is related to mine but could be.

It happened after a kernel upgrade, using RH.


Frank 


-- 
_______________________________________________________________
Frank B. Pound                    Phone: 703-560-5000 ext. 4008 
Raytheon Systems Company Strategic Systems Division
E-mail: fpound@fallschurch.esys.com
Web: http://www.raytheon.com/rsc/c3/c300.htm
_______________________________________________________________
