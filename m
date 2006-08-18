Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 09:28:16 +0100 (BST)
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13318 "EHLO
	spitz.ucw.cz") by ftp.linux-mips.org with ESMTP id S20037748AbWHRI2O
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 09:28:14 +0100
Received: by spitz.ucw.cz (Postfix, from userid 0)
	id A5AF02787E; Fri, 18 Aug 2006 08:27:37 +0000 (UTC)
Date:	Fri, 18 Aug 2006 08:27:37 +0000
From:	Pavel Machek <pavel@ucw.cz>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	=?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@lifl.fr>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Message-ID: <20060818082736.GB7778@ucw.cz>
References: <200608102318.04512.thomas.koeller@baslerweb.com> <200608142126.29171.thomas.koeller@baslerweb.com> <20060817153138.GE5950@ucw.cz> <200608172230.30682.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608172230.30682.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.9i
Return-Path: <root@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Thu 17-08-06 22:30:30, Thomas Koeller wrote:
> On Thursday 17 August 2006 17:31, Pavel Machek wrote:
> > Well, I guess v4l api will need to be improved, then. That is still
> > not a reason to introduce completely new api...
> 
> The API as implemented by the driver I submitted is very minimalistic,
> because it is just a starting point. There's more to be added in future,
> like controlling flashes, interfacing to line-scan cameras clocked by
> incremental encodes attached to some conveyor, and other stuff which
> is common in industrial image processing applications. You really do


If it is _common_, we definitely need an API. We do not want the next
driver to reinvent it from scratch, right?
-- 
Thanks for all the (sleeping) penguins.
