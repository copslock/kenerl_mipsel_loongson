Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBV45h425557
	for linux-mips-outgoing; Sun, 30 Dec 2001 20:05:43 -0800
Received: from fencepost.gnu.org (we-refuse-to-spy-on-our-users@fencepost.gnu.org [199.232.76.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBV45Wg25550
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 20:05:32 -0800
Received: from buytenh by fencepost.gnu.org with local (Exim 3.22 #1 (Debian))
	id 16Ksl2-00032O-00; Sun, 30 Dec 2001 22:05:00 -0500
Date: Sun, 30 Dec 2001 22:05:00 -0500
From: Lennert Buytenhek <buytenh@gnu.org>
To: rth@dot.cygnus.com, linux-arm-kernel@lists.arm.linux.org.uk,
   dev-etrax@axis.com, linux-ia64@linuxia64.org,
   linux-m68k@lists.linux-m68k.org, linux-mips@oss.sgi.com,
   grundler@cup.hp.com, cort@fsmlabs.com, linux-390@vm.marist.edu,
   gniibe@mri.co.jp, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org
Cc: jdike@karaya.com
Subject: [PATCH][RFC][CFT] remove global errno from the kernel, make _syscallX kernel-only
Message-ID: <20011230220500.A10224@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

(Apologies for the massive cross-post, but this is a matter that concerns
all architectures.  For archs that don't have a maintainer listed in
MAINTAINERS I grabbed a random email address from arch/$arch/kernel/*.
If you're not the person to answer this for your $arch, please forward
to an appropriate person/list.)


Hi,

As I mentioned in my email to l-k with subject '[PATCH][RFC] global
errno considered harmful' earlier today, having a global errno in the
kernel doesn't really make sense.

Referenced patch [1] deletes all mention of a global errno from the
kernel, fixes up a very small number of callers that were depending on
it, and fixes up the syscall helpers in include/asm-$arch/unistd.h not
to write an error code to errno in case of error anymore.

This subtly breaks userspace code that uses these helpers, but the general
consensus seems to be that userspace code shouldn't be touching these in
the first place.  Patch [2] fixes up asm-$arch/unistd.h to only define
_syscallX in case __KERNEL_SYSCALLS__ is defined, to try and actively
break userspace (ab)users of this code (thanks to Ralf Baechle for
suggesting I should do something along these lines).

What I would like to know from each architecture team:
- What is your arch's policy on userspace usage of asm/unistd.h, and
  consequently, what is your opinion on the goal these patches
  aim for?
- Are the changes I made in [1] and [2] for your $arch technically
  correct?
Please CC me on replies as I'm not on any of the lists posted to.

My intention is to push these to Linus for 2.5 if everyone agrees.
They're probably too intrusive for 2.4 (although I'd love people
to convince me otherwise).


cheers,
Lennert

[1] http://www.math.leidenuniv.nl/~buytenh/errno_ectomy-1.diff
[2] http://www.math.leidenuniv.nl/~buytenh/errno_ectomy-1-to-2.diff
