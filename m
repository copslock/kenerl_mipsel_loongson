Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 08:08:00 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:22544 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S20024183AbYE1HH5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 08:07:57 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0C1DDD8E1; Wed, 28 May 2008 07:07:55 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3473D150F7F; Wed, 28 May 2008 03:06:38 -0400 (EDT)
Date:	Wed, 28 May 2008 09:06:38 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	Theodore Tso <tytso@mit.edu>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080528070637.GA10393@deprecation.cyrius.com>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080513045028.GC22226@linux-mips.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2008-05-13 05:50]:
> I prefer to do it myself so I can apply it at the same time to the MIPS
> -stable branches.
> 
> I'm a little irriated that this thread seems to be only about
> empty_zero_page but apparently not zero_page_mask?  empty_zero_page is
> actualy an array of pages on MIPS and ZERO_PAGE() will pick the right one
> for a particular user space mapping based on the virtual address but
> ZERO_PAGE() also references zero_page_mask.  So I sense more brokenness
> here.

Just as a reminder, this issue is still there (at least with rc4).
-- 
Martin Michlmayr
http://www.cyrius.com/
