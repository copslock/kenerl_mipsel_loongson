Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 17:12:11 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:30680 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024862AbXJVQMC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2007 17:12:02 +0100
Received: from localhost (p4177-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 78BD69EB9; Tue, 23 Oct 2007 01:10:41 +0900 (JST)
Date:	Tue, 23 Oct 2007 01:12:34 +0900 (JST)
Message-Id: <20071023.011234.131103065.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de
Subject: Re: [PATCH] Make c0_compare_int_usable more bullet proof
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071022.233733.35469871.anemo@mba.ocn.ne.jp>
References: <20071020.005445.75183929.anemo@mba.ocn.ne.jp>
	<20071022093139.GA5588@linux-mips.org>
	<20071022.233733.35469871.anemo@mba.ocn.ne.jp>
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
X-archive-position: 17157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007 23:37:33 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > Hmm...  This one makes c0_compare_int_usable() fails when I run a malta
> > kernel on last week's qemu.
> 
> Well, with my qemu-system-mips (0.9.0 and cvs),
> c0_compare_int_usable() always return 0 with/without my patch.

Then I will split this patch.  Please try them.

---
Atsushi Nemoto
