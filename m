Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jan 2003 14:53:03 +0000 (GMT)
Received: from heffalump.fnal.gov ([IPv6:::ffff:131.225.9.20]:44284 "EHLO
	fnal.gov") by linux-mips.org with ESMTP id <S8225262AbTAaOxD>;
	Fri, 31 Jan 2003 14:53:03 +0000
Received: from ppd89948 ([131.225.55.68])
 by smtp.fnal.gov (PMDF V6.0-24 #37519) with ESMTP id
 <0H9L005MY2OCJT@smtp.fnal.gov>; Fri, 31 Jan 2003 08:53:00 -0600 (CST)
Date: Fri, 31 Jan 2003 08:53:00 -0600
From: Jason Ormes <jormes@wideopenwest.com>
Subject: RE: compiling mips64 problem
In-reply-to: <20030131151519.B14518@linux-mips.org>
To: 'Ralf Baechle' <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Message-id: <000201c2c938$72ebe910$4437e183@fermi.win.fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook, Build 10.0.4024
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Return-Path: <jormes@wideopenwest.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jormes@wideopenwest.com
Precedence: bulk
X-list: linux-mips

Hey that did it thanks.


-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
Sent: Friday, January 31, 2003 8:15 AM
To: Jason Ormes
Cc: linux-mips@linux-mips.org
Subject: Re: compiling mips64 problem

On Fri, Jan 31, 2003 at 08:14:51AM -0600, Jason Ormes wrote:

> I went into the linux folder and did a make menuconfig.  I changed the
cpu 
> selection to mips64 and went to the kernel hacking section and turned
on the 
> are you using a cross compiler option.  exited and saved.
> 
> commands used after that were
> 
> make ARCH=mips64 dep
> make ARCH=mips64 all

make ARCH=mips64 menuconfig

  Ralf
