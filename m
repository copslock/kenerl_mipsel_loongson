Received:  by oss.sgi.com id <S305166AbQCYBO0>;
	Fri, 24 Mar 2000 17:14:26 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:61710 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQCYBOK>;
	Fri, 24 Mar 2000 17:14:10 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA06105; Fri, 24 Mar 2000 17:09:30 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA34255; Fri, 24 Mar 2000 17:13:39 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA65654
	for linux-list;
	Fri, 24 Mar 2000 16:59:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA65577
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Mar 2000 16:59:32 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09932
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Mar 2000 16:59:30 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-29.uni-koblenz.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA14373;
	Sat, 25 Mar 2000 01:59:29 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQCYA6z>;
	Sat, 25 Mar 2000 01:58:55 +0100
Date:   Sat, 25 Mar 2000 01:58:55 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.99pre2/ still login problems
Message-ID: <20000325015855.D19725@uni-koblenz.de>
References: <20000324134315.A6208@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000324134315.A6208@paradigm.rfc822.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 24, 2000 at 01:43:15PM +0100, Florian Lohoff wrote:

> Hi,
> still the same problems - since the mid 2.3.4x kernels i cant
> log into my decstation 5000 - It seems the pseudo tty code
> is non functional.
> 
> An telnet or "ssh" causes the connection to close if requesting a tty.

Can anybody provide an strace / tcpdump of the session?

  Ralf
