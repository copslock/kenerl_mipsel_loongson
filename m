Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 14:14:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46258 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024223AbXHGNOu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 14:14:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l77DEm0w024256;
	Tue, 7 Aug 2007 14:14:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l77DEl7H024255;
	Tue, 7 Aug 2007 14:14:47 +0100
Date:	Tue, 7 Aug 2007 14:14:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 0/4] MIPS BCM947xx CPUs support
Message-ID: <20070807131447.GA24212@linux-mips.org>
References: <20070806150701.GE24308@hall.aurel32.net> <20070807125521.GA23739@linux-mips.org> <46B86F1E.6060206@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46B86F1E.6060206@aurel32.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 07, 2007 at 03:09:50PM +0200, Aurelien Jarno wrote:

> I don't see a patch corresponding to the MIPS tree in the broken-out
> directory. Anyway what other solution do you propose? I can see:

There isn't because until -rc2 everything went straight to Linus.  The
next -mm should have a git-mips patch again.

> - Integrate the patches that have the most risk of conflicts (I think
> patch #1) into the MIPS tree.
> - Integrate all BCM947xx patches into the MIPS tree accepting that it
> can compile without additional patches.
> - Integrate SSB patches into the MIPS tree.

I can do that if Andrew is ok with it?

  Ralf
