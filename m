Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 20:19:37 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:24083 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133623AbWB1UT1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 20:19:27 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BA0D464D3D; Tue, 28 Feb 2006 20:27:06 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1220981F5; Tue, 28 Feb 2006 21:26:59 +0100 (CET)
Date:	Tue, 28 Feb 2006 20:26:59 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
Message-ID: <20060228202658.GA22394@deprecation.cyrius.com>
References: <20060222190940.GA29967@linux-mips.org> <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com> <20060224014226.GA26064@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224014226.GA26064@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-24 01:42]:
> > I'm not sure if this is the specific fix or not, but I can report that git
> > as of today (approx 2pm est) is working better than is has since 2.6.14 for
> > me on a bcm1480.
> 
> Strange, I get the following oops during boot with latest git:

I upgraded CFE (to 1.2.5) and now the kernel boots.

Mark, it seems the CFE you ship 1480 boards with cannot boot current
kernels.  Maybe you want to check this out.
-- 
Martin Michlmayr
http://www.cyrius.com/
