Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0J1ZDk16320
	for linux-mips-outgoing; Fri, 18 Jan 2002 17:35:13 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0J1Z9P16316
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 17:35:09 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA22468;
	Fri, 18 Jan 2002 16:34:58 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA08107;
	Fri, 18 Jan 2002 16:34:55 -0800 (PST)
Message-ID: <01b801c1a081$3f6518e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "H . J . Lu" <hjl@lucon.org>, "Ulrich Drepper" <drepper@redhat.com>
Cc: "GNU libc hacker" <libc-hacker@sources.redhat.com>,
   <linux-mips@oss.sgi.com>
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org>
Subject: Re: thread-ready ABIs
Date: Sat, 19 Jan 2002 01:35:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Thu, Jan 17, 2002 at 04:07:23PM -0800, Ulrich Drepper wrote:
> > The time is near when we (well, I) well start a drastic move toward
> > generally using thread registers.  Even in non-threaded code.
> > 
> > This means that unless all architectures get thread registers (or
> > equivalent things like Alpha's special code) we'll have a two class
> > society of platforms where all code written for the platforms without
> > thread register can be run on the other systems, but not vice versa.

[snip]

> > MIPS: Who feels responsible?  Andreas, HJ?
> 
> I don't see there are any registers we can use without breaking ABI.
> On the other hand, can we change the mips kernel to save k0 or k1 for
> user space?

Thank you for posting this to linux-mips, since I'm not sure 
that anyone at MIPS is on the GNU_libc_hacker list.

It would, in principle, be possible to save/restore k0
or k1 (but not both) if no other clever solution can be found.  
There are other VM OSes that manage to do so for MIPS, 
for other outside-the-old-ABI reasons.  It does, of course,
add some instructions and some memory traffic to the 
low-level exception handling , and we would have to look 
at whether we would want to make such a feature standard 
or specific to a "thread-ready" kernel build.

            Regards,

            Kevin K.
