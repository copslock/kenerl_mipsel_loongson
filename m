Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 13:04:33 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:6431 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133598AbWARNEQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 13:04:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0ID5x0k023431;
	Wed, 18 Jan 2006 13:06:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0ID5xIj023424;
	Wed, 18 Jan 2006 13:05:59 GMT
Date:	Wed, 18 Jan 2006 13:05:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>,
	Stuart Anderson <anderson@netsweng.com>
Subject: Re: linux kernel building for mips malta target board
Message-ID: <20060118130559.GB3555@linux-mips.org>
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com> <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com> <436965B7.3000606@avtrex.com> <Pine.LNX.4.61.0511022057140.3511@trantor.stuart.netsweng.com> <20051103163306.GC3149@linux-mips.org> <20060118125203.GA21997@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118125203.GA21997@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 18, 2006 at 12:52:03PM +0000, Martin Michlmayr wrote:

> * Ralf Baechle <ralf@linux-mips.org> [2005-11-03 16:33]:
> > > There was a comment on IRC that there was a register allocation issue which
> > > lead to the current code. I'm not sure of the exact details, but I _think_
> > > this change ends up being equivilent to the code it replaces.
> > 
> > It's correct - but triggers plenty of extra warnings and you forgot about
> > get_user() which has the same kind of issue.  Also you don't have the
> > guarantee that <linux/types.h> has been included, so in order to avoid a
> > yet another header file dependency I changed s8, s16 etc. to char, short,
> > int, long long.  Working on it but as usual uaccess.h is quite a quiz.
> 
> What's the status of this?
> 
> With current linux-mips git I still get the problem.  As a reminder,
> the error is:
> 
>   CC      fs/compat_ioctl.o
> fs/compat_ioctl.c: In function 'fd_ioctl_trans':
> fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
> fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
> fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
> fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
> make[1]: *** [fs/compat_ioctl.o] Error 1

I have not been able to find some construct that keeps gcc happy and at the
same time doesn't result in significantly worse code.  That matters because
get_user / put_user are used very often throughout the kernel.

  Ralf
