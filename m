Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2003 08:21:27 +0000 (GMT)
Received: from gandalf.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.69]:19653
	"EHLO gandalf.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225207AbTBLIV0>; Wed, 12 Feb 2003 08:21:26 +0000
Received: from merry.physik.uni-konstanz.de (merry.physik.uni-konstanz.de [134.34.144.91])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id 865FC90; Wed, 12 Feb 2003 09:21:22 +0100 (CET)
Received: from agx by merry.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 18is8w-0007e5-00; Wed, 12 Feb 2003 09:21:22 +0100
Date: Wed, 12 Feb 2003 09:21:22 +0100
From: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Florian Lohoff <flo@rfc822.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030212082122.GA29200@merry>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com> <20030211224622.GC1186@paradigm.rfc822.org> <20030212050341.GI8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212050341.GI8408@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Return-Path: <agx@mittelerde.physik.uni-konstanz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@gandalf.physik.uni-konstanz.de
Precedence: bulk
X-list: linux-mips

On Wed, Feb 12, 2003 at 04:03:41PM +1100, Andrew Clausen wrote:
> Also, running nm gives libc calls that invoke syscalls galore.
> For example:
> 
> 	open64, close, ioctl, opendir, fprintf, getmntent, lseek64, time
But we don't use all of e2fslib! The functions needed to get the kernel
from an e2fs only use a very small subset of these and are contained in
arclib.
 -- Guido
