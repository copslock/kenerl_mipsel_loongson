Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 14:41:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:14301 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20226937AbYIYNlD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 14:41:03 +0100
Received: from localhost (p4221-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.221])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 649E3B9EF; Thu, 25 Sep 2008 22:40:56 +0900 (JST)
Date:	Thu, 25 Sep 2008 22:41:23 +0900 (JST)
Message-Id: <20080925.224123.74566929.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	bzolnier@gmail.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48DA8658.2040107@ru.mvista.com>
References: <20080922.013256.128618380.anemo@mba.ocn.ne.jp>
	<48DA2543.4050304@ru.mvista.com>
	<48DA8658.2040107@ru.mvista.com>
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
X-archive-position: 20633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 24 Sep 2008 22:26:32 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >   Frankly speaking, I couldn't make out much of tht passage:
> 
> > <CAUSION>
> > The write to the register by the Device/Head register may cause an 
> > unexpected function by write wrong
> > data to the register. So please rewrite to the System Control register 
> > after write to the Device/Head
> > register to secure write to System Control register in ATA100 Core.
> 
>     I thought that this was related to loading the correct transfer mode for 
> the selected drive. But if it's not only that, it would be quite pointless to 
> also implement selectproc() method if you have to hook the tf_load() method...

Hmm, indeed.  I'will try to get rid of selectproc.

---
Atsushi Nemoto
