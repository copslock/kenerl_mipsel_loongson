Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Oct 2007 00:55:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51426 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029011AbXJFXzA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 7 Oct 2007 00:55:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l96NsuZN014533;
	Sun, 7 Oct 2007 00:54:56 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l96NstDD014532;
	Sun, 7 Oct 2007 00:54:55 +0100
Date:	Sun, 7 Oct 2007 00:54:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel bug using 2.6.23-rc9
Message-ID: <20071006235455.GA14319@linux-mips.org>
References: <1191502153.10050.15.camel@scarafaggio> <20071005122543.GB22239@linux-mips.org> <20071006090809.bb738bab.giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071006090809.bb738bab.giuseppe@eppesuigoccas.homedns.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 06, 2007 at 09:08:09AM +0200, Giuseppe Sacco wrote:

> I may reproduce it without problems. The failing command is "ps aux". Once the command starts, the kernel log the bug and the command stay blocked: no shell prompt, no control-c working. Since the ps command does not work, I cannot check the prosess status :-)

ps does a few very specific things in the memory managment.  So that's
probably already all the information I need to deal with this one,
thanks!

  Ralf
