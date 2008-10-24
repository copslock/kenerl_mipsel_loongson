Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 15:20:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:23536 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22297247AbYJXOUu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 15:20:50 +0100
Received: from localhost (p4039-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8B997AC53; Fri, 24 Oct 2008 23:20:44 +0900 (JST)
Date:	Fri, 24 Oct 2008 23:20:57 +0900 (JST)
Message-Id: <20081024.232057.85420526.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	bzolnier@gmail.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4901AD8F.4000007@ru.mvista.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<200810232247.05686.bzolnier@gmail.com>
	<4901AD8F.4000007@ru.mvista.com>
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
X-archive-position: 20928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 24 Oct 2008 15:12:15 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>    I've realized that I have a question to Atsushi on why he chose the 
> same way of implemnting the register accesses as on TX4939 despite 
> TX4938 IDE is not really a SoC but a board level device (so probable 
> should be using the normal, not the "raw" I/O accessors)...

Well, because it behaves like SoC registers, not as other PCI IDE
registers (which are swapped on big endian).

Maybe new board designer can chose another option, so it might be
worth to add 'do_swap' member in tx4938ide_platform_info.  But anyway
current code just works with both endian on RBTX4938 board :-)

---
Atsushi Nemoto
