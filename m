Received:  by oss.sgi.com id <S305194AbQDBSw4>;
	Sun, 2 Apr 2000 11:52:56 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:56913 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDBSwi>;
	Sun, 2 Apr 2000 11:52:38 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA10461; Sun, 2 Apr 2000 11:47:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA52288; Sun, 2 Apr 2000 11:52:07 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA38576
	for linux-list;
	Sun, 2 Apr 2000 11:41:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA29233
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 Apr 2000 11:41:10 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01263
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 Apr 2000 11:41:10 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lithium (lithium.tucc.uab.edu [138.26.15.219])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id NAA30938;
	Sun, 2 Apr 2000 13:40:51 -0500
Date:   Sun, 2 Apr 2000 13:40:51 -0500 (CDT)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@lithium
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
In-Reply-To: <20000331194525.A20241@paradigm.rfc822.org>
Message-ID: <Pine.LNX.3.96.1000402133834.24412A-100000@lithium>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Fri, 31 Mar 2000, Florian Lohoff wrote:
> Hi,
> i recently (a couple of days ago) got an Indigo2 Impact and i thought
> of beginning to bootstrap debian-mips (I already have >900 Package for
> debian-mipsel) but i cant even boot a kernel. The standard (and old)
> kernel on oss.sgi.com simple halt the machine after tftp boot - When
> building a kernel from the current CVS the machine
> crashes with a UTLB Miss as mentioned in the MIPS-FAQ as the 
> -N binutils bugs although there is no -N in the makefile.
> 
> Does anyone have a working kernel for the Indigo2 ?

I have not gotten any of the recent 2.3 kernels to boot on my Indigo2.
The last one I know worked was 2.3.19.  I have not had a chance to sort
this out yet as I have been out of town for two weeks.  The 2.2 kernels do
work however.

-Andrew
