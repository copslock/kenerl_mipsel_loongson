Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA50892 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 11:58:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA31089
	for linux-list;
	Wed, 25 Nov 1998 11:57:13 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from machine.engr.sgi.com (machine.engr.sgi.com [150.166.75.58])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA38264;
	Wed, 25 Nov 1998 11:57:11 -0800 (PST)
	mail_from (jes@machine.engr.sgi.com)
Received: (from jes@localhost) by machine.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) id LAA24028; Wed, 25 Nov 1998 11:57:10 -0800 (PST)
From: jes@machine.engr.sgi.com (John E. Schimmel)
Message-Id: <199811251957.LAA24028@machine.engr.sgi.com>
Subject: Re: help offered
To: galibert@pobox.com (Olivier Galibert)
Date: Wed, 25 Nov 1998 11:57:10 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19981125204900.A4692@loria.fr> from "Olivier Galibert" at Nov 25, 98 08:49:00 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> The  limit on  x86 is  2GB.   To  be  fair,  said  terabyte  files and
> filesystems  are  connected  to systems   with  a 64bits architecture.
> Afaik, linux on alpha handles terabytes files.
> 
>   OG.
> 

We support >2GB on 32 bit systems, and added lseek64() and friends
before we had 64 bit size_t/off_t.

--------------------------------------------------------------
John E. Schimmel                       Email:    jes@sgi.com         
KD6MNW				       Voice:    (650)933-4116
Silicon Graphics Inc.                  Fax:      (650)933-0513
http://reality.sgi.com/jes             Cellular: (209)631-0896
--------------------------------------------------------------
