Received:  by oss.sgi.com id <S305256AbQCaWju>;
	Fri, 31 Mar 2000 14:39:50 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:43275 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQCaWjS>;
	Fri, 31 Mar 2000 14:39:18 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA03125; Fri, 31 Mar 2000 14:34:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA42352
	for linux-list;
	Fri, 31 Mar 2000 14:23:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA42464
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 14:23:45 -0800 (PST)
	mail_from (richardh@penguin.nl)
Received: from smtpf.casema.net (smtpf.casema.net [195.96.96.173]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id OAA02264
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 14:23:43 -0800 (PST)
	mail_from (richardh@penguin.nl)
Received: (qmail 4735 invoked by uid 0); 31 Mar 2000 22:23:33 -0000
Received: from unknown (HELO penguin.nl) (195.96.113.57)
  by smtpf.casema.net with SMTP; 31 Mar 2000 22:23:33 -0000
Message-ID: <38E525B4.3C45840B@penguin.nl>
Date:   Sat, 01 Apr 2000 00:24:52 +0200
From:   Richard <richardh@penguin.nl>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     Mike Hill <mikehill@hgeng.com>, linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
References: <E138DB347D10D3119C630008C79F5DEC2B9D6B@BART> <20000331223816.A25241@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Florian Lohoff wrote:

> On Fri, Mar 31, 2000 at 02:21:56PM -0500, Mike Hill wrote:
> > Hi Florian,
> >
> > Is the 2.2 CVS branch still accessible?  I had a measure of success with
> > 2.2.13 and 2.3.21 cross-compiled circa December.  I'd have to test them
> > again to tell you which, but with at least one of them, I can boot into a
> > working system.  The tricky bit is by the time it's finished booting, the
> > serial console output is lost; at this point I'd like to be able to telnet
> > in, but my setup.rpm (from hardhat) lacks the necessary securettys.
> >
> > I can send you something if you need it.
>

I changed the setup*-noarch.rpm once for installing on a challenge S, it should
be on the sgi.com archive somewhere.

Richard
