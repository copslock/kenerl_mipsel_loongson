Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VC9qR14472
	for linux-mips-outgoing; Thu, 31 Jan 2002 04:09:52 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VC9gd14467
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 04:09:44 -0800
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0VB9Ua11347;
	Thu, 31 Jan 2002 11:09:30 GMT
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id LAA10279;
	Thu, 31 Jan 2002 11:09:27 GMT
Date: Thu, 31 Jan 2002 11:09:27 GMT
Message-Id: <200201311109.LAA10279@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Matthew Dharm" <mdharm@momenco.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Re: Does Linux invalidate TLB entries?
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIGECBCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIGECBCFAA.mdharm@momenco.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Matthew Dharm (mdharm@momenco.com) writes:

> I see one here that I'm not sure if it's a problem or not.  It only
> applies to OSes which invalidate TLB entries and thus will cause TLB
> Invalid exceptions (as opposed to a TLB refill exception, I think).

Hmm.  I see that the triggering condition is related to the
instruction stream (you need an ITLB miss and an icache miss).

> So, does Linux invalidate TLBs?  I've been looking at the code, and I
> think the answer is 'no', but I'm not really sure.

RM7000 (like most MIPS CPUs) maps pages in pairs: one virtual address
tag (covering 8Kbyte of virtual address space) has mappings to two
4K physical pages.

Sure, quite a lot of the time both pages will be mapped: but unless
the Linux VM system does everything in pairs of pages (unlikely) it
will sometimes happen that you only have a mapping for one 4K page:
the other mapping will be invalid, and then this problem might happen.

When it does, the TLB refill handler will blindly load a second copy
of the same translation (still half-invalid, I guess).

PMC's statement that "Most operating systems do not invalidate TLB
entries, so, in those systems, this errata will not be seen..." seems
like wishful thinking.  Unless "most operating systems" don't do
virtual memory at all, of course.

If my argument is sound it leaves only the TLBP solution, which is
not very nice.

-- 
Dominic Sweetman, 
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
