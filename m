Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2011 18:19:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52843 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491136Ab1F2QTr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Jun 2011 18:19:47 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5TGJPVi007815;
        Wed, 29 Jun 2011 17:19:26 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5TGJLc2007799;
        Wed, 29 Jun 2011 17:19:21 +0100
Date:   Wed, 29 Jun 2011 17:19:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg KH <greg@kroah.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Miller <davem@davemloft.net>, akpm@linux-foundation.org,
        alan@linux.intel.com, bcasavan@sgi.com, airlied@linux.ie,
        grundler@parisc-linux.org, perex@perex.cz, rpurdie@rpsys.net,
        klassert@mathematik.tu-chemnitz.de, tj@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various section mismatches and build errors.
Message-ID: <20110629161921.GA25833@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
 <20110627.221257.1290251511587162468.davem@davemloft.net>
 <20110629130711.GA15649@linux-mips.org>
 <1309355899.2551.4.camel@mulgrave>
 <20110629151424.GD18023@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110629151424.GD18023@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24058

On Wed, Jun 29, 2011 at 08:14:24AM -0700, Greg KH wrote:

> 
> On Wed, Jun 29, 2011 at 08:58:19AM -0500, James Bottomley wrote:
> > I think we should simply concentrate on __init and __exit; that's where
> > most of the discard value lies and stop expending huge efforts on the
> > __devX stuff which adds huge complexity for no real gain.
> 
> I have long felt that those __devX markings should just go away as they
> cause nothing but problems and have no real gain as you point out.

The suggestion to do that has been floated around before but seems to
have missed sufficient thrust.  I'm all for it; the manual tagging with
__devX has not been very efficient on developer time.  I just want to see
meaningful warnings again over all that noise the current mechanisn may
produce.

  Ralf
