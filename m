Received:  by oss.sgi.com id <S305163AbPKBX6s>;
	Tue, 2 Nov 1999 15:58:48 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36686 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305162AbPKBX6c>; Tue, 2 Nov 1999 15:58:32 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA02724
	for <linuxmips@oss.sgi.com>; Tue, 2 Nov 1999 16:04:02 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA91654
	for linux-list;
	Tue, 2 Nov 1999 15:50:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [150.166.49.50])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA70717;
	Tue, 2 Nov 1999 15:50:32 -0800 (PST)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: (from ulfc@localhost)
	by calypso.engr.sgi.com (8.9.3/8.8.7) id PAA18465;
	Tue, 2 Nov 1999 15:49:19 -0800
Date:   Tue, 2 Nov 1999 15:49:19 -0800
From:   Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: MIPS CVS archive
Message-ID: <19991102154919.E15879@engr.sgi.com>
References: <19991102.23382000@jharrell_dt.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19991102.23382000@jharrell_dt.>; from Jeff Harrell on Tue, Nov 02, 1999 at 11:38:20PM +0000
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Nov 02, 1999 at 11:38:20PM +0000, Jeff Harrell wrote:
> I am trying to locate the command that allows me login to the CVS 
> repository for oss.sgi.com.  I needed to download a recent MIPS kernel
> for a project that I am working on.  Thanks in advance :)  

The sequence of commands are the following:

     cvs -d :pserver:cvs@oss.sgi.com:/cvs login
     (Only needed the first time you use anonymous CVS, the password is "cvs")
     cvs -d :pserver:cvs@oss.sgi.com:/cvs co linux

There is more information available in the MIPS-HOWTO.

Ulf
