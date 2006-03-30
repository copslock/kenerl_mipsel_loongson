Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 03:05:13 +0100 (BST)
Received: from mf2.realtek.com.tw ([60.248.182.46]:50450 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133814AbWC3CFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 03:05:02 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T775711d8f7dc803816a88@mf2.realtek.com.tw>;
 Thu, 30 Mar 2006 10:18:15 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006033010152855-94833 ;
          Thu, 30 Mar 2006 10:15:28 +0800 
Message-ID: <002d01c6539f$d040a200$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	"Nigel Stephens" <nigel@mips.com>
Cc:	<linux-mips@linux-mips.org>
References: <024c01c65337$63931c90$106215ac@realtek.com.tw> <442A94D0.1020106@mips.com>
Subject: Re: Using hardware watchpoint for applications debugging
Date:	Thu, 30 Mar 2006 10:15:28 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/30 =?Bog5?B?pFekyCAxMDoxNToyOA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/30 =?Bog5?B?pFekyCAxMDoxNTozMA==?=,
	Serialize complete at 2006/03/30 =?Bog5?B?pFekyCAxMDoxNTozMA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi Nigel,
We use the same way with you to handle the issue 2.

As to adding watchpoint to kernel, there will be another problem.
ASID in kernel is variable. Therefore, we cannot indicate which thread we
want to watch by ASID.
What we can do is setting G (global) bit to WatchHi Register and then all
threads accessing that address will cause the exception.
In the exception, it will filter the threads by PID to find out the thread
we are watching.

Regards,
Colin

----- Original Message ----- 
From: "Nigel Stephens" <nigel@mips.com>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Wednesday, March 29, 2006 10:08 PM
Subject: Re: Using hardware watchpoint for applications debugging


>
>
> colin wrote:.
> >     2. When an exception happens and we find that it's not touching the
righ
> > address, we will discard it. However, exception will happen again
because
> > the former instruction will be re-executed when the exception is
finished.
> >
> >
>
> You'll need to single-step over the instruction which generated the
> unwanted watchpoint exception, with the watchpoint disabled. Then after
> handling the single step reenable the watchpoint and resume normal
> execution.
>
> It would be best if you added watchpoint support to the kernel ptrace
> code: since that would make the watchpoints usable by GDB also.
>
> Nigel
>
