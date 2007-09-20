Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 07:17:17 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:35857 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20024550AbXITGRI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 07:17:08 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 42231D8DA; Thu, 20 Sep 2007 06:16:32 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9AF10540C0; Thu, 20 Sep 2007 08:16:11 +0200 (CEST)
Date:	Thu, 20 Sep 2007 08:16:11 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve diagnostics
Message-ID: <20070920061611.GE23757@deprecation.cyrius.com>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl> <20070919172412.725508d0.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070919172412.725508d0.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Andrew Morton <akpm@linux-foundation.org> [2007-09-19 17:24]:
> I made that change, but am too stupid to be able to work out how to create
> a config which will let me compile this thing.
> 
> akpm:/usr/src/25> grep PMAG arch/arm/configs/*
> akpm:/usr/src/25> 

It's a driver for mips.
-- 
Martin Michlmayr
http://www.cyrius.com/
