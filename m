Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA22818 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Mar 1998 09:46:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id JAA618235 for linux-list; Wed, 4 Mar 1998 09:45:50 -0800 (PST)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA602035; Wed, 4 Mar 1998 09:45:46 -0800 (PST)
Received: (from ariel@localhost) by oz.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) id JAA54870; Wed, 4 Mar 1998 09:45:41 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199803041745.JAA54870@oz.engr.sgi.com>
Subject: Re: CVS notifications
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Wed, 4 Mar 1998 09:45:40 -0800 (PST)
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199803041737.LAA28458@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Mar 4, 98 11:37:02 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:
:> Did anybody change the mail setup on linus?  I don't receive any mail
:> notifications for my CVS commits anymore.
:
:Neither do I.
:
This seems to be a temporary problem with our mail server.
As the owner of the list I've been getting all the bounces.

The reason is probably related to the fact we are starting to
do more aggressive testing of IRIX 6.5 by putting it on all
the critical campus servers:

	% rsh guest@relay uname -a
	IRIX64 cthulhu 6.5-BETA-1274425944 02281110 IP19
	---------------^^^^^^^^^^^^^^^^^^^

No worries, this is going to get fixed.

-- 
Peace, Ariel
