Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 12:27:35 +0100 (BST)
Received: from p508B58ED.dip.t-dialin.net ([IPv6:::ffff:80.139.88.237]:28370
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225225AbTD1L1d>; Mon, 28 Apr 2003 12:27:33 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3SBRTK32019;
	Mon, 28 Apr 2003 13:27:29 +0200
Date: Mon, 28 Apr 2003 13:27:29 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, nemoto@toshiba-tops.co.jp
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030428132729.A31970@linux-mips.org>
References: <20030424114755Z8225208-1272+1554@linux-mips.org> <20030428.192503.104027383.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030428.192503.104027383.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Mon, Apr 28, 2003 at 07:25:03PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 28, 2003 at 07:25:03PM +0900, Atsushi Nemoto wrote:

> ralf> 	Fix build for MIPS III.
> 
> It seems the .mips4 was added in wrong place (both 2.4 and 2.5).
> This patch is for 2.4.  Please apply to both tree.  Thank you.

Thanks for reminding me of this one, I had already had an identical patch
applie to my tree but didn't commit it due to problems with the CVS
archive in the past days.  That's also the explanation for a few lost or
delayed commit notifications, btw.

  Ralf
