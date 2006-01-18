Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 12:50:07 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:10514 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133603AbWARMth (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 12:49:37 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 1BA4564D54; Wed, 18 Jan 2006 12:52:31 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 09ABE8456; Wed, 18 Jan 2006 12:52:03 +0000 (GMT)
Date:	Wed, 18 Jan 2006 12:52:03 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	MIPS Linux List <linux-mips@linux-mips.org>
Cc:	Stuart Anderson <anderson@netsweng.com>
Subject: Re: linux kernel building for mips malta target board
Message-ID: <20060118125203.GA21997@deprecation.cyrius.com>
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com> <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com> <436965B7.3000606@avtrex.com> <Pine.LNX.4.61.0511022057140.3511@trantor.stuart.netsweng.com> <20051103163306.GC3149@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103163306.GC3149@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2005-11-03 16:33]:
> > There was a comment on IRC that there was a register allocation issue which
> > lead to the current code. I'm not sure of the exact details, but I _think_
> > this change ends up being equivilent to the code it replaces.
> 
> It's correct - but triggers plenty of extra warnings and you forgot about
> get_user() which has the same kind of issue.  Also you don't have the
> guarantee that <linux/types.h> has been included, so in order to avoid a
> yet another header file dependency I changed s8, s16 etc. to char, short,
> int, long long.  Working on it but as usual uaccess.h is quite a quiz.

What's the status of this?

With current linux-mips git I still get the problem.  As a reminder,
the error is:

  CC      fs/compat_ioctl.o
fs/compat_ioctl.c: In function 'fd_ioctl_trans':
fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
make[1]: *** [fs/compat_ioctl.o] Error 1

-- 
Martin Michlmayr
http://www.cyrius.com/
