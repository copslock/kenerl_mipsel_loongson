Received:  by oss.sgi.com id <S305165AbQBDMhi>;
	Fri, 4 Feb 2000 04:37:38 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:17534 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQBDMhU>; Fri, 4 Feb 2000 04:37:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA06767; Wed, 2 Feb 2000 20:34:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA38623
	for linux-list;
	Wed, 2 Feb 2000 20:17:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA45127
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Feb 2000 20:16:58 -0800 (PST)
	mail_from (dubrawsk@nyquist.ece.uiuc.edu)
Received: from nyquist.ece.uiuc.edu (nyquist.ece.uiuc.edu [128.174.115.195]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA01521
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Feb 2000 20:16:57 -0800 (PST)
	mail_from (dubrawsk@nyquist.ece.uiuc.edu)
Received: from nyquist.ece.uiuc.edu (IDENT:dubrawsk@nyquist.ece.uiuc.edu [128.174.115.195])
	by nyquist.ece.uiuc.edu (8.9.3/8.9.3) with SMTP id WAA26225
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Feb 2000 22:52:30 -0600
Date:   Wed, 2 Feb 2000 22:52:30 -0600 (CST)
From:   Richard Dubrawsk <dubrawsk@nyquist.ece.uiuc.edu>
To:     linux@cthulhu.engr.sgi.com
Subject: Howto compile kernel on indy
Message-ID: <Pine.LNX.3.96.1000202224621.26215A-100000@nyquist.ece.uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello
I have tried repeatedly to compile both the 2.1.100 and 2.2.1 kernel trees
on an Indy with the hardhat installation.  I had to manually remove the
${CROSS_COMPILE} directives in the Makefile on the 2.2.1 tree since it was
defaulting to cross compiling otherwise.  My questions are:

1. Is it possible to natively compile a kernel on an indy running linux,
or must it be cross compiled on another machine?

2. What ever happenned to rdev.  According to the linux-utils package it
should have been installed in /usr/sbin, and it is noticably missing?

3. Where can I find updated ports of the basic tools like compiler and
libraries?  

>From the messages I receive in this list, I know people are working on
this project, and I would like to provide some input, but without some
basic tools that work it is difficult to start.  


Thank you 

Richard Dubrawski

University of Illinois 
Urbana-Champaign

(web page: http://www.students.uiuc.edu/~dubrawsk/)
