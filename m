Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2004 03:03:14 +0100 (BST)
Received: from p508B5F12.dip.t-dialin.net ([IPv6:::ffff:80.139.95.18]:31504
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225261AbUHFCDJ>; Fri, 6 Aug 2004 03:03:09 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i76235um028380;
	Fri, 6 Aug 2004 04:03:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i76235Dn028379;
	Fri, 6 Aug 2004 04:03:05 +0200
Date: Fri, 6 Aug 2004 04:03:04 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040806020304.GA27895@linux-mips.org>
References: <20040804152936.D6269@mvista.com> <411188A8.9040607@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411188A8.9040607@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 04, 2004 at 09:08:56PM -0400, Kumba wrote:

> >I am looking into porting NPTL to MIPS.  Just curious if
> >anybody has tried this before.
> >
> >I notice there was a discussion about the ABI extension
> >for TLS (thread local storage) support.  Before that support
> >becomes a reality it seems one can still use NPTL with 
> >the help of additional system calls.
> >
> >A rough search of latest glibc source shows there is
> >zero MIPS code for nptl.  A couple of other arches
> >are missing as well (such as ARM)
> >
> >Jun
> 
> All I've heard about this is that some kernel changes are (still?) 
> needed, then just the glibc support along w/ TLS (Maybe compiler support?).
> 
> I believe I heard reports that the glibc people were looking to 
> deprecate linuxthreads within a another release or two (but don't know 
> specifics or anything), so it sounds like NPTL should be something to 
> get working.

Threading support means breaking the ABI compatibility.  There are other
issues that can best be solved by breakin the ABI which is why this is
stretching out.

  Ralf
