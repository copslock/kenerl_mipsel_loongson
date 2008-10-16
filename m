Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2008 18:29:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53494 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21652636AbYJPR3G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2008 18:29:06 +0100
Received: from localhost (p6178-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.178])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 74FFBAA8C; Fri, 17 Oct 2008 02:29:02 +0900 (JST)
Date:	Fri, 17 Oct 2008 02:29:10 +0900 (JST)
Message-Id: <20081017.022910.95501548.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48F7787B.2060807@ru.mvista.com>
References: <48F7391D.8050109@ru.mvista.com>
	<20081017.013101.128619577.anemo@mba.ocn.ne.jp>
	<48F7787B.2060807@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 16 Oct 2008 21:23:07 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>>+	if ((dma_stat & 7) == 0 &&
> >>>+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> >>>+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
> >>
> >>   Parens around & and | are hardly needed...
> 
> > You mean more parens are needed?
> 
>     I mean less. :-)

Well, I think all above parens are required.  '&' and '|' are weaker
than '==', no?

---
Atsushi Nemoto
