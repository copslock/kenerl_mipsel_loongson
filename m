Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 16:49:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:8655 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038547AbWJWPt3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 16:49:29 +0100
Received: from localhost (p7236-ipad31funabasi.chiba.ocn.ne.jp [221.189.131.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D49C2A6E3; Tue, 24 Oct 2006 00:49:25 +0900 (JST)
Date:	Tue, 24 Oct 2006 00:51:50 +0900 (JST)
Message-Id: <20061024.005150.63738357.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453CE22A.5090700@ru.mvista.com>
References: <453CD3ED.8020005@ru.mvista.com>
	<20061024.003845.71086839.anemo@mba.ocn.ne.jp>
	<453CE22A.5090700@ru.mvista.com>
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
X-archive-position: 13070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Oct 2006 19:39:22 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Replacing mips_hpt_read involves changes for _all_ platform code so I
> 
>     Only 3 files in the current arch/mips/ actually, excluding
> time.c and the header file (to make it visible).

Oh, I thought we should replace mips_hpt_read and mips_hpt_frequency
too.  But calling do_div() in each platform looks so ugly.  Hmm...

---
Atsushi Nemoto
