Received:  by oss.sgi.com id <S42278AbQEXU5Z>;
	Wed, 24 May 2000 13:57:25 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14389 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEXU45>; Wed, 24 May 2000 13:56:57 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA05426; Wed, 24 May 2000 15:01:36 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA25357; Wed, 24 May 2000 14:56:26 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA49215
	for linux-list;
	Wed, 24 May 2000 14:40:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA67440
	for <linux@engr.sgi.com>;
	Wed, 24 May 2000 14:40:38 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07567
	for <linux@engr.sgi.com>; Wed, 24 May 2000 14:40:35 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-8.uni-koblenz.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA17577;
	Wed, 24 May 2000 23:40:32 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403842AbQEXB1Q>;
	Wed, 24 May 2000 03:27:16 +0200
Date:   Wed, 24 May 2000 03:27:16 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: gdbserver for MIPS
Message-ID: <20000524032716.A4258@uni-koblenz.de>
References: <392B18D6.F4B11BED@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <392B18D6.F4B11BED@mvista.com>; from jsun@mvista.com on Tue, May 23, 2000 at 04:48:38PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, May 23, 2000 at 04:48:38PM -0700, Jun Sun wrote:

> I finally got gdbserver working on MIPS.  Who should I submit the
> patches to?

For the moment to me, I'll pu them into our sources.

> There are three patches/changes made :
> 
> 1. in kernel, arch/mips/ptrace.c - I did not generate patch file as my
> kernel version is probably outdated.  Basically if  CONFIG_CPU_NO_FPU is
> defined, return -1 for reading FPC_EIR register, instead of actually
> reading the hardware.
> 
> 2. a patch for gdbserver - see attached gdb-4.17-mips-gdbserver.patch
> 
> 3. I need an additional patch for my particular board to work.  I am not
> sure if they are generically applicable.  This patch overcomes a VERY
> SLOW getprotobyname() problem and sending a virtual FP register value
> problem.  See the second attached file.

Getprotobyname - please check the settings the protocols database in
/etc/nsswitch.conf.

> There is still one annoyance - stepping through a glibc function would
> generate a unknown address warning.  Other than that, everything seems
> to work fine - with my limited tests, that it.

I've seen those warning but don't know the cause.

  Ralf
