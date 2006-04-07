Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:28:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54927 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133616AbWDGQ2Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 17:28:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k37GdpkP017118;
	Fri, 7 Apr 2006 17:39:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k37GdpP9017117;
	Fri, 7 Apr 2006 17:39:51 +0100
Date:	Fri, 7 Apr 2006 17:39:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] use __ffs() instead of ffs() on waybit calculation
Message-ID: <20060407163951.GB10564@linux-mips.org>
References: <20060408.013331.71086855.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408.013331.71086855.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 08, 2006 at 01:33:31AM +0900, Atsushi Nemoto wrote:

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Nice cleanup, applied.

  Ralf
