Received:  by oss.sgi.com id <S305256AbQCaUPs>;
	Fri, 31 Mar 2000 12:15:48 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:46945 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQCaUPf>;
	Fri, 31 Mar 2000 12:15:35 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA13723; Fri, 31 Mar 2000 12:10:53 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA31141; Fri, 31 Mar 2000 12:15:33 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA94745
	for linux-list;
	Fri, 31 Mar 2000 12:05:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA56058
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 12:05:29 -0800 (PST)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id MAA07242
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 12:05:19 -0800 (PST)
	mail_from (mikehill@hgeng.com)
Received: (qmail 30810 invoked from network); 31 Mar 2000 20:05:08 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 31 Mar 2000 20:05:08 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <HZ2QGY8J>; Fri, 31 Mar 2000 14:22:04 -0500
Message-ID: <E138DB347D10D3119C630008C79F5DEC2B9D6B@BART>
From:   Mike Hill <mikehill@hgeng.com>
To:     "'Florian Lohoff'" <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: RE: kernel for indigo2
Date:   Fri, 31 Mar 2000 14:21:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi Florian,

Is the 2.2 CVS branch still accessible?  I had a measure of success with
2.2.13 and 2.3.21 cross-compiled circa December.  I'd have to test them
again to tell you which, but with at least one of them, I can boot into a
working system.  The tricky bit is by the time it's finished booting, the
serial console output is lost; at this point I'd like to be able to telnet
in, but my setup.rpm (from hardhat) lacks the necessary securettys.

I can send you something if you need it.

HTH,

Mike


> -----Original Message-----
> From:	Florian Lohoff [SMTP:flo@rfc822.org]
> Sent:	March 31, 2000 12:45 PM
> To:	linux@cthulhu.engr.sgi.com
> Subject:	kernel for indigo2
> 
> Hi,
> i recently (a couple of days ago) got an Indigo2 Impact and i thought
> of beginning to bootstrap debian-mips (I already have >900 Package for
> debian-mipsel) but i cant even boot a kernel. The standard (and old)
> kernel on oss.sgi.com simple halt the machine after tftp boot - When
> building a kernel from the current CVS the machine
> crashes with a UTLB Miss as mentioned in the MIPS-FAQ as the 
> -N binutils bugs although there is no -N in the makefile.
> 
> Does anyone have a working kernel for the Indigo2 ?
> 
> Flo
> -- 
> Florian Lohoff		flo@rfc822.org
> +49-5241-470566
> "Technology is a constant battle between manufacturers producing bigger
> and
> more idiot-proof systems and nature producing bigger and better idiots."
