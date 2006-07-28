Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 15:37:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51684 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133723AbWG1OhU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 15:37:20 +0100
Received: from localhost (p7008-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.8])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 17DCFB56B; Fri, 28 Jul 2006 23:37:12 +0900 (JST)
Date:	Fri, 28 Jul 2006 23:38:42 +0900 (JST)
Message-Id: <20060728.233842.41629448.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	vagabon.xyz@gmail.com, ddaney@avtrex.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060727191245.GD4505@networkno.de>
References: <20060727170305.GB4505@networkno.de>
	<cda58cb80607271151n2dcfe64cn4cb1ecca3ece6b1e@mail.gmail.com>
	<20060727191245.GD4505@networkno.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 27 Jul 2006 20:12:45 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> IOW, binary analysis can't be expected to provide full accuracy, but
> we can live with a reasonable approximation, I think.

Yes, this is a starting point.

The patch (and current mips get_wchan() implementation) tries to do is
what I used to do to analyze stack dump by hand.

1. Determine PC and SP.
2. Disassemble a function containing the PC address.
3. If the function is leaf, make use RA for new PC.
4. Otherwise, obtain saved RA from stack and use it for new PC.
5. Calculate new SP by undoing "addiu sp,sp,-imm".
6. Back to (2).

While it is hard to make the get_frame_info() perfect, this approach
might fail sometimes.  But it can work well for most case, and if it
did well we can get very good stack trace than current one (which may
contain so many false entries).

If you wanted to know the difference, please try ALT-SYSRQ-T (or
BREAK-T for serial console) with and without this patch :-)

---
Atsushi Nemoto
