Received:  by oss.sgi.com id <S305243AbQCaSQW>;
	Fri, 31 Mar 2000 10:16:22 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:47954 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305239AbQCaSQM>; Fri, 31 Mar 2000 10:16:12 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA03499; Fri, 31 Mar 2000 10:19:47 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA86660
	for linux-list;
	Fri, 31 Mar 2000 10:02:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA13009
	for <linux@engr.sgi.com>;
	Fri, 31 Mar 2000 10:02:42 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00182
	for <linux@engr.sgi.com>; Fri, 31 Mar 2000 10:02:40 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C0E1C7D9; Fri, 31 Mar 2000 20:02:40 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id F3FD68FC3; Fri, 31 Mar 2000 19:53:03 +0200 (CEST)
Date:   Fri, 31 Mar 2000 19:53:03 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@uni-koblenz.de>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, aj@suse.de
Subject: Re: pause()
Message-ID: <20000331195303.B20241@paradigm.rfc822.org>
References: <20000331151555.A5911@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000331151555.A5911@uni-koblenz.de>; from Ralf Baechle on Fri, Mar 31, 2000 at 03:15:55PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 03:15:55PM +0200, Ralf Baechle wrote:
> I just found another brainfart in the libc / kernel interface.  In the
> believe libc wouldn't use the pause(2) syscall any longer I removed it.
> This makes a number of programs like screen burn all CPU they can get.
> I'll provide two fixes, one to libc and a second for the kernel and
> either one will be sufficient.

Could this also be the cause of "top" refreshing the screen as fast
as it can ? I noticed that when i rebuild the debian procps package
and tried top ... It then consumes the cpu it gets ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
