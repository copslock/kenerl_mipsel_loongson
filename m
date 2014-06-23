Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:19:30 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:49764 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859946AbaFWJT1mPHbB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:19:27 +0200
Received: from [188.251.61.174] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Wz0PL-0008CV-MV; Mon, 23 Jun 2014 09:19:23 +0000
Date:   Mon, 23 Jun 2014 10:19:22 +0100
From:   Luis Henriques <luis.henriques@canonical.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable <stable@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, 751417@bugs.debian.org,
        team@security.debian.org, Plamen Alexandrov <plamen@aomeda.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: Bug#751417: linux-image-3.2.0-4-5kc-malta: no SIGKILL after
 prctl(PR_SET_SECCOMP, 1, ...) on MIPS
Message-ID: <20140623091922.GC4214@hercules>
References: <20140612161903.32229.20589.reportbug@debian-mips."">
 <1402601767.31756.38.camel@deadeye.wl.decadent.org.uk>
 <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jun 12, 2014 at 09:21:41PM +0100, Ben Hutchings wrote:
> On Thu, 2014-06-12 at 20:36 +0100, Ben Hutchings wrote:
> > Control: tag -1 security upstream patch moreinfo
> > Control: severity -1 grave
> > Control: found -1 3.14.5-1
> 
> Aurelien Jarno pointed out this appears to be fixed upstream in 3.15:
> 
> commit 137f7df8cead00688524c82360930845396b8a21
> Author: Markos Chandras <markos.chandras@imgtec.com>
> Date:   Wed Jan 22 14:40:00 2014 +0000
> 
>     MIPS: asm: thread_info: Add _TIF_SECCOMP flag
> 
> It looks like this can be cherry-picked cleanly onto stable branches for
> 3.13 and 3.14.  For 3.11 and 3.12, it will need trivial adjustment.
> 
> For branches older than 3.11, this needs to be cherry-picked first:
> 
> commit e7f3b48af7be9f8007a224663a5b91340626fed5
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed May 29 01:02:18 2013 +0200
> 
>     MIPS: Cleanup flags in syscall flags handlers.
> 
> Ben.
>

Thank you, I'm queuing this for the 3.11 kernel.

Cheers,
--
Luís

> > On Thu, 2014-06-12 at 16:19 +0000, Plamen Alexandrov wrote:
> > > Package: src:linux
> > > Version: 3.2.51-1
> > > Severity: normal
> > > 
> > > Under MIPS the system call prctl(PR_SET_SECCOMP, 1, ...) does not behave as expected.
> > > According to the manual page, after calling it with 1 as a second argument, any consecutive system calls other than read(), write(), _exit() and sigreturn() should result in the delivery of SIGKILL. However, under MIPS any consecutive system call behaves as if prctl(PR_SET_SECCOMP, 1, ...) was never called.
> > > 
> > > Here is a simple example that can be used to reproduce the bug:
> > > 
> > > plamen@debian-mips:/tmp$ id
> > > uid=1000(plamen) gid=1000(user) groups=1000(user)
> > > plamen@debian-mips:/tmp$ cat prctl.c 
> > > #include <unistd.h>
> > > #include <sys/prctl.h>
> > > #include <stdio.h>
> > > 
> > > int main(void)
> > > {
> > > 	if (prctl(PR_SET_SECCOMP, 1, 0, 0, 0) != 0)
> > > 		return 0;
> > > 	uid_t uid = getuid();
> > > 	printf("%u\n", (unsigned)uid);
> > > 	return 0;
> > > }
> > > plamen@debian-mips:/tmp$ gcc prctl.c -o prctl
> > > plamen@debian-mips:/tmp$ ./prctl 
> > > 1000
> > > 
> > > There is no change if I replace
> > > 	if (prctl(PR_SET_SECCOMP, 1, 0, 0, 0) != 0)
> > > with
> > > 	if (prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, 0, 0, 0) != 0)
> > > and I add #include <linux/seccomp.h>
> > 
> > Indeed, I see no check for seccomp on the MIPS syscall 'fast path'.  The
> > seccomp check appears to be done on the 'slow path' which is used only
> > if tracing or audit is also enabled for the task.  If I run the above
> > program under strace, it is killed as expected.
> > 
> > Could you test whether the attached patches fix this?  (Instructions for
> > rebuilding the Debian kernel package with patches can be found at
> > <http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-official>.  These patches apply to 'wheezy'.)
> > 
> > Ben.
> > 
> 
> -- 
> Ben Hutchings
> The program is absolutely right; therefore, the computer must be wrong.
