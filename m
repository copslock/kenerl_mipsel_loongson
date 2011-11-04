Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 10:32:28 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41137 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904080Ab1KDJcZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 10:32:25 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA49WOqB001916;
        Fri, 4 Nov 2011 09:32:24 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA49WMbJ001910;
        Fri, 4 Nov 2011 09:32:22 GMT
Date:   Fri, 4 Nov 2011 09:32:22 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Bonn <jonas@southpole.se>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 4/8] mips: implement syscall restart generically
Message-ID: <20111104093222.GA1633@linux-mips.org>
References: <cover.1319364492.git.jonas@southpole.se>
 <04ce50ed7e9e9a949a3c0b447c3aec0a8c6face4.1319364492.git.jonas@southpole.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ce50ed7e9e9a949a3c0b447c3aec0a8c6face4.1319364492.git.jonas@southpole.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3424

On Sun, Oct 23, 2011 at 12:19:58PM +0200, Jonas Bonn wrote:

> Manipulating task state to effect re-execution of an interrupted syscall
> used to be purely architecture specific code.  However, as most arch's
> were essentially just making minor adjustments to almost identical logic,
> this code could be moved to a common implementation.
> 
> The generic variant introduces the function handle_syscall_restart() to be
> called after get_signal_to_deliver().  The architecture specific register
> manipulations required to effect the actual restart are now implemented
> in the generic syscall interface found in asm/syscall.h
> 
> This patch transitions this architecture's signal handling code over to
> using the generic syscall restart code by:
> 
> i)  Implementing the register manipulations in asm/syscall.h
> ii) Replacing the restart logic with a call to handle_syscall_restart

Nice cleanup.

Any reason why you add empty version of syscall_get_arguments and
syscall_set_version?  A non-functional version that causes a silent
failure is way worse than something that fails at compile time.

  Ralf
