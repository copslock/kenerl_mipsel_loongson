Received:  by oss.sgi.com id <S42258AbQG0XNU>;
	Thu, 27 Jul 2000 16:13:20 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:3432 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42222AbQG0XNE>; Thu, 27 Jul 2000 16:13:04 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA02791
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 16:19:00 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA36180
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jul 2000 16:12:47 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from rotor.chem.unr.edu (rotor.chem.unr.edu [134.197.32.176]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00982
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jul 2000 16:12:30 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id QAA15919;
	Thu, 27 Jul 2000 16:12:17 -0700
Date:   Thu, 27 Jul 2000 16:12:17 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
Message-ID: <20000727161212.B12897@chem.unr.edu>
References: <3980C024.8DCCA084@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3980C024.8DCCA084@mvista.com>; from jsun@mvista.com on Thu, Jul 27, 2000 at 04:05:08PM -0700
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 27, 2000 at 04:05:08PM -0700, Jun Sun wrote:

> Has anybody been successful in trying to get strace running on
> Linux/MIPS?  I managed to get 4.2, with a little from CVS tree, compiled
> and run.  However, it does not quite right.  It only prints the first
> system. See below.  Verified that this is the same behavior on both
> 2.3.99-pre3 and 2.4.0-test2.

Your kernel is too old. Ralf fixed some things in ptrace a few days
ago. Also, I would be interested in hearing if you can get 4.2 to
work. I found that, even after adjusting several places for
__NR_Linux, it segfaulted. I do have 3.1 from oss.sgi.com CVS (with a
couple minor glibc 2.2 patches) working properly with a current
kernel.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
