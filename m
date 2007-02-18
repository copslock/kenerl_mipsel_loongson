Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 16:00:17 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:36602 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039429AbXBRQAL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2007 16:00:11 +0000
Received: from localhost (p2027-ipad11funabasi.chiba.ocn.ne.jp [219.162.37.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 435FDB661; Mon, 19 Feb 2007 00:58:50 +0900 (JST)
Date:	Mon, 19 Feb 2007 00:58:50 +0900 (JST)
Message-Id: <20070219.005850.96686775.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make __declare_dbe_table() static
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070218155408.GA24660@linux-mips.org>
References: <20070219.004435.25910295.anemo@mba.ocn.ne.jp>
	<20070218155408.GA24660@linux-mips.org>
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
X-archive-position: 14147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 18 Feb 2007 15:54:08 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Make __declare_dbe_table() static and call it explicitly to ensure not
> > optimized out.
> 
> That's what __attribute_used__ was meant to be used for.

But we do not need empty __declare_dbe_table() function body (jr ra +
nop) at all.  If we called it explicitly, compiler will optimized it
out.  Saves two instructions ;)
