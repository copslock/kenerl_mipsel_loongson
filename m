Received:  by oss.sgi.com id <S305167AbQCYGq1>;
	Fri, 24 Mar 2000 22:46:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60217 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQCYGqQ>; Fri, 24 Mar 2000 22:46:16 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id WAA09277; Fri, 24 Mar 2000 22:49:49 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA10545
	for linux-list;
	Fri, 24 Mar 2000 22:37:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA10625
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Mar 2000 22:37:00 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA05141
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Mar 2000 22:36:58 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D0EA47FF; Sat, 25 Mar 2000 07:36:55 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7A3588FC3; Sat, 25 Mar 2000 07:30:09 +0100 (CET)
Date:   Sat, 25 Mar 2000 07:30:09 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.99pre2/ still login problems
Message-ID: <20000325073009.B3060@paradigm.rfc822.org>
References: <20000324134315.A6208@paradigm.rfc822.org> <20000325015855.D19725@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000325015855.D19725@uni-koblenz.de>; from Ralf Baechle on Sat, Mar 25, 2000 at 01:58:55AM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Mar 25, 2000 at 01:58:55AM +0100, Ralf Baechle wrote:
> On Fri, Mar 24, 2000 at 01:43:15PM +0100, Florian Lohoff wrote:
> 
> > Hi,
> > still the same problems - since the mid 2.3.4x kernels i cant
> > log into my decstation 5000 - It seems the pseudo tty code
> > is non functional.
> > 
> > An telnet or "ssh" causes the connection to close if requesting a tty.
> 
> Can anybody provide an strace / tcpdump of the session?

tcpdump is uninteresting because the session just gets dropped 
as one can see in my ssh output. - Same applies to telnet and rsh.

Hmmm - strace - I think i have to get the cobalt strace 3.2 as current
4.0 straces dont build

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
