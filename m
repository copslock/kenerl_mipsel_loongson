Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2004 07:49:29 +0000 (GMT)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:60431 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225195AbUKLHtX>; Fri, 12 Nov 2004 07:49:23 +0000
Received: from msx.realtek.com.tw (unverified [172.20.1.77]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T6d39e33cbcdc80381690c@mf2.realtek.com.tw>;
 Fri, 12 Nov 2004 15:50:28 +0800
Received: from rtpdii3098 ([172.19.26.139])
          by msx.realtek.com.tw (Lotus Domino Release 6.0.2CF1)
          with ESMTP id 2004111215503028-57814 ;
          Fri, 12 Nov 2004 15:50:30 +0800 
Message-ID: <000d01c4c88c$1a82e8a0$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Vladimir A. Gurevich" <vag@paulidav.org>
Cc: <linux-mips@linux-mips.org>
References: <01e101c4c182$5d0f2780$8b1a13ac@realtek.com.tw> <4188F75E.9010105@paulidav.org>
Subject: Re: KGDB: I cannot stop execution by using "ctrl+c"
Date: Fri, 12 Nov 2004 15:49:13 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/11/12 =?Bog5?B?pFWkyCAwMzo1MDozMA==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/11/12
 =?Bog5?B?pFWkyCAwMzo1MDozMQ==?=,
	Serialize complete at 2004/11/12 =?Bog5?B?pFWkyCAwMzo1MDozMQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi Vladimir,
It still cannot work using "set remotebreak 1".

Regards,
Colin


----- Original Message ----- 
From: "Vladimir A. Gurevich" <vag@paulidav.org>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Wednesday, November 03, 2004 11:21 PM
Subject: Re: KGDB: I cannot stop execution by using "ctrl+c"


> Hello Colin,
> 
> colin wrote:
> 
> >When using gdb to debug Linux kernel, I found that it cannot be stopped
> >temporarily by using "ctrl+c".
> >After the first strike of "ctrl+c", nothing happen.
> >After the second, Linux kernel will show these messages:
> >    Interrupted while waiting for the program.
> >    Give up (and stop debugging it)? (y or n)
> >If choose yes, kernel will totally stop and it goes back to gdb shell.
> >How can I stop kernel temporarily and then resume it?
> >
> You should use the following command in GDB:
> 
>     set remotebreak 1
> 
> After that it will start to behave as you expect it to, i.e. it will 
> interrupt the kernel as soon as you press CTRL-C.
> 
> Happy hacking,
> Vladimir
> 
