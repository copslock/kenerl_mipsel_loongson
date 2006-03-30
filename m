Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 03:09:30 +0100 (BST)
Received: from mf2.realtek.com.tw ([60.248.182.46]:30483 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133814AbWC3CJV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 03:09:21 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T775715cbe4dc803816a88@mf2.realtek.com.tw>;
 Thu, 30 Mar 2006 10:22:34 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006033010194768-94962 ;
          Thu, 30 Mar 2006 10:19:47 +0800 
Message-ID: <003701c653a0$6ab38320$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	"Kevin D. Kissell" <kevink@mips.com>,
	"Nigel Stephens" <nigel@mips.com>
Cc:	<linux-mips@linux-mips.org>
References: <024c01c65337$63931c90$106215ac@realtek.com.tw> <442A94D0.1020106@mips.com> <06d301c6533d$9c3c0f10$10eca8c0@grendel>
Subject: Re: Using hardware watchpoint for applications debugging
Date:	Thu, 30 Mar 2006 10:19:47 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/30 =?Bog5?B?pFekyCAxMDoxOTo0Nw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/30 =?Bog5?B?pFekyCAxMDoxOTo0OQ==?=,
	Serialize complete at 2006/03/30 =?Bog5?B?pFekyCAxMDoxOTo0OQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi Kevin,
After looking into function compute_return_epc(regs), we find that it can
just skip an instruction.
But the instruction that cause exceptions should not be skipped.

Regards,
Colin


----- Original Message ----- 
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Nigel Stephens" <nigel@mips.com>; "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Wednesday, March 29, 2006 10:32 PM
Subject: Re: Using hardware watchpoint for applications debugging


> > colin wrote:.
> > >     2. When an exception happens and we find that it's not touching
the righ
> > > address, we will discard it. However, exception will happen again
because
> > > the former instruction will be re-executed when the exception is
finished.
> > >
> >
> > You'll need to single-step over the instruction which generated the
> > unwanted watchpoint exception, with the watchpoint disabled. Then after
> > handling the single step reenable the watchpoint and resume normal
> > execution.
>
> There's actually a simpler and more efficient approach in Linux.  The code
> already exists in the MIPS Linux kernel to "skip" the instruction
responsible
> for the current exception, because the situation also arises for emulated
> instructions.   In do_watch(), in the cases where you want to ignore the
> watchpoint, you should be able to just invoke compute_return_epc(regs)
> and return.  There should be no need to handle single-step exceptions
> or disable/reenable the watchpoint.
>
>             Regards,
>
>             Kevin K.
