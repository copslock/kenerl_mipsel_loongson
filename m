Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 16:11:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24299 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039265AbXBMQLf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 16:11:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DGBZdY009660;
	Tue, 13 Feb 2007 16:11:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1DGBY7d009659;
	Tue, 13 Feb 2007 16:11:34 GMT
Date:	Tue, 13 Feb 2007 16:11:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: More __get_user_asm_ll32 ...
Message-ID: <20070213161134.GB4942@linux-mips.org>
References: <20070213133251.GA7518@linux-mips.org> <20070214.010615.101715999.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070214.010615.101715999.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 14, 2007 at 01:06:15AM +0900, Atsushi Nemoto wrote:

> Why is it clears the error return?  The "3:" label is just after the
> junk move.

You're right and the final commit message reflects that.  So this is really
only a code size (320 bytes) and performance fix.

  Ralf
