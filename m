Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:45:22 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:39947 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465569AbVI3Kmf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLuk005536;
	Fri, 30 Sep 2005 11:42:27 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8U0Dnq7004716;
	Fri, 30 Sep 2005 01:13:49 +0100
Date:	Fri, 30 Sep 2005 01:13:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Revise MIPS64 ptrace interface
Message-ID: <20050930001349.GF3983@linux-mips.org>
References: <20050922182601.GA10829@nevyn.them.org> <20050928221115.GA22817@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928221115.GA22817@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 28, 2005 at 06:11:15PM -0400, Daniel Jacobowitz wrote:

> Change the N32 debugging ABI to something more sane, and add support
> for o32 and n32 debuggers to trace n64 programs.
> 
> Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>
> ---
> 
> I've now tested everything except the actual _3264 operations, which
> were copied from PPC anyway and I have reasonable faith in.  So here's
> a final patch.  If this seems reasonable to everyone, I'd like for it
> to be merged, and then I can submit the glibc and gdb bits.

I haven't heared any objections and I guess for an interface like ptrace
such a somewhat trigger happy change is still ok, so I've applied your
patch.

  Ralf
