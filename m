Received:  by oss.sgi.com id <S305244AbQCaSdC>;
	Fri, 31 Mar 2000 10:33:02 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:6485 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305239AbQCaScx>; Fri, 31 Mar 2000 10:32:53 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA08337; Fri, 31 Mar 2000 10:36:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA20095
	for linux-list;
	Fri, 31 Mar 2000 10:20:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA25409
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 10:20:13 -0800 (PST)
	mail_from (richardh@penguin.nl)
Received: from smtpf.casema.net (smtpf.casema.net [195.96.96.173]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id KAA00529
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 10:20:08 -0800 (PST)
	mail_from (richardh@penguin.nl)
Received: (qmail 29780 invoked by uid 0); 31 Mar 2000 18:19:58 -0000
Received: from unknown (HELO penguin.nl) (195.96.116.126)
  by smtpf.casema.net with SMTP; 31 Mar 2000 18:19:58 -0000
Message-ID: <38E4ECA1.2362D2B@penguin.nl>
Date:   Fri, 31 Mar 2000 20:21:21 +0200
From:   Richard <richardh@penguin.nl>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
References: <20000331194525.A20241@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Florian Lohoff wrote:

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

I had this very same problem with the CVS tree on my indy r5k. If anyone knows
what the problem is, or when it will be fixed, i'd love to now, because
development is on a halt here right now.

Richard
