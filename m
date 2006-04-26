Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 12:08:02 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:37552 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S4475373AbWDZLHx
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Apr 2006 12:07:53 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k3QBKxMR018548;
	Wed, 26 Apr 2006 04:20:59 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k3QBKvkw013323;
	Wed, 26 Apr 2006 04:20:58 -0700 (PDT)
Message-ID: <005701c66924$00a74860$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kim, Jong-Sung" <jsungkim@lge.com>,
	"Thiemo Seufer" <ths@networkno.de>
Cc:	<linux-mips@linux-mips.org>
References: <081a01c66784$c6f7cb30$f3479696@LGE.NET> <009f01c6690e$0501a3d0$f3479696@LGE.NET> <20060426101603.GB29550@networkno.de>
Subject: Re: Reading an entire cacheline
Date:	Wed, 26 Apr 2006 13:24:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> [snip]
> > //" bne %0, %9, 2b\n"
> > " .set mips0\n"
> > " .set reorder"
> > : "=r" (tag[1][way][0]), "=r" (datalo[1][way][0]),
> >   "=r" (datahi[1][way][0]),
> >   "=r" (tag[1][way][1]), "=r" (datalo[1][way][1]),
> >   "=r" (datahi[1][way][1]),
> >   "=r" (tag[1][way][2]), "=r" (datalo[1][way][2]),
> >   "=r" (datahi[1][way][2]),
> >   "=r" (tag[1][way][3]), "=r" (datalo[1][way][3]),
> >   "=r" (datahi[1][way][3])
> > : "r" (0x80000000 | (way << 14) | (line << 5))
> > );
> 
> And this part may cause the problem you are seeing, I presume
> datalo/datahi live in memory, and accesses of it change the dcache.

As I was hoping disassembly would demonstrate for you,
declaring "=r" doesn't mean that the variable has no life
outside a register.

            Regards,

            Kevin K.
