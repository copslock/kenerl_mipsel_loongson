Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 23:02:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60599 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032846AbXKOXCV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 23:02:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAFN2Kmm003236;
	Thu, 15 Nov 2007 23:02:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAFN2J89003235;
	Thu, 15 Nov 2007 23:02:19 GMT
Date:	Thu, 15 Nov 2007 23:02:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: "exportfs -a" -> stale NFS filehandle
Message-ID: <20071115230218.GA1696@linux-mips.org>
References: <20071115194548.GA30481@linux-mips.org> <DDFD17CC94A9BD49A82147DDF7D545C54DC8F6@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DC8F6@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 15, 2007 at 12:15:39PM -0800, Kaz Kylheku wrote:

> Ralf Baechle wrote:
> > On Thu, Nov 15, 2007 at 11:26:06AM -0800, Kaz Kylheku wrote:
> > 
> >> After backing out the nfsutils patch, the diskless node does boot.
> >> 
> >> However, the original "exportfs -a" problem comes back!
> >> 
> >> So this problem is not resolved simply by using the correct compat
> >> routine; it's deeper. 
> >> 
> >> Sigh.
> > 
> > Thanks for testing anyway!
> 
> I'm continuing to dig into the problem.
> 
> The export logic doesn't even go through nfsctl() anyway, which is why I
> originally hadn't even suspected that syscall.
> 
> The nfsexport() function in nfsutils first tries opening
> "/proc/net/rpc/nfsd.fh./channel". If that works, it uses that, via a
> text-based protocol. Only if that interface doesn't exist does it fall
> back on the nfsctl(NFSCTL_EXPORT, ...) interface.

After checking that latest glibc still isn't trying to compensate for the
N32 nfsservctl issue in userland I've applied the patch I sent you earlier.

  Ralf
