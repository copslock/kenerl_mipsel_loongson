Received:  by oss.sgi.com id <S305180AbQDUVpd>;
	Fri, 21 Apr 2000 14:45:33 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26667 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305179AbQDUVpS>; Fri, 21 Apr 2000 14:45:18 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA00790; Fri, 21 Apr 2000 14:49:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA67349; Fri, 21 Apr 2000 14:44:47 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA36036
	for linux-list;
	Fri, 21 Apr 2000 14:31:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA88812
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Apr 2000 14:31:58 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405412AbQDUV2H>;
	Fri, 21 Apr 2000 14:28:07 -0700
Date:   Fri, 21 Apr 2000 14:28:07 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: bug in get_wchan ...
Message-ID: <20000421142807.B763@uni-koblenz.de>
References: <20000420182522.B7304@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000420182522.B7304@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Apr 20, 2000 at 06:25:22PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 20, 2000 at 06:25:22PM +0200, Florian Lohoff wrote:

> What does "thread_saved_pc(&p->thread);" return ? Does it really
> return the exact address of the schedule functions as assumed in
> 205-214 ?

It's supposed to return the address at which a currently non-executing
process will continue it's execution.

> Most other architectures search the stack page for the calling function
> but it seems their asmlinkage is more strict in the means of 
> location of the return address on the stack.

Yep, unwinding MIPS stackframes is not possible for the general case unless
you use debug information.  We don't want that, so have to use an
alternative solution that is fairly fragile and you're observing yet another
case of this.

Fixing ...

  Ralf
