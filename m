Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA93252 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 11:33:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19035
	for linux-list;
	Thu, 27 May 1999 11:32:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from daddyo.engr.sgi.com (daddyo.engr.sgi.com [150.166.40.89])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA32560
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 May 1999 11:32:39 -0700 (PDT)
	mail_from (marker@daddyo.engr.sgi.com)
Received: (from marker@localhost) by daddyo.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id LAA53444; Thu, 27 May 1999 11:32:38 -0700 (PDT)
From: marker@daddyo.engr.sgi.com (Charles Marker)
Message-Id: <199905271832.LAA53444@daddyo.engr.sgi.com>
Subject: Re: Lxrun: Linux Applications for Solaris
To: eak@sgi.com
Date: Thu, 27 May 1999 11:32:38 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com, marker@daddyo.engr.sgi.com (Charles Marker)
In-Reply-To: <374D8D5A.2143F76A@detroit.sgi.com> from "Eric Kimminau" at May 27, 99 02:22:18 pm
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> Anyone thought of porting this to IRIX?
> 
> http://www.sun.com/software/linux/lxrun/
> 

This could be useful for IRIX, but only to enable executing MIPS based
Linux binaries.  Lxrun is not an emulator, so you need to have
underlying Intel hardware in order to run Intel Linux binaries.  Sun
is providing this for Intel systems running Solaris where it could be
useful, but I don't know how useful this would be for SPARC based
systems (depending on the number of SPARC based Linux applications).

					Charles
