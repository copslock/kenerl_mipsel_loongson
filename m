Received:  by oss.sgi.com id <S305195AbQDBKFx>;
	Sun, 2 Apr 2000 03:05:53 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:35886 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDBKFe>; Sun, 2 Apr 2000 03:05:34 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA06091; Sun, 2 Apr 2000 03:09:16 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA84593
	for linux-list;
	Sat, 1 Apr 2000 16:38:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA89701
	for <linux@engr.sgi.com>;
	Sat, 1 Apr 2000 16:38:05 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA25569
	for <linux@engr.sgi.com>; Sat, 1 Apr 2000 16:33:25 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-6.uni-koblenz.de (cacc-6.uni-koblenz.de [141.26.131.6])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA00883;
	Sun, 2 Apr 2000 02:34:47 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407778AbQDBAeZ>;
	Sun, 2 Apr 2000 02:34:25 +0200
Date:   Sun, 2 Apr 2000 02:34:25 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, aj@suse.de
Subject: Re: pause()
Message-ID: <20000402023425.B829@uni-koblenz.de>
References: <20000331151555.A5911@uni-koblenz.de> <20000331195303.B20241@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000331195303.B20241@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Mar 31, 2000 at 07:53:03PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 07:53:03PM +0200, Florian Lohoff wrote:

> On Fri, Mar 31, 2000 at 03:15:55PM +0200, Ralf Baechle wrote:
> > I just found another brainfart in the libc / kernel interface.  In the
> > believe libc wouldn't use the pause(2) syscall any longer I removed it.
> > This makes a number of programs like screen burn all CPU they can get.
> > I'll provide two fixes, one to libc and a second for the kernel and
> > either one will be sufficient.
> 
> Could this also be the cause of "top" refreshing the screen as fast
> as it can ? I noticed that when i rebuild the debian procps package
> and tried top ... It then consumes the cpu it gets ...

I haven't tried myself but sounds very probable.  The sympthon is that
an strace will show large numbers of pause(2) syscalls which all return
with -ENOSYS as error.

  Ralf
