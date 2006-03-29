Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 15:19:08 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:14799 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133728AbWC2OTA
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 15:19:00 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2TETOpn021123;
	Wed, 29 Mar 2006 06:29:25 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k2TETMVr017652;
	Wed, 29 Mar 2006 06:29:23 -0800 (PST)
Message-ID: <06d301c6533d$9c3c0f10$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Nigel Stephens" <nigel@mips.com>, "colin" <colin@realtek.com.tw>
Cc:	<linux-mips@linux-mips.org>
References: <024c01c65337$63931c90$106215ac@realtek.com.tw> <442A94D0.1020106@mips.com>
Subject: Re: Using hardware watchpoint for applications debugging
Date:	Wed, 29 Mar 2006 16:32:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> colin wrote:.
> >     2. When an exception happens and we find that it's not touching the righ
> > address, we will discard it. However, exception will happen again because
> > the former instruction will be re-executed when the exception is finished.
> >
> 
> You'll need to single-step over the instruction which generated the
> unwanted watchpoint exception, with the watchpoint disabled. Then after
> handling the single step reenable the watchpoint and resume normal
> execution.

There's actually a simpler and more efficient approach in Linux.  The code 
already exists in the MIPS Linux kernel to "skip" the instruction responsible 
for the current exception, because the situation also arises for emulated 
instructions.   In do_watch(), in the cases where you want to ignore the
watchpoint, you should be able to just invoke compute_return_epc(regs)
and return.  There should be no need to handle single-step exceptions 
or disable/reenable the watchpoint.

            Regards,

            Kevin K.
