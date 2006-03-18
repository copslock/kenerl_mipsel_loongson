Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Mar 2006 01:50:39 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:37130 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133534AbWCRBub (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Mar 2006 01:50:31 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B572164D3D; Sat, 18 Mar 2006 01:59:55 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3BCE266ED5; Sat, 18 Mar 2006 01:59:41 +0000 (GMT)
Date:	Sat, 18 Mar 2006 01:59:41 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	turja@mbnet.fi
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SGI VINO driver 64-bit fix / V4L ioctl compatibility layer needs fixes
Message-ID: <20060318015941.GY18750@deprecation.cyrius.com>
References: <Pine.GSO.4.58.0603171412170.11482@kekkonen.cs.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0603171412170.11482@kekkonen.cs.hut.fi>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* turja@mbnet.fi <turja@mbnet.fi> [2006-03-17 14:19]:
> This patch should fix problems with VINO drivers when using a 64-bit
> kernel.

Did you test this?

It looks exactly like the patch you gave me for testing a few days ago
and that did not work...

> There are also other bugs which prevent V4L drivers from functioning
> correctly when using 32-bit userland with a 64-bit kernel as the ioctl
> compatibility layer (in drivers/media/video/compat_ioctl32.c) doesn't seem
> to handle VIDIOC_CROPCAP.

... or did I see this bug?
-- 
Martin Michlmayr
http://www.cyrius.com/
