Received:  by oss.sgi.com id <S554109AbRAZVER>;
	Fri, 26 Jan 2001 13:04:17 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:28398 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S554106AbRAZVDs>;
	Fri, 26 Jan 2001 13:03:48 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id NAA09462;
	Fri, 26 Jan 2001 13:02:57 -0800
Date:   Fri, 26 Jan 2001 13:02:57 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Joe deBlaquiere <jadb@redhat.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010126130257.I9325@mvista.com>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com> <3A707FFB.60802@redhat.com> <20010125141952.C2311@bacchus.dhis.org> <3A70CA98.102@redhat.com> <20010126120140.E9325@mvista.com> <3A71E037.6030300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A71E037.6030300@redhat.com>; from jadb@redhat.com on Fri, Jan 26, 2001 at 02:38:15PM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 02:38:15PM -0600, Joe deBlaquiere wrote:
> 
> Jun Sun wrote:
> 
> > On Thu, Jan 25, 2001 at 06:53:44PM -0600, Joe deBlaquiere wrote:
> > 
> >> The end goal of this is to make pthreads work on the Vr4181...it's 
> >> certainly an interesting task so far...
> >> 
> > 
> > 
> > We have got pthreads working on Vr4181 for a couple of months already.
> > What version of kernel are you using?  The toughest problem is not
> > MIPS_AUTOMIC_SET.  It is a kernel s0 register corruption bug, which is
> > already fixed in the current CVS tree.
> > 
> 
> which current CVS tree, the linuxvr tree?
> 

What do you think "CVS tree" is on an oss.sgi.com mailing list? :-0

> what is the s0 register corruption bug?
> 

Check back with the mailing list archive.  There was a thread about this.  
Basically, the s0 register can be corrupted during a few syscalls.  
pthread_create() uses one of the syscalls and thus fails even though the 
new thread is actually created.

Jun
