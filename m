Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 15:58:51 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:60932 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20031146AbYELO6r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 15:58:47 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D644ED8E3; Mon, 12 May 2008 14:58:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 70BD6372609; Mon, 12 May 2008 16:58:36 +0200 (CEST)
Date:	Mon, 12 May 2008 16:58:36 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Theodore Tso <tytso@mit.edu>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080512145836.GE15866@deprecation.cyrius.com>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080512143426.GB7029@mit.edu>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Theodore Tso <tytso@mit.edu> [2008-05-12 10:34]:
> What is the Linux-mips' team preference for feeding this patch to
> Linus?  This technically isn't a regression, since it was broken in
> 2.6.25, but it would be nice to get this to Linus sooner rather than

Actually, it built just fine with 2.6.25.

-- 
Martin Michlmayr
http://www.cyrius.com/
