Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 15:29:12 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:3088 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20023286AbXEPO3L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2007 15:29:11 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 730A2D8E1; Wed, 16 May 2007 14:29:04 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B2FC1543E0; Wed, 16 May 2007 16:28:49 +0200 (CEST)
Date:	Wed, 16 May 2007 16:28:49 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	guido.zeiger@mailprocessor.de, linux-mips@linux-mips.org
Subject: Re: Segmentation Fault from MP3-Player with Etch on Qube2
Message-ID: <20070516142849.GD19816@deprecation.cyrius.com>
References: <8FBE82E8-F399-426A-A263-E0EA85095A08@mailprocessor.de> <20070510.011348.25233649.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070510.011348.25233649.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2007-05-10 01:13]:
> There are know problems with PCI soundcard on noncoherent MIPS
> platform (including cobalt) and some patches are floating around.  For
> example:
> http://www.linux-mips.org/archives/linux-mips/2007-04/msg00072.html
> 
> This is a long standing issue and I wonder why your soundcard _did_
> work with debian sid.  The kernel of sid contains fixes for this
> issue?

I don't think it ever worked with 2.6, but it certainly worked with
2.4.  Is it much work to get 2.6 working again?  This problem comes up
from time to time, so it seems it's hitting a number of users.
-- 
Martin Michlmayr
http://www.cyrius.com/
