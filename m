Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 17:06:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43467 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22304138AbYJXQGF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 17:06:05 +0100
Received: from localhost (p4039-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 77130AD22; Sat, 25 Oct 2008 01:05:59 +0900 (JST)
Date:	Sat, 25 Oct 2008 01:06:17 +0900 (JST)
Message-Id: <20081025.010617.78730272.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20081025.005544.92344156.anemo@mba.ocn.ne.jp>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<4900B6A8.30705@ru.mvista.com>
	<20081025.005544.92344156.anemo@mba.ocn.ne.jp>
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
X-archive-position: 20937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 25 Oct 2008 00:55:44 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >     Same comment about calculating only once...
> 
> Yes.  But are there any good place to hold calculated values?  I don't
> think it is not worth to allocate a local structure just for holding
> such values.  And this is not a critical path anyway :-)

Oh, I mean "I don't think it is worth to ...".
---
Atsushi Nemoto
