Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IL5ET26698
	for linux-mips-outgoing; Mon, 18 Jun 2001 14:05:14 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IL5DV26694
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 14:05:13 -0700
Received: from [171.69.113.18] (earth.ayrnetworks.com [10.1.1.24])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f5IL3s312384;
	Mon, 18 Jun 2001 14:03:54 -0700
User-Agent: Microsoft-Entourage/9.0.2509
Date: Mon, 18 Jun 2001 15:05:18 -0600
Subject: Re: Profiling support in glibc?
From: Greg Satz <satz@ayrnetworks.com>
To: Brian Murphy <brian@murphy.dk>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Message-ID: <B753C92D.5ABA%satz@ayrnetworks.com>
In-Reply-To: <3B2E5163.D130FA01@murphy.dk>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I was able to get profiling working using glibc-2.2.2 and gcc-2.95.3. Both
packages needed changes. The compiler had a stack misalignment correction
for glibc. Glibc didn't save all the registers nor treat sp/fp correctly.
Currently files compiled with -pg need to be linked -static. Specs need to
be updated to do this automatically.

I will send diffs if there is any interest.

Thanks,
Greg

on 6/18/01 1:07 PM, Brian Murphy at brian@murphy.dk wrote:

> 
> What is the status of profiling in glibc? Our (egcs-1.1.2 based)
> compiler fails with a missing symbol
> _start (glibc 2.0.6) but even if one fixes this up there are more
> fundamental problems.
> 
> Is there a later glibc for which profiling works?
> 
> /Brian
> 
