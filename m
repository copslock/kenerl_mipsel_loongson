Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA725904 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Sep 1997 20:05:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA25005 for linux-list; Mon, 22 Sep 1997 20:05:34 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA24998; Mon, 22 Sep 1997 20:05:31 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) id UAA09789; Mon, 22 Sep 1997 20:05:26 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199709230305.UAA09789@oz.engr.sgi.com>
Subject: Re: Task list --preliminary list
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Mon, 22 Sep 1997 20:05:26 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <199709230232.VAA16659@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Sep 22, 97 09:32:19 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

My personal favorites are a drudgery to wizards but an essential
necessity for most mortals:

[5] Verify that the latest source tree on Llinus compiles and boots
    (maybe automate this with a daily build that gets tested)
[4] Utility to boot Linux from IRIX (both locally and over net)
[3] Stable precompiled Indy kernel + root-contents on linus
[3] A working HOWTO for booting Linux on Indy

All the above even without having X :-)


:
:
:Here is a preliminary task list of things that should be done for a
:complete Linux/MIPS port, right now it includes by personal favorites
:and I am working on some of those bits, but some of the other can be
:done now, I have a copy of this at:
:
:	http://www.nuclecu.unam.mx/~miguel/mips-task-list.txt
:
:Priority: 
:
:[9]  Get more userland programs compiled in RPM form
:
:[9]  Merging the latest GNU libc releases.
:
:[9]  Get the X libraries compiled.
:
:[5]  Getting SGI mouse to work.
:
:[5]  Test the STREAMS implementation of the mouse.
:
:[6]  Figure why init is setting the sigprocmask to a value different
:     from 0.  This disables the debugger (SIGTRAP is disabled for
:     all child processes).
:
:[7]  Getting IRIX X server to accept connections.
:
:Please, send me additions to this list.
:Miguel.
:


-- 
Peace, Ariel
