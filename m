Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 03:22:57 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:54735 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022534AbXF1CWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Jun 2007 03:22:52 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 28 Jun 2007 11:22:50 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3139C2039C;
	Thu, 28 Jun 2007 11:22:25 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 24B54201C8;
	Thu, 28 Jun 2007 11:22:25 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l5S2MNAF041474;
	Thu, 28 Jun 2007 11:22:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 28 Jun 2007 11:22:23 +0900 (JST)
Message-Id: <20070628.112223.96686654.nemoto@toshiba-tops.co.jp>
To:	hch@lst.de
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] generic clk API implementation for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070627153932.GA6016@lst.de>
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com>
	<20070627.013312.25479645.anemo@mba.ocn.ne.jp>
	<20070627153932.GA6016@lst.de>
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
X-archive-position: 15558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Jun 2007 17:39:32 +0200, Christoph Hellwig <hch@lst.de> wrote:
> > This MIPS implementation is derived (and stripped) from the SH
> > implementation.
> 
> Why is this not in architecture-independent code?

Yes, this is architecture independent.  If we could have consensus on
a generic (or least common) implementation, we can put it outside arch
directory.

But I gave up for now ;) I will leave all implementation for platform
code.

---
Atsushi Nemoto
