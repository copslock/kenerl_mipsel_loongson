Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA1192801 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Oct 1997 10:41:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA13080 for linux-list; Thu, 2 Oct 1997 10:41:03 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA13073; Thu, 2 Oct 1997 10:41:01 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) id KAA02997; Thu, 2 Oct 1997 10:41:01 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199710021741.KAA02997@oz.engr.sgi.com>
Subject: Re: Indy Auto power
To: LetherGlov@aol.com
Date: Thu, 2 Oct 1997 10:41:01 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <971001203242_614253298@emout20.mail.aol.com> from "LetherGlov@aol.com" at Oct 1, 97 09:02:38 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:Does anyone know what chip provides the power features for:"wakeupat" and
:"shutdown -p"? The kernel doesn't yet seem to support these
:features................
:
:Robbie Stone
:
Robbie,

The current SGI/Linux kenel doesn't support many more features
of the Indy hardware (e.g. sound, video).

We got management permission to give the unpublished internal Indy
hardware specs to a limited number of developers.  I think there
are four or five copies out there and that the needed information
is there too.  It can also be done by tracing reverse-engineering etc.

Of course, we'll be glad to see it supported and specific questions
would be gladly answered provided someone on the list knows the answer.

-- 
Peace, Ariel
