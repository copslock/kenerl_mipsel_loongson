Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f871LGU31992
	for linux-mips-outgoing; Thu, 6 Sep 2001 18:21:16 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f871LBd31989;
	Thu, 6 Sep 2001 18:21:11 -0700
Received: from fury.csh.rit.edu (fury.csh.rit.edu [129.21.60.5])
	by mcp.csh.rit.edu (Postfix) with ESMTP
	id B7194165; Thu,  6 Sep 2001 20:56:22 -0400 (EDT)
Date: Thu, 6 Sep 2001 20:56:22 -0400 (EDT)
From: George Gensure <werkt@csh.rit.edu>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: oops after rtc
In-Reply-To: <20010907024645.A15857@dea.linux-mips.net>
Message-ID: <Pine.SOL.4.31.0109062054550.12489-100000@fury.csh.rit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

sorry, latest cvs off of oss + fast_sysmips + entry.S patches (entry.S is
supposed to fix some build segfaults)  indy r5000, and I haven't decoded
the oops message yet... (currently away from machine)

George

On Fri, 7 Sep 2001, Ralf Baechle wrote:

> On Thu, Sep 06, 2001 at 08:15:24PM -0400, George Gensure wrote:
>
> > what could be causing a kernel oops after trying to initialize the sgi rtc
> > (may have nothing to do with the rtc, but the message comes right after
> > it).  The rtc is rather important to me (!rtc + Kerberos = bad).
>
> Kernel version?
> Decoded oops message?
> Machine type?
>
>   Ralf
>

-- 
George R. Gensure       Computer Science House Member
werkt@csh.rit.edu       Sophomore, Rochester Institute of Technology
Computer Science Major
