Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2009 15:02:56 +0000 (GMT)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:65471 "EHLO
	smtp14.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S21367713AbZCWPCv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Mar 2009 15:02:51 +0000
Received: from shinya-kuribayashis-macbook.local (PPPax1767.tokyo-ip.dti.ne.jp [210.159.179.17]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n2NF2leW001804;Tue, 24 Mar 2009 00:02:47 +0900 (JST)
Message-ID: <49C7A497.3020801@ruby.dti.ne.jp>
Date:	Tue, 24 Mar 2009 00:02:47 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Mark Eins: Fix cascading interrupt dispatcher
References: <49C4E5D5.4070408@ruby.dti.ne.jp> <20090323135239.GA21286@linux-mips.org>
In-Reply-To: <20090323135239.GA21286@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Looks ok - but this patch series conflicts with your earlier patch
> 
> http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=45d0f39ad6ecc84fa5a3ca301497842ea68bd633
> 
> Let me know what to do.  Thanks.

If possible, please drop the commit above, then apply new four patches.
Or, apply three patches except for "MIPS: EMMA2RH: Use handle_edge_irq()
handler".  I hope they don't conflict with the commit above.

  MIPS: Mark Eins: Fix cascading interrupt dispatcher
* MIPS: EMMA2RH: Use handle_edge_irq() handler for GPIO interrupts
  MIPS: EMMA2RH: Use set_irq_chip_and_handler_name
  MIPS: EMMA2RH: Set UART mapbase

Sorry for inconvenience,

P.S.

> * Prevent cascading interrupt bits being processed afterward

I would like to say `prevent A from B', of course...

  Shinya
