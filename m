Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 20:47:40 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:18954 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20032633AbXJXTrc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Oct 2007 20:47:32 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6C1CCD8E1; Wed, 24 Oct 2007 19:46:50 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5D236543EA; Wed, 24 Oct 2007 21:46:36 +0200 (CEST)
Date:	Wed, 24 Oct 2007 21:46:36 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
Message-ID: <20071024194636.GA672@deprecation.cyrius.com>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org> <470FBE08.8090004@avtrex.com> <20071012184909.GA4832@linux-mips.org> <20071012191446.GK3163@deprecation.cyrius.com> <20071012191645.GB4832@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071012191645.GB4832@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2007-10-12 20:16]:
> > Okay, I can see it.  I'll submit a testcase.
> Thanks :-)

Note that Richard fixed the bug in SVN today, so it will be in the next
release of gcc 4.2.
-- 
Martin Michlmayr
http://www.cyrius.com/
