Received:  by oss.sgi.com id <S305160AbQDURID>;
	Fri, 21 Apr 2000 10:08:03 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:18701 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQDURHk>; Fri, 21 Apr 2000 10:07:40 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA05121; Fri, 21 Apr 2000 10:11:43 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA69180
	for linux-list;
	Fri, 21 Apr 2000 09:58:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA47517
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Apr 2000 09:58:55 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405412AbQDUQzH>;
	Fri, 21 Apr 2000 09:55:07 -0700
Date:   Fri, 21 Apr 2000 09:55:06 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>,
        Linux/MIPS fnet <linux-mips@fnet.fr>
Subject: Re: More oddities in traps.c
Message-ID: <20000421095506.A763@uni-koblenz.de>
References: <006401bfab6d$2a6cedb0$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <006401bfab6d$2a6cedb0$0ceca8c0@satanas.mips.com>; from kevink@mips.com on Fri, Apr 21, 2000 at 10:39:51AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 10:39:51AM +0200, Kevin D. Kissell wrote:

> So while we're on the topic of cruft in arch/mips/kernel/traps.c,
> does anyone know why the cache error exception vector is
> overwritten with a copy of the TLB miss handler as part of
> vector setup on R4xxx and R5xxx CPUs?

{\cruft[stupid_answer] Cache errors are that rare that nobody complained so
far ...}

Fixing ...

  Ralf
