Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA135586; Thu, 31 Jul 1997 12:17:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA21405 for linux-list; Thu, 31 Jul 1997 12:13:39 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA20877; Thu, 31 Jul 1997 12:10:48 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA17852; Thu, 31 Jul 1997 12:09:26 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199707311909.MAA17852@oz.engr.sgi.com>
Subject: Re: An update...
To: oliver@aec.at (Oliver Frommel)
Date: Thu, 31 Jul 1997 12:09:26 -0700 (PDT)
Cc: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.91.970731203002.4976C-100000@web.aec.at> from "Oliver Frommel" at Jul 31, 97 08:31:26 pm
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:On Thu, 31 Jul 1997, Miguel de Icaza wrote:
:
:> 
:> > - Is there anyway to get rid of that jazzy sound startup thing?  Sure, it
:> > puts all the Mac's in my office to shame, but after about the twentieth
:> > time it's a little bothering...
:> 
:>
:
:in the boot monitor enter "setenv volume 0"
:
:oliver
: 
It can also be done from the shell with "nvram volume 10"
or a similar low value (man nvram).

-- 
Peace, Ariel
