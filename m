Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA16414; Fri, 30 May 1997 10:38:08 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA16524 for linux-list; Fri, 30 May 1997 10:37:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA16500 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 10:37:53 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA10384
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 10:37:49 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id TAA14229; Fri, 30 May 1997 19:34:02 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705301734.TAA14229@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA19008; Fri, 30 May 1997 19:34:01 +0200
Subject: Re: ah...
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 30 May 1997 19:34:01 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199705301517.LAA13588@neon.ingenia.ca> from "Mike Shaver" at May 30, 97 11:17:00 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I think something's a bit wonky here.
> 
>   if ((fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
>     perror("nothingserv: socket");
>     return -1;
>   }
> # ./bind-indy 2000
> nothingserv: socket: Socket type not supported
> #

Hurz...  Looks like you either you disabled TCI/IP networking or libc
and the kernel use different constants for the arguments of socket(2).

  Ralf
