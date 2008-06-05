Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 12:12:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41888 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20022077AbYFELMF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 12:12:05 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 55396D8DD; Thu,  5 Jun 2008 11:12:03 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1B785150F70; Thu,  5 Jun 2008 13:11:49 +0200 (CEST)
Date:	Thu, 5 Jun 2008 13:11:48 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	Theodore Tso <tytso@mit.edu>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080605111148.GA4483@deprecation.cyrius.com>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org> <20080528070637.GA10393@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080528070637.GA10393@deprecation.cyrius.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2008-05-28 09:06]:
> * Ralf Baechle <ralf@linux-mips.org> [2008-05-13 05:50]:
> > I prefer to do it myself so I can apply it at the same time to the MIPS
> > -stable branches.
> > 
> > I'm a little irriated that this thread seems to be only about
> > empty_zero_page but apparently not zero_page_mask?  empty_zero_page is
> > actualy an array of pages on MIPS and ZERO_PAGE() will pick the right one
> > for a particular user space mapping based on the virtual address but
> > ZERO_PAGE() also references zero_page_mask.  So I sense more brokenness
> > here.
> 
> Just as a reminder, this issue is still there (at least with rc4).

Still present in rc5.

-- 
Martin Michlmayr
http://www.cyrius.com/
