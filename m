Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2003 10:55:09 +0000 (GMT)
Received: from gandalf.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.69]:41913
	"EHLO gandalf.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225194AbTBKKzJ>; Tue, 11 Feb 2003 10:55:09 +0000
Received: from merry.physik.uni-konstanz.de (merry.physik.uni-konstanz.de [134.34.144.91])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id 9414A90; Tue, 11 Feb 2003 11:55:06 +0100 (CET)
Received: from agx by merry.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 18iY4A-0004fU-00; Tue, 11 Feb 2003 11:55:06 +0100
Date: Tue, 11 Feb 2003 11:55:06 +0100
From: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030211105506.GA17935@merry>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210223955.GF8408@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Return-Path: <agx@mittelerde.physik.uni-konstanz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@gandalf.physik.uni-konstanz.de
Precedence: bulk
X-list: linux-mips

On Tue, Feb 11, 2003 at 09:39:55AM +1100, Andrew Clausen wrote:
>  * e2fsprogs uses libc headers quite extensively, but there is no
> glibc available for mips64 (right?).  It also seems to make quite a
> few libc calls?  (How are you planning to deal with that?  Link
> against it statically?  What about syscalls?)
e2fsprogs doesn't call glibc (in fact in can't since we don't link
arcboot against non PIC glibc). It calls arclib.
 -- Guido
