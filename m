Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 15:08:05 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51486 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023422AbZEROH5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 May 2009 15:07:57 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4IE7jxH018862;
	Mon, 18 May 2009 15:07:45 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4IE7jSJ018859;
	Mon, 18 May 2009 15:07:45 +0100
Date:	Mon, 18 May 2009 15:07:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	peter fuerst <post@pfrst.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] -mr10k-cache-barrier=store
Message-ID: <20090518140745.GB16847@linux-mips.org>
References: <Pine.LNX.4.58.0905172334550.1259@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0905172334550.1259@Indigo2.Peter>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 17, 2009 at 11:49:45PM +0200, peter fuerst wrote:

> Richard Sandiford's new code for inserting the cache-barriers, for GCC
> 4.3 and above and already incorporated in the current GCC-release, uses
> a slightly different option-syntax.
> (Accordingly i extended the patches for older GCC-releases to accept
> both styles)
> 
> 
> Signed-off-by: peter fuerst <post@pfrst.de>

Thanks, applied.  I also applied this to the -stable branches that have
IP28 support on them so I think support for the old syntax can fade
away soon.

  Ralf
