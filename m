Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA142194 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Oct 1997 17:11:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA29862 for linux-list; Wed, 22 Oct 1997 17:10:37 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA29843; Wed, 22 Oct 1997 17:10:34 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) id RAA272545; Wed, 22 Oct 1997 17:10:33 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199710230010.RAA272545@oz.engr.sgi.com>
Subject: Re: Step by step of my experience
To: mgix@nothingreal.com (Emmanuel Mogenet)
Date: Wed, 22 Oct 1997 17:10:33 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <344E7DB2.167E@nothingreal.com> from "Emmanuel Mogenet" at Oct 22, 97 03:26:58 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Emmanuel,

Thanks for the report.

:
:        EFS: <6> attempt to access beyond end of device
:        08:21 rw=0 want=1190802192, limit=4191574
:
:Conclusion: Wait for Ralf to finish the EFS driver !
:This is the exact bug he was talking about.
:
Actually, it is Mike Shaver, we talked about this one pretty
recently, he is pretty busy but when he find some time to fix
this it would make things much simpler.

Hope someone would be able to answer the sash booting question.
-- 
Peace, Ariel
