Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2008 19:20:59 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:40682 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22371318AbYJYSUz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Oct 2008 19:20:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9PIKptk017906;
	Sat, 25 Oct 2008 19:20:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9PIKnki017905;
	Sat, 25 Oct 2008 19:20:49 +0100
Date:	Sat, 25 Oct 2008 19:20:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH][MIPS] fix kgdb build error
Message-ID: <20081025182049.GA17753@linux-mips.org>
References: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp> <20081024164241.GB21892@linux-mips.org> <20081025173035.6e05f8dc.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081025173035.6e05f8dc.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 25, 2008 at 05:30:35PM +0900, Yoichi Yuasa wrote:

> > <asm/ptrace.h> is exported to userland so we can't include these types.
> > Basically <linux/types.h> or <stdint.h> are polluting the namespace.  So
> > either we use some __* type and include only those or we get entirely
> > rid of typedef'ed types - as in the patch that you've posted while I was
> > writing this.
> 
> Thank you for your comment.
> KGDB still has a problem. This is kernel part in ptrace.h.
> 
> ---

Note that git will drop ALL comments below the "---" line which is not
what you want here ...

> Fix KGDB build error
> 
> In file included from include/linux/ptrace.h:49,
>                  from arch/mips/kernel/kgdb.c:25:
> /home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:123: error: expected declaration specifiers or '...' before '__s64'
> /home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:124: error: expected declaration specifiers or '...' before '__s64'
> /home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:126: error: expected declaration specifiers or '...' before '__u32'
> /home/yuasa/src/linux/test/mips/linux/arch/mips/include/asm/ptrace.h:127: error: expected declaration specifiers or '...' before '__u32'
> make[1]: *** [arch/mips/kernel/kgdb.o] Error 1
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Applied.  Thanks!

  Ralf
