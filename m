Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 02:57:02 +0000 (GMT)
Received: from zok.SGI.COM ([204.94.215.101]:52196 "EHLO zok.sgi.com")
	by linux-mips.org with ESMTP id <S8225260AbSLLC5B>;
	Thu, 12 Dec 2002 02:57:01 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id gBC21RKp022782;
	Wed, 11 Dec 2002 18:01:31 -0800
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA25081; Thu, 12 Dec 2002 13:56:46 +1100
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id D22FD300087; Thu, 12 Dec 2002 13:56:43 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 48E4B85; Thu, 12 Dec 2002 13:56:43 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: IDE module problem 
In-reply-to: Your message of "Wed, 11 Dec 2002 18:20:30 BST."
             <Pine.GSO.3.96.1021211181032.22157L-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Dec 2002 13:56:37 +1100
Message-ID: <25550.1039661797@kao2.melbourne.sgi.com>
Return-Path: <kaos@ocs.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@ocs.com.au
Precedence: bulk
X-list: linux-mips

On Wed, 11 Dec 2002 18:20:30 +0100 (MET), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
>On Wed, 11 Dec 2002, Jun Sun wrote:
>
>> > > This is because arch/mips/lib/Makefile says:
>> > > 
>> > > obj-$(CONFIG_IDE)               += ide-std.o ide-no.o
>> > [...]
>> > > 3) use some smart trick in Makefile so that we include those
>> > > two files only if CONFIG_IDE is 'y' or 'm'.  (How?)
>> > 
>> >  obj-$(CONFIG_IDE_MODULE)
>> 
>> This does not work.  Apparently, CONFIG_IDE_MODULE is not created 
>> for makefile part.
>
> Indeed -- my fault.  Variables such as $(CONFIG_IDE) are four-state and
>for the module case they are simply set to "m".  But then you can use
>"ifeq ($(CONFIG_IDE),m)".  Another approach is to invent an additional
>variable automatically set to "y" whenever CONFIG_IDE is enabled. 

obj-$(subst m,y,$(CONFIG_IDE)) += ide-std.o ide-no.o

ide-std.o ide-no.o are built in if CONFIG_IDE is m or y.
