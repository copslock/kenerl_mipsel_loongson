Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 18:46:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22219 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037816AbXBSSqr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Feb 2007 18:46:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1JIklDN010873;
	Mon, 19 Feb 2007 18:46:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1JIkkaS010872;
	Mon, 19 Feb 2007 18:46:46 GMT
Date:	Mon, 19 Feb 2007 18:46:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix __copy_{to,from}_user_inatomic
Message-ID: <20070219184646.GA10820@linux-mips.org>
References: <45D5CEA5.3050604@innova-card.com> <20070217.011220.70478485.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070217.011220.70478485.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 17, 2007 at 01:12:20AM +0900, Atsushi Nemoto wrote:
> Date:	Sat, 17 Feb 2007 01:12:20 +0900 (JST)
> To:	vagabon.xyz@gmail.com
> Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
> Subject: Re: [PATCH] Fix __copy_{to,from}_user_inatomic
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> On Fri, 16 Feb 2007 16:32:53 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > These functions are aliases to __copy_{to,from}_user resp but they
> > are not allowed to sleep. Therefore might_sleep() must not be used
> > by their implementions.
> 
> This changes CONFIG_PREEMPT_VOLUNTARY behavior.
> In this case might_sleep() is not just an annotation.
> 
> Well, so currently CONFIG_PREEMPT_VOLUNTARY seems broken.  Maybe we
> need separete functions anyway.

The issue needed to be tackled so while suboptimal I've added a chainsawed
version of memcpy to provide __copy_from_user_inatomic.  Not elegant but
hopefully that will be cleaned soon.  memcpy could use a general ovehaul
anyway.

  Ralf
