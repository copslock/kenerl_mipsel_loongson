Received:  by oss.sgi.com id <S305206AbQBEAjz>;
	Fri, 4 Feb 2000 16:39:55 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:7513 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305219AbQBDOwp>;
	Fri, 4 Feb 2000 06:52:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08242; Fri, 4 Feb 2000 06:52:42 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA18372
	for linux-list;
	Fri, 4 Feb 2000 06:43:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA64916
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 4 Feb 2000 06:43:03 -0800 (PST)
	mail_from (dubrawsk@valhalla.csl.uiuc.edu)
Received: from valhalla.csl.uiuc.edu (valhalla.csl.uiuc.edu [130.126.137.170]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA02846
	for <linux@cthulhu.engr.sgi.com>; Fri, 4 Feb 2000 06:43:02 -0800 (PST)
	mail_from (dubrawsk@valhalla.csl.uiuc.edu)
Received: from localhost (localhost [[UNIX: localhost]])
	by valhalla.csl.uiuc.edu (8.9.3/8.8.7) id IAA13172;
	Fri, 4 Feb 2000 08:43:31 -0600
From:   Richard Dubrawski <dubrawsk@valhalla.csl.uiuc.edu>
To:     Ralf Baechle <ralf@oss.sgi.com>,
        Richard Dubrawsk <dubrawsk@nyquist.ece.uiuc.edu>
Subject: Re: Howto compile kernel on indy
Date:   Fri, 4 Feb 2000 08:22:49 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
Cc:     linux@cthulhu.engr.sgi.com
References: <Pine.LNX.3.96.1000202224621.26215A-100000@nyquist.ece.uiuc.edu> <20000203232102.D2999@uni-koblenz.de>
In-Reply-To: <20000203232102.D2999@uni-koblenz.de>
MIME-Version: 1.0
Message-Id: <00020408433103.11197@valhalla.csl.uiuc.edu>
Content-Transfer-Encoding: 8bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Thanks for the information.  regarding the use of command line arguments then,
I really want to make this machine boot unattended.  Is it possible to have the
indy boot rom automatically execute the "vmlinux root=/dev/sda3" line, and if
so how do I make it do that?

Thank you


On Thu, 03 Feb 2000, Ralf Baechle wrote:
> On Wed, Feb 02, 2000 at 10:52:30PM -0600, Richard Dubrawsk wrote:
> 
> > I have tried repeatedly to compile both the 2.1.100 and 2.2.1 kernel trees
> > on an Indy with the hardhat installation.  I had to manually remove the
> > ${CROSS_COMPILE} directives in the Makefile on the 2.2.1 tree since it was
> > defaulting to cross compiling otherwise.  My questions are:
> 
> Cross compilation is a configuration option near the end of the
> configuration dialog.  So no hacking of makefiles required.
> 
> > 1. Is it possible to natively compile a kernel on an indy running linux,
> > or must it be cross compiled on another machine?
> 
> It is possible, however most of us Indy hackers consider it inconvenient
> to reboot the machine on which we're doing the development.  This is the
> core reason why I almost never do native kernel builds.
> 
> > 2. What ever happenned to rdev.  According to the linux-utils package it
> > should have been installed in /usr/sbin, and it is noticably missing?
> 
> Rdev is only required on i386.  On the Indy use command line arguments at
> the firmware like ``vmlinux root=/dev/sdc1''.
> 
> > 3. Where can I find updated ports of the basic tools like compiler and
> > libraries?  
> 
> Updates versions are on oss.sgi.com.
> 
>   Ralf
-- 
Richard Dubrawski

University of Illinois 
Urbana-Champaign

(web page: http://www.students.uiuc.edu/~dubrawsk/)
