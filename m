Received:  by oss.sgi.com id <S554101AbRAZUCq>;
	Fri, 26 Jan 2001 12:02:46 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:11517 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S553779AbRAZUCa>;
	Fri, 26 Jan 2001 12:02:30 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id MAA09403;
	Fri, 26 Jan 2001 12:01:40 -0800
Date:   Fri, 26 Jan 2001 12:01:40 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Joe deBlaquiere <jadb@redhat.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010126120140.E9325@mvista.com>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com> <3A707FFB.60802@redhat.com> <20010125141952.C2311@bacchus.dhis.org> <3A70CA98.102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A70CA98.102@redhat.com>; from jadb@redhat.com on Thu, Jan 25, 2001 at 06:53:44PM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 25, 2001 at 06:53:44PM -0600, Joe deBlaquiere wrote:
> 
> The end goal of this is to make pthreads work on the Vr4181...it's 
> certainly an interesting task so far...
> 

We have got pthreads working on Vr4181 for a couple of months already.
What version of kernel are you using?  The toughest problem is not
MIPS_AUTOMIC_SET.  It is a kernel s0 register corruption bug, which is
already fixed in the current CVS tree.

Jun
