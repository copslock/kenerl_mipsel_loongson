Received:  by oss.sgi.com id <S305169AbQB1Nmp>;
	Mon, 28 Feb 2000 05:42:45 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32880 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQB1NmY>; Mon, 28 Feb 2000 05:42:24 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA03326; Mon, 28 Feb 2000 05:45:29 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA88933
	for linux-list;
	Mon, 28 Feb 2000 05:27:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA78186
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Feb 2000 05:27:26 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA05033
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Feb 2000 05:27:34 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 12PQCX-0001uL-00; Mon, 28 Feb 2000 13:27:05 +0000
Subject: Re: Kernel/User Memory Access and Original Sin
To:     kevink@mips.com (Kevin D. Kissell)
Date:   Mon, 28 Feb 2000 13:27:02 +0000 (GMT)
Cc:     linux-mips@fnet.fr (Linux/MIPS fnet),
        linux-porters@algor.co.uk (Linux/MIPS algor),
        linux@cthulhu.engr.sgi.com (Linux SGI)
In-Reply-To: <010101bf81e6$9c546120$0ceca8c0@satanas.mips.com> from "Kevin D. Kissell" at Feb 28, 2000 01:23:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E12PQCX-0001uL-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Linux, as written for the x86, goes very heavily for inlining.
> Rather than call specially protected copyin/copyout sorts
> of routines for manipulating user memory, Linux uses inline
> macros (copy_from_user/copy_to_user, etc.) that depend on

Its up to the port how it is done. Most of them are non inline for
x86 for example.

> __access_ok routine, but it is much more heavyweight
> than the old heuristic.  Not only does it need to check the
> virtual address against the process' VMAs, but it needs

Its broken if it does that. The process VMA may change on an SMP box or
during fault handling sleeps.

__access_ok has one purpose. To verify the address range given is entirely
sensible to feed to __copy_*_user. If you have to do handling the complex
way (eg if your cpu design requires it) then __access_ok can just return 1
and the __copy_*_user - inline or out of line - can do all the work.
