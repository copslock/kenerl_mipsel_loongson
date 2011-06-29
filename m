Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2011 15:58:38 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58347 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491130Ab1F2N63 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jun 2011 15:58:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6A8248EE094;
        Wed, 29 Jun 2011 06:58:22 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a06N68LPxn9h; Wed, 29 Jun 2011 06:58:22 -0700 (PDT)
Received: from [192.168.2.107] (dagonet.hansenpartnership.com [76.243.235.53])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 976948EE065;
        Wed, 29 Jun 2011 06:58:20 -0700 (PDT)
Subject: Re: [PATCH 00/12] Fix various section mismatches and build errors.
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Miller <davem@davemloft.net>, akpm@linux-foundation.org,
        alan@linux.intel.com, bcasavan@sgi.com, airlied@linux.ie,
        grundler@parisc-linux.org, perex@perex.cz, rpurdie@rpsys.net,
        klassert@mathematik.tu-chemnitz.de, tj@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20110629130711.GA15649@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
         <20110627.221257.1290251511587162468.davem@davemloft.net>
         <20110629130711.GA15649@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 29 Jun 2011 08:58:19 -0500
Message-ID: <1309355899.2551.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
X-archive-position: 30539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23870

On Wed, 2011-06-29 at 14:07 +0100, Ralf Baechle wrote:
> On Mon, Jun 27, 2011 at 10:12:57PM -0700, David Miller wrote:
> 
> > commit 948252cb9e01d65a89ecadf67be5018351eee15e
> > Author: David S. Miller <davem@davemloft.net>
> > Date:   Tue May 31 19:27:48 2011 -0700
> > 
> >     Revert "net: fix section mismatches"
> >     
> >     This reverts commit e5cb966c0838e4da43a3b0751bdcac7fe719f7b4.
> >     
> >     It causes new build regressions with gcc-4.2 which is
> >     pretty common on non-x86 platforms.
> >     
> >     Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > 
> > and postings that led to this revert including:
> > 
> > http://marc.info/?l=linux-netdev&m=130653748205263&w=2
> 
> Thanks for the pointers; I looked into it a bit deeper and found that the
> construct which hppa64-linux-gcc 4.2.4 doesn't like is the combination of
> const and __devinitconst __devinitdata.
> 
> My patches are minimalistic and don't do any constification and seem to
> work fine for PA-RISC.
> 
> A possible alternative to allow the use of Michał's reverted patch would
> be to conditionalize the definition of __devinitconst.  There is no
> user of __devexitconst so I left that unchanged.

To be honest, my own take on this is that, apart from the compiler
cockups trying to do read only annotations, which affect various
versions of gcc not just the parisc ones, the _devX annotations are
pretty pointless.  They only really do something in the non-hotplug
case, so since 95% of the world seems to use hotplug now and the other
5% doesn't care that much about the odd page of memory (which you rarely
get, since modules sections are accumulated per module, not aggregate),
I'd just favour stripping __init and __exit where there's a problem.

I think we should simply concentrate on __init and __exit; that's where
most of the discard value lies and stop expending huge efforts on the
__devX stuff which adds huge complexity for no real gain.

James
