Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 01:09:12 +0200 (CEST)
Received: from p508B6B85.dip.t-dialin.net ([80.139.107.133]:61059 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122962AbSIOXJL>; Mon, 16 Sep 2002 01:09:11 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8FN8vh27166;
	Mon, 16 Sep 2002 01:08:57 +0200
Date: Mon, 16 Sep 2002 01:08:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ryan Murray <rmurray@debian.org>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com
Subject: Re: [patch] userspace mcontext_t doesn't match what kernel returns
Message-ID: <20020916010857.B24588@linux-mips.org>
References: <20020911032832.GA1500@cyberhqz.com> <20020915210601.A24588@linux-mips.org> <20020915191613.GA21794@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020915191613.GA21794@nevyn.them.org>; from dan@debian.org on Sun, Sep 15, 2002 at 03:16:13PM -0400
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Sep 15, 2002 at 03:16:13PM -0400, Daniel Jacobowitz wrote:

> > I choose to fix the kernel instead which will keep as closer to the MIPS
> > ABI and also prevent having to recompile zillions of user apps.  Below my
> > working version of <asm/ucontext.h>.
> 
> What are the gregset_t/fpregset_t types in your working tree?  There
> aren't any definitions of them in the only copy of the MIPS code that I
> have here, and they've had various bad definitions in glibc until
> recently.  They also recently changed...

By the time I sent my previous mail I didn't yet have any.  Below the
changes I've made to libc but the kernel changes are identical.

> [Although I think your kernel change is the right way to go, here. 
> Just being cautious.]

I'm not yet finished.  The libc definitions for gregset_t and fpregset_t
are not what they're expected to be (coincidentally I got a related bug
report just a few days ago, so that issue is also itching a bit ...) and
I'd like to change them to as below.

This is a binary incompatible change but since so far just one person has
complained about the non-matching definitions of struct ucontext, it seems
there are very few users of the affected data type?

/* Type for general register.  */
typedef unsigned long int greg_t;

/* Number of general registers.  */
#define NGREG	36

typedef greg_t gregset_t[NGREG];

/* Container for all FPU registers.  */
typedef struct fpregset {
	union {
		double		fp_dregs[16];
		float		fp_fregs[32];
		unsigned int	fp_regs[32];
	} fp_r;
	unsigned int	fp_csr;
	unsigned int	fp_pad;
} fpregset_t;

/* Context to describe whole processor state.  */
typedef struct
  {
    gregset_t gregs;
    fpregset_t fpregs;
  } mcontext_t;

/* Userlevel context.  */
typedef struct ucontext
  {
    unsigned long int uc_flags;
    struct ucontext *uc_link;
    stack_t uc_stack;
    mcontext_t uc_mcontext;
    __sigset_t uc_sigmask;
  } ucontext_t;
