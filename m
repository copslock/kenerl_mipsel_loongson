Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2009 15:36:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52679 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21367813AbZCWPgM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2009 15:36:12 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2NFa8Qi027351;
	Mon, 23 Mar 2009 16:36:10 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2NFa6Vp027294;
	Mon, 23 Mar 2009 16:36:06 +0100
Date:	Mon, 23 Mar 2009 16:36:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Mark Eins: Fix cascading interrupt dispatcher
Message-ID: <20090323153605.GA26942@linux-mips.org>
References: <49C4E5D5.4070408@ruby.dti.ne.jp> <20090323135239.GA21286@linux-mips.org> <49C7A497.3020801@ruby.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49C7A497.3020801@ruby.dti.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 24, 2009 at 12:02:47AM +0900, Shinya Kuribayashi wrote:

> Ralf Baechle wrote:
>> Looks ok - but this patch series conflicts with your earlier patch
>>
>> http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=45d0f39ad6ecc84fa5a3ca301497842ea68bd633
>>
>> Let me know what to do.  Thanks.
>
> If possible, please drop the commit above, then apply new four patches.
> Or, apply three patches except for "MIPS: EMMA2RH: Use handle_edge_irq()
> handler".  I hope they don't conflict with the commit above.

Okay, done.

>> * Prevent cascading interrupt from bits being processed afterward
>
> I would like to say `prevent A from B', of course...

Fixed.

  Ralf
