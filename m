Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 04:09:27 +0000 (GMT)
Received: from p508B7B8E.dip.t-dialin.net ([IPv6:::ffff:80.139.123.142]:2061
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224769AbUCIEJY>; Tue, 9 Mar 2004 04:09:24 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2949Kex021207;
	Tue, 9 Mar 2004 05:09:20 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2949JsX021206;
	Tue, 9 Mar 2004 05:09:19 +0100
Date: Tue, 9 Mar 2004 05:09:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040309040919.GA11345@linux-mips.org>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D1909.1020005@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 08, 2004 at 08:08:25PM -0500, Kumba wrote:

> Hmm, well, The readelf -l and -S output from a 2.14.90.0.7-based 
> cross-compiler is attached, along with -l & -S outout from the 
> 2.15.90.0.1.1 (--version reports 2.15.90.0.1) as well for comparison.
> 
> The PAX_FLAGS bit comes from a patch added in gentoo for PaX support in 
> binaries.  More info on PaX is at http://pax.grsecurity.net.  I'm going 
> to rebuild my kernel cross-compiler without that one patch and see what 
> the results are.

PAX can't be fully supported on MIPS anyway; the architecture doesn't
have a no-exec flag in it's pages.

PAX docs are bullshit btw.  execution proection doesn't require a split TLB
and anyway, the MIPS uTLBs are split.

  Ralf
