Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA82485 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Jun 1998 17:26:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA41945
	for linux-list;
	Fri, 5 Jun 1998 17:25:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA40577;
	Fri, 5 Jun 1998 17:25:04 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id RAA47789; Fri, 5 Jun 1998 17:25:03 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199806060025.RAA47789@oz.engr.sgi.com>
Subject: Re: Some questions...
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 5 Jun 1998 17:25:03 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980605183028.29950C-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jun 5, 98 06:34:01 pm
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
:What are the implications of us redistributing the header files from Irix?
:In particular, there are some header files for newport graphics that are
:needed.
:

My personal reasoning for "it is not really a problem"
stems from the following facts:

	1) If you have the Indy (hardware) you already have
	   the license for IRIX (for your own use)

	2) Unlike in earlier days where you had so buy a "developer's CD"
	   to get headers"   SGI is now including header files standard
	   with the system (since 6.2 at least).

	3) Newport graphics is ancient technology (about 6 years old)

Having said that, all these headers usually have this on top:
/**************************************************************************
 *                                                                        *
 *               Copyright (C) 1996 Silicon Graphics, Inc.                *
 *                                                                        *
 *  These coded instructions, statements, and computer programs  contain  *
 *  unpublished  proprietary  information of Silicon Graphics, Inc., and  *
 *  are protected by Federal copyright law.  They  may  not be disclosed  *
 *  to  third  parties  or copied or duplicated in any form, in whole or  *
 *  in part, without the prior written consent of Silicon Graphics, Inc.  *
 *                                                                        *
 **************************************************************************/

So clearly we should get permission from the "powers that be" and
someone needs to ask the legal people :-)   I just don't know
what entity can approve this.  If anyone knows and we can get
a brief "approved" from some director, it would be nice.

Any volunteers ?

-- 
Peace, Ariel
