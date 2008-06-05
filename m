Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 12:58:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29862 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20022151AbYFEL6T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 12:58:19 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BD61FD8DE; Thu,  5 Jun 2008 11:58:16 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4BDA0150F76; Thu,  5 Jun 2008 13:57:59 +0200 (CEST)
Date:	Thu, 5 Jun 2008 13:57:59 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Chris Dearman <chris@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: mips/kernel/traps.c build error
Message-ID: <20080605115759.GA5043@deprecation.cyrius.com>
References: <20080525164311.GB1791@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080525164311.GB1791@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Adrian Bunk <bunk@kernel.org> [2008-05-25 19:43]:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/kernel/traps.c: In function 'show_raw_backtrace':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/kernel/traps.c:92: error: cast from pointer to integer of different size
> make[2]: *** [arch/mips/kernel/traps.o] Error 1
> 
> <--  snip  -->
> 
> "[MIPS] Fix check for valid stack pointer during backtrace" in the mips 
> tree fixes it, and should therefore also go into 2.6.26.

It's still not in mainline as of rc5.
-- 
Martin Michlmayr
http://www.cyrius.com/
