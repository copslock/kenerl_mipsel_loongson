Received:  by oss.sgi.com id <S305160AbQANSCx>;
	Fri, 14 Jan 2000 10:02:53 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10760 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQANSCd>; Fri, 14 Jan 2000 10:02:33 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA05137; Fri, 14 Jan 2000 10:06:21 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA56381
	for linux-list;
	Fri, 14 Jan 2000 09:52:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA48898
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 09:52:26 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po3.glue.umd.edu (po3.glue.umd.edu [128.8.10.123]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08077
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 09:51:32 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po3.glue.umd.edu (8.9.3/8.9.3) with ESMTP id MAA25681
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 12:51:16 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id MAA21904
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 12:51:15 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id MAA21900
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 12:51:15 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Fri, 14 Jan 2000 12:51:14 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: SGI Prom Console
Message-ID: <Pine.GSO.4.21.0001141246460.21094-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I was trying to get the PROM console working so I wouldn't have to use
the hacked-together serial cord and a separate box to run SGI-linux on the
indigo2 [because I somehow doubt a GU1-EXTREME driver will suddenly
materialize].

In any case first I had to move CONFIG_SGI_PROM_CONSOLE in
./arch/mips/Config.in .... for some reason it was only given as an option
if you said you had a DECstation.

I finally got it so it would be compiled and linked into the kernel,
and for its symbols to show up in System.map, but I
can't figure out how to get it to output to the screen of the INDIGO2.  I
can read /dev/tty0 and get keyboard input to show up, but nothing
shows up if I do a cat > /dev/tty0.

Does anyone know exactly how to get it to work?

Thanks,
Vince

____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
