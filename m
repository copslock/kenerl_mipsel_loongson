Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2008 11:18:25 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:21146 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28774040AbYEEKSW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 May 2008 11:18:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m45AIAKV024516;
	Mon, 5 May 2008 11:18:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m45AI98a024509;
	Mon, 5 May 2008 11:18:09 +0100
Date:	Mon, 5 May 2008 11:18:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	DM <dm.n9107@gmail.com>
Cc:	Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	sparclinux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v2] unify sys_pipe implementation
Message-ID: <20080505101809.GA14547@linux-mips.org>
References: <200805031801.m43I109q032242@devserv.devel.redhat.com> <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 05, 2008 at 10:30:09AM +0200, DM wrote:

> >  + * sys_pipe() is the normal C calling standard for creating
> >  + * a pipe. It's not the way Unix traditionally does this, though.
> >  + */
> >  +asmlinkage long sys_pipe(int __user *fildes)
> >  +{
> >  +       int fd[2];
> >  +       int error;
> >  +
> >  +       error = do_pipe(fd);
> >  +       if (!error) {
> >  +               if (copy_to_user(fildes, fd, sizeof(fd)))
> >  +                       error = -EFAULT;
> >  +       }
> >  +       return error;
> >  +}
> >  +
> [...]
> 
> I realize this code is old, but wouldn't file descriptors leak if
> copy_to_user fails?

The MIPS implementation doesn't have this problem; it returns the
file descriptors in the result registers $v0 and $v1.

But an interesting catch after so many years!

  Ralf
