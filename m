Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 15:30:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:33491 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023905AbXHCOad (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2007 15:30:33 +0100
Received: from localhost (p3243-ipad26funabasi.chiba.ocn.ne.jp [220.104.89.243])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 02346A82D; Fri,  3 Aug 2007 23:29:12 +0900 (JST)
Date:	Fri, 03 Aug 2007 23:30:21 +0900 (JST)
Message-Id: <20070803.233021.108306469.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	hch@lst.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Use -Werror on TX39/TX49 boards
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070803133629.GB16519@linux-mips.org>
References: <20070802.233617.70476666.anemo@mba.ocn.ne.jp>
	<20070803132550.GA21454@lst.de>
	<20070803133629.GB16519@linux-mips.org>
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
X-archive-position: 16055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 3 Aug 2007 14:36:29 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Please don't.  Adding -Werror is a complete pain in the ass for people
> > using new compilers or when we get things like __deprecated or
> > __warn_unused warnings from headers.  We've dropped it again from
> > the various placed that had introduced this.
> 
> It seems to crank up the the pain level to the point where people upgrade
> their code :-)

Well, I just followed recent MIPS trend ;) I don't mind if you dropped
them again.

---
Atsushi Nemoto
