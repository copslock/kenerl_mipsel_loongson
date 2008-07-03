Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:03:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:42178 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20130896AbYGCPCw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2008 16:02:52 +0100
Received: from localhost (p7152-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3F765ADA1; Fri,  4 Jul 2008 00:02:45 +0900 (JST)
Date:	Fri, 04 Jul 2008 00:04:26 +0900 (JST)
Message-Id: <20080704.000426.39153587.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	mlarsen@broadcom.com, linux-mips@linux-mips.org
Subject: Re: Bug in atomic_sub_if_positive
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080702105155.GC7007@networkno.de>
References: <20080702095955.GA7007@networkno.de>
	<20080702.193133.211490377.nemoto@toshiba-tops.co.jp>
	<20080702105155.GC7007@networkno.de>
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
X-archive-position: 19707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 2 Jul 2008 11:51:55 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > The patch looks correct.
> 
> Agreed.

Ralf, too late for 2.6.26?
Anyway I think it should go into -stable tree too.

---
Atsushi Nemoto
