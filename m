Received:  by oss.sgi.com id <S305157AbQAMUnO>;
	Thu, 13 Jan 2000 12:43:14 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:13426 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAMUmx>;
	Thu, 13 Jan 2000 12:42:53 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00822; Thu, 13 Jan 2000 12:43:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA95249
	for linux-list;
	Thu, 13 Jan 2000 12:32:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA18453
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 13 Jan 2000 12:32:00 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po3.glue.umd.edu (po3.glue.umd.edu [128.8.10.123]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA04135
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 12:31:58 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po3.glue.umd.edu (8.9.3/8.9.3) with ESMTP id PAA03021;
	Thu, 13 Jan 2000 15:31:51 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id PAA09161;
	Thu, 13 Jan 2000 15:31:50 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id PAA09157;
	Thu, 13 Jan 2000 15:31:50 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Thu, 13 Jan 2000 15:31:50 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     eak@sgi.com
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: identifying sgi system type under Linux
In-Reply-To: <387E2510.43D52D70@detroit.sgi.com>
Message-ID: <Pine.GSO.4.21.0001131523370.8599-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


> I am asking around internally to see what if  any portions of kernel
> probe related code might be releaseable but the problem with even
> attempting that (from the few limited conversations I have had with
> kernel engineers) is that none of the IRIX hardware identification
> code is in one central place. It is really all over the place and
> dynamically builds this type of information in the hardware graph unde
> IRIX based on all of the hardware the kernel finds in the system.

OK, I've done a tiny bit of research on the web, and this is what would be
useful:

a way of finding the hardware IP as opposed to the software IP
    i.e., according to the SGI HARDWARE FAQ, while hinv reports
          both indy's and indigo2's as IP22, hardware wise
          the indy has an IP24 motherboard...

what ranges of serial numbers the various hardware have
    i.e., both of our indigo2's have serial numbers starting
          with 69:07, but that could be co-incidence because
          I am sure they were purchased at the same time.  
          ( the personal IRIS starts with E0:48 and the giant
          Crimson looks like A0:08 )

anyway I guess this isn't the most critical of problems, I was just
interested in having /proc/cpuinfo display it correctly [and thus, have
linux_logo show it correctly as well].

Thanks

Vince
