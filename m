Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA34831 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Nov 1998 14:16:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA16665
	for linux-list;
	Thu, 26 Nov 1998 14:15:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA95901;
	Thu, 26 Nov 1998 14:15:38 -0800 (PST)
	mail_from (miguel@metropolis.nuclecu.unam.mx)
Received: from metropolis.nuclecu.unam.mx (metropolis.nuclecu.unam.mx [132.248.29.92]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03747; Thu, 26 Nov 1998 14:15:36 -0800 (PST)
	mail_from (miguel@metropolis.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by metropolis.nuclecu.unam.mx (8.8.7/8.8.7) id QAA30111;
	Thu, 26 Nov 1998 16:17:43 -0600
Date: Thu, 26 Nov 1998 16:17:43 -0600
Message-Id: <199811262217.QAA30111@metropolis.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: ariel@cthulhu.engr.sgi.com
CC: galibert@pobox.com, linux@cthulhu.engr.sgi.com
In-reply-to: <199811252037.MAA37649@oz.engr.sgi.com> (ariel@oz.engr.sgi.com)
Subject: Re: help offered
X-Home: is where the cat is
References:  <199811252037.MAA37649@oz.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> 	  1) Which "serious" (i.e not 'getpid') system calls are
> 	     now reentrant ?

Very few and neither the file system layer nor the networking layer
have been properly fine-grain locked for this task to make sense. 

Linux is still far from competnig with IRIX and Solaris in this
field. 

Miguel.
