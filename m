Received:  by oss.sgi.com id <S305166AbQBDRJS>;
	Fri, 4 Feb 2000 09:09:18 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12820 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQBDRJC>; Fri, 4 Feb 2000 09:09:02 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA00153; Thu, 3 Feb 2000 01:06:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA10653
	for linux-list;
	Thu, 3 Feb 2000 00:46:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA00686;
	Thu, 3 Feb 2000 00:46:46 -0800 (PST)
	mail_from (ulfc@engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id C72A610508C; Thu,  3 Feb 2000 00:45:20 -0800 (PST)
Date:   Thu, 3 Feb 2000 00:45:20 -0800 (PST)
From:   Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
To:     Eliseu Filho <efilho@ece.uci.edu>
Cc:     linux@cthulhu.engr.sgi.com, eliseu@cos.ufrj.br
Subject: Re: sources of 2.2.1-990526 (fwd)
In-Reply-To: <200002021930.LAA15243@liveoak.engr.sgi.com>
Message-ID: <Pine.LNX.4.10.10002030038180.29790-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> I tried to run the pre-compiled vmlinux-indy-2.2.1-990226 kernel
> on a SGI Indy (R4600 Rev. 00002020 processor with PROMLIB SGI ARCS 
> Ver. 1 Rev. 10) but it has not worked (the INIT process does not 
> start). I compiled its source locally, but it did not work either 
> (same problem). However, the pre-compiled vmlinux-indy-sound-2.2.1-990526  
> runs perfectly.
> 
> 1. What is the difference between vmlinux-indy-2.2.1-990226 and
> vmlinux-indy-sound-2.2.1-990526?

The vmlinux-indy-sound is a kernel that's compiled with sound support,
vmlinux-indy doesn't have sound support.  Of course the changes that have been
made to the CVS tree in between make the kernels different as well.

> 2. Where can I find the sources of vmlinux-indy-sound-2.2.1-990526?
> Or, is there any patch to upgrade from 2.2.1-990226 to it? I looked 
> at ftp.linux.sgi.com/pub/linux/mips/src/kernel/v2.2, but it is empty.
> Also, ftp.linux.sgi.com/pub/linux/mips/test contains only the
> sources of 2.2.1-990226.

I doubt there is a tar ball of the source for vmlinux-indy-sound-2.2.1-990526,
but you can however check out the CVS directory as it was 990526. Try
something like:

cvs -d ':pserver:cvs@oss.sgi.com:/home/pub/cvs' co -D 990526 linux

> I need the sources of a working kernel in order to introduce some
> instrumentation, necessary for my research. So, I really would 
> appreciate any help regarding this. Thanks in advance.

Good luck!

Ulf
