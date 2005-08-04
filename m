Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2005 17:10:53 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:51725 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225727AbVHDQKb>; Thu, 4 Aug 2005 17:10:31 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.4) with ESMTP id <T728f87e055dc80381613d4@mf2.realtek.com.tw>;
 Thu, 4 Aug 2005 20:11:58 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2005080420095332-217928 ;
          Thu, 4 Aug 2005 20:09:53 +0800 
Message-ID: <00b401c598ed$6be49220$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	"Nigel Stephens" <nigel@mips.com>
Cc:	<linux-mips@linux-mips.org>
References: <009b01c598d5$2ede3e20$106215ac@realtek.com.tw> <42F1F81A.6020002@mips.com>
Subject: Re: Compiling uClibc with MIPS SDE6
Date:	Thu, 4 Aug 2005 20:09:53 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/04 =?Bog5?B?pFWkyCAwODowOTo1Mw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/04 =?Bog5?B?pFWkyCAwODowOTo1NQ==?=,
	Serialize complete at 2005/08/04 =?Bog5?B?pFWkyCAwODowOTo1NQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi Nigel,
I had already noticed this difference.
But why the application with debug information is not so big, whereas the
libraries are?
And the SDE 6 document says that using -gstabs flag can make it compile with
STABS debug format.
I replaced -g3 with -gstabs flag when compiling uClibc, but it cannot
compile successfully.

Regards,
Colin



----- Original Message ----- 
From: "Nigel Stephens" <nigel@mips.com>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Thursday, August 04, 2005 7:12 PM
Subject: Re: Compiling uClibc with MIPS SDE6


>
>
> colin wrote:
>
> >Hi there,
> >I encounter a problem when compiling uClibc with SDE6. If compiling with
> >debug information enabled, the output executable file of busybox is about
> >the same with the one that is compiled with SDE5, but uClibc libraries
are
> >over 10 times the size of the ones that are compiled with SDE5. I am
> >wondering if it is because GCC 3.4.4 of SDE6 has changed some parameters
> >setting?
> >
> >
> >
>
> SDE 6 uses Dwarf-2 debug data, whereas SDE 5 used Stabs. That may
> explain the difference.
>
> Nigel
>
> -- 
>                          Nigel Stephens         Mailto:nigel@mips.com
>     _    _ ____  ___     MIPS Technologies      Phone.: +44 1223 706200
>     |\  /|||___)(___     The Fruit Farm         Direct: +44 1223 706207
>     | \/ |||    ____)    Ely Road, Chittering   Fax...: +44 1223 706250
>      TECHNOLOGIES UK     Cambridge CB5 9PH      Cell..: +44 7976 686470
>                          England                http://www.mips.com
>
