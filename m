Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 16:03:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:11210 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20178482AbYIKPDw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2008 16:03:52 +0100
Received: from localhost (p5068-ipad311funabasi.chiba.ocn.ne.jp [123.217.215.68])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 162EDB624; Fri, 12 Sep 2008 00:03:45 +0900 (JST)
Date:	Fri, 12 Sep 2008 00:03:49 +0900 (JST)
Message-Id: <20080912.000349.18312151.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48C7EDE4.3090400@ru.mvista.com>
References: <48C6B768.4010200@ru.mvista.com>
	<20080911.003222.51867360.anemo@mba.ocn.ne.jp>
	<48C7EDE4.3090400@ru.mvista.com>
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
X-archive-position: 20462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 10 Sep 2008 19:55:16 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > But the "Command Transfer Mode Select" bits affects access timings on
> > setting task registers for DMA command.
> 
>     So what? PIO and DMA are different protocols on IDE bus, so they shouldn't 
> affect each other. The IDE core will always tune the best PIO mode for you, so 
> the optimal command timings will be set.

Hmm, that would be a thing I had misunderstood.  I thought
set_pio_mode is not called when the drive was DMA capable.

Thank you for detailed review!

---
Atsushi Nemoto
