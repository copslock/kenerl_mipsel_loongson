Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2011 20:02:55 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:50184 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491089Ab1FPSCv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2011 20:02:51 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C223B14194; Thu, 16 Jun 2011 20:02:50 +0200 (CEST)
Date:   Thu, 16 Jun 2011 20:02:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API
        not exists for MIPS
Message-ID: <20110616180250.GA13025@lst.de>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com> <20110325172709.GC8483@linux-mips.org> <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-archive-position: 30426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13775

On Wed, Jun 15, 2011 at 11:58:24AM +0530, naveen yadav wrote:
> Dear Ralf Baechle,
> 
> I have made one patch for below API's for 2.6.35.9 kernel. Pls provide
> me your feedback about this .

Ralf,

I'll second that request.  We'll really need this, right now embedded XFS
users are hacking around it in horrible ways.
