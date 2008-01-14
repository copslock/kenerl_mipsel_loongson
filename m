Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 00:01:46 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59074 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035097AbYANABo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 00:01:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0E01dfG020258;
	Mon, 14 Jan 2008 00:01:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0E01cHW020257;
	Mon, 14 Jan 2008 00:01:38 GMT
Date:	Mon, 14 Jan 2008 00:01:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix ethernet interrupts for Cobalt RaQ1
Message-ID: <20080114000138.GA20115@linux-mips.org>
References: <20080111232514.64772C2F2A@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080111232514.64772C2F2A@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 12, 2008 at 12:25:14AM +0100, Thomas Bogendoerfer wrote:

> RAQ1 uses the same interrupt routing as qube2.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied with comment fix from Martin.

Thanks,

  Ralf
