Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 01:58:08 +0000 (GMT)
Received: from pD95629F8.dip.t-dialin.net ([IPv6:::ffff:217.86.41.248]:47892
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224917AbUKKB6E>; Thu, 11 Nov 2004 01:58:04 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAB1u3MK030275;
	Thu, 11 Nov 2004 02:56:03 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAB1u0oT030274;
	Thu, 11 Nov 2004 02:56:00 +0100
Date: Thu, 11 Nov 2004 02:56:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, libc-alpha@sources.redhat.com,
	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
Message-ID: <20041111015600.GA30150@linux-mips.org>
References: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com> <20041110180050.GK7235@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.61.0411101807550.11408@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411101807550.11408@perivale.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 10, 2004 at 06:19:14PM +0000, Maciej W. Rozycki wrote:

> > > http://www.linux-mips.org/cvsweb/linux/include/asm-mips/siginfo.h.diff?r1=1.4&r2=1.5&only_with_tag=MAIN
> > > 
> > > dated back to Aug 1999 (!), the definitions of struct siginfo in Linux and 
> > > GNU libc differ to each other.
> > 
> > Only 2.4 Kernels, 2.6 uses the normal definition again.
> 
>  Ah, it's been changed again for 2.6.9-rc3 without a word of a comment, 
> grrr...

Yoichi Yuasa sent this patch upstream without notifying anybody.
GRRRR also.

  Ralf
