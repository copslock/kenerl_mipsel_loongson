Received:  by oss.sgi.com id <S305160AbQANRMN>;
	Fri, 14 Jan 2000 09:12:13 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:41086 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQANRMA>;
	Fri, 14 Jan 2000 09:12:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA17511; Fri, 14 Jan 2000 09:09:06 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA87316
	for linux-list;
	Fri, 14 Jan 2000 09:04:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA41534
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 09:03:58 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03995
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 09:03:10 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id LAA19014;
	Fri, 14 Jan 2000 11:02:50 -0600
Date:   Fri, 14 Jan 2000 11:01:03 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Avi Bercovich <bercovic@swi.psy.uva.nl>
cc:     Linux SGI <linux@cthulhu.engr.sgi.com>,
        "Mark A. Zotolla" <markz@uab.edu>
Subject: Re: Status Indigo2 Beowulf project...
In-Reply-To: <Pine.GSO.4.05.10001131927540.2873-100000@swi>
Message-ID: <Pine.LNX.3.96.1000114105154.14128A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Thu, 13 Jan 2000, Avi Bercovich wrote:
> I was wondering what the status was of the effort to build a beowulf 
> cluster using Indigo2's. 

The cluster, named pixel (after a negative attitude towards the original
name), has been up and running for a while now, however we have not
built a web page for it.  Some benchmarks have been run against it, not
by me so I do not know the results.  It is currently configured with eight
nodes.  Currently I am working on finishing up the floating point
exception handling for the kernel so we can run more benchmarks.  I am
looking at the end of the month for that to be complete.  The cluster will
then be put into more of a production enviroment, being used primarily for
research and education.  We are then planning on putting together a four
node cluster to do more benchmarking and testing.  I want to get the 64bit
kernel working on that cluster to see what performance gains it can
achieve.  I also want to use the small cluster to look into kernel based
cluster performance enhancements.  I should also mention that we have
tested pvm, MPI, and DIPC on the cluster, but I do not have any statistics
to quote.

-Andrew
