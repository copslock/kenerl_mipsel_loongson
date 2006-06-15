Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 01:38:27 +0100 (BST)
Received: from [220.76.242.187] ([220.76.242.187]:19934 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133906AbWFOAiR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jun 2006 01:38:17 +0100
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k5F0dYBb009479;
	Thu, 15 Jun 2006 09:39:39 +0900
Message-ID: <003c01c69014$4948a0c0$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <003401c68fa0$b60f4070$9d0ba8c0@mrv> <20060614115316.GA4515@linux-mips.org>
Subject: Re: "undefined symbol" on 2.6.14
Date:	Thu, 15 Jun 2006 09:40:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello, Ralf!
You wrote to "Roman Mashak" <mrv@corecom.co.kr> on Wed, 14 Jun 2006 12:53:16 
+0100:

 RB> The symbol isn't export simply because it wasn't considered useful to
 RB> export it.  The expected use of mips_hpt_frequency is to initialize it
 RB> in the platform code as system startup time to the counter frequency,
 RB> then not look at it again.

 RB> I wonder how you're using it in your module?
Actually it's not used anywhere in driver. Only timer functions and 
structures are in code. How come the linker refers to this particular 
function?

 RB> Any export I would add - as per general policy for the kernel - an
 RB> EXPORT_SYMBOL_GPL btw.

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
