Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 16:17:01 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:54518 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038926AbWLMQQ4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2006 16:16:56 +0000
Received: from localhost (p2025-ipad210funabasi.chiba.ocn.ne.jp [58.88.121.25])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 399E5C0AA; Thu, 14 Dec 2006 01:16:52 +0900 (JST)
Date:	Thu, 14 Dec 2006 01:16:51 +0900 (JST)
Message-Id: <20061214.011651.31638583.anemo@mba.ocn.ne.jp>
To:	dmitry.adamushko@gmail.com
Cc:	ths@networkno.de, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: unwind_stack() and an exception at the last instruction (after
 the epilogue)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <b647ffbd0612130640r10bedda5l491679df882fe2e@mail.gmail.com>
References: <b647ffbd0612130445r14895d70p4ea313f94dee8b41@mail.gmail.com>
	<20061213135222.GB25904@networkno.de>
	<b647ffbd0612130640r10bedda5l491679df882fe2e@mail.gmail.com>
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
X-archive-position: 13447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 13 Dec 2006 15:40:21 +0100, "Dmitry Adamushko" <dmitry.adamushko@gmail.com> wrote:
> e.g. as we know the start and end address of the function
> (ksyms_lookup_size_off()), it's possible to find out a position of the
> "prologue" and "epilogue" (addiu sp,sp,SIZE - the same way it's done
> in get_frame_info()) so we would know:
> 
> function_start (1), prologue_addr (2), epilogue_addr (3), function_end (4)
> 
> and this would cover the (broken) cases when <epc> is in [1, 2] or [3, 4]
> as well as the cases when e.g. <sp> is broken in the prologue ?

It would be hard because:

* A function can have multiple epilogues.
* gcc often moves "if" block codes to end of the function.

While current unwind_stack() is not perfect, any attempt to make it
robust is welcome.  But you might have to analyze _all_ code if you
wanted to save _all_ case.  I think UNIX's "90% principle" is good
enough here.

BTW, enqueue_task() will not use stack anymore since
SCHED_NO_NO_OMIT_FRAME_POINTER is defined.

---
Atsushi Nemoto
