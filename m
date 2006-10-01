Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 16:07:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:53725 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037887AbWJAPHA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Oct 2006 16:07:00 +0100
Received: from localhost (p3194-ipad03funabasi.chiba.ocn.ne.jp [219.160.83.194])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1BC29A6E3; Mon,  2 Oct 2006 00:06:56 +0900 (JST)
Date:	Mon, 02 Oct 2006 00:09:07 +0900 (JST)
Message-Id: <20061002.000907.130240123.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-5)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <105ACD1A-F259-46BE-BB1C-CE4075AF9290@gmail.com>
References: <8D501155-BC7A-471A-9374-9EB8D48BE307@gmail.com>
	<20061001.235254.126142488.anemo@mba.ocn.ne.jp>
	<105ACD1A-F259-46BE-BB1C-CE4075AF9290@gmail.com>
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
X-archive-position: 12757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 1 Oct 2006 23:57:03 +0900, girish <girishvg@gmail.com> wrote:
> > No.  4000_0000 physical is never mapped to 4000_0000 virtual.  The low
> > 2GB of virtual address space are used for user mapping.
> 
> Can't I provide Kernel mapping via swapper_pg_dir to 4000_0000?

Yes.  I do not think it is possible.

> I have, to some extent, already incorporated highmem (1GB) through  
> HIGHMEM + SPARSEMEM combination.

So using __pa() and __va() for HIGHMEM page is wrong.  If there were
such usages, please fix them instead.

---
Atsushi Nemoto
