Received:  by oss.sgi.com id <S305260AbQDAMgO>;
	Sat, 1 Apr 2000 04:36:14 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:25142 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQDAMgF>;
	Sat, 1 Apr 2000 04:36:05 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA25895; Sat, 1 Apr 2000 04:31:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA90527; Sat, 1 Apr 2000 04:36:04 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA36370
	for linux-list;
	Sat, 1 Apr 2000 04:20:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA31273
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 04:20:22 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA09426
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 04:20:19 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 255B57D9; Sat,  1 Apr 2000 14:20:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4EE698FC3; Sat,  1 Apr 2000 14:04:27 +0200 (CEST)
Date:   Sat, 1 Apr 2000 14:04:27 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: SNI RW320 (aka SGI Indigo?)
Message-ID: <20000401140427.E3970@paradigm.rfc822.org>
References: <20000331232756.B10595@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000331232756.B10595@lug-owl.de>; from Jan-Benedict Glaw on Fri, Mar 31, 2000 at 11:27:56PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 11:27:56PM +0200, Jan-Benedict Glaw wrote:
> Hi!
> 
> I'm doing my very first steps with MIPS hardware... Well, I got $Subject
> with IRIX5.2 installed (-> just right now, I have root access (there was
> an Objectserver installed;) as well as root access). It ships 48MB RAM,
> 520MB+1.2GB HDD and a LG1 graphics adaptor which has too high resolutions
> for my monitor;)
> 
> As I got no documentation, how can I boot that machine via tftp?

In the bootprom  

boot bootp():<kernelname> <kernelparameters>

The HardHat documentation shows this ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
