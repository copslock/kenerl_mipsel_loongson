Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 12:23:01 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54701 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20022095AbYFELW6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2008 12:22:58 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 1ED78C803F;
	Thu,  5 Jun 2008 14:22:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id ejIQC5ZGtISp; Thu,  5 Jun 2008 14:22:57 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 012E4C801D;
	Thu,  5 Jun 2008 14:22:57 +0300 (EEST)
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	Theodore Tso <tytso@mit.edu>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
In-Reply-To: <20080605111148.GA4483@deprecation.cyrius.com>
References: <20080512130604.GA15008@deprecation.cyrius.com>
	 <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
	 <20080512143426.GB7029@mit.edu>
	 <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com>
	 <20080513045028.GC22226@linux-mips.org>
	 <20080528070637.GA10393@deprecation.cyrius.com>
	 <20080605111148.GA4483@deprecation.cyrius.com>
Content-Type: text/plain
Organization: Movial Creative Technologies
Date:	Thu, 05 Jun 2008 14:22:57 +0300
Message-Id: <1212664977.4840.6.camel@sd048.hel.movial.fi>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

On Thu, 2008-06-05 at 13:11 +0200, Martin Michlmayr wrote:
> * Martin Michlmayr <tbm@cyrius.com> [2008-05-28 09:06]:
> > * Ralf Baechle <ralf@linux-mips.org> [2008-05-13 05:50]:
> > > I prefer to do it myself so I can apply it at the same time to the MIPS
> > > -stable branches.
> > > 
> > > I'm a little irriated that this thread seems to be only about
> > > empty_zero_page but apparently not zero_page_mask?  empty_zero_page is
> > > actualy an array of pages on MIPS and ZERO_PAGE() will pick the right one
> > > for a particular user space mapping based on the virtual address but
> > > ZERO_PAGE() also references zero_page_mask.  So I sense more brokenness
> > > here.
> > 
> > Just as a reminder, this issue is still there (at least with rc4).
> 
> Still present in rc5.

It looks like the discussion related to this issue has faded out. Ralf
seemed to have some objections to using ZERO_PAGE() outside of the
context of getting a user-mapped page, but I think that ext4 driver is
still doing that.

Ralf, will it be possible to use the patch I sent earlier as a temporary
solution? Just to make sure the kernel builds?

Thanks,
Dmitri
> 
