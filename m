Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA05343 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 17:13:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA08885
	for linux-list;
	Wed, 10 Feb 1999 17:12:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA09891
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Feb 1999 17:12:50 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08930
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 17:12:49 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA29206
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Feb 1999 02:12:44 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id MAA00531;
	Wed, 10 Feb 1999 12:17:30 +0100
Message-ID: <19990210121730.A528@uni-koblenz.de>
Date: Wed, 10 Feb 1999 12:17:30 +0100
From: ralf@uni-koblenz.de
To: Radim Uchac <uchac@pvt.net>, linux@cthulhu.engr.sgi.com
Subject: Re: mysql-3.22.16a-gamma
References: <36C13DF3.9F9F45AE@pvt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36C13DF3.9F9F45AE@pvt.net>; from Radim Uchac on Wed, Feb 10, 1999 at 09:06:11AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 10, 1999 at 09:06:11AM +0100, Radim Uchac wrote:

> I'm trying to compile mysql-3.22.16a-gamma but when I run script
> ./configure
> I obtain:

[...]

> configure:4344: gcc -o conftest -O6   -DDBUG_OFF   -rdynamic conftest.c
> -lnsl -lm   -lcrypt  -lpthread 1>&5
> /usr/lib/libpthread.so: undefined reference to `__libc_accept'
> /usr/lib/libpthread.so: undefined reference to `__libc_send'
> /usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
> /usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
> /usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
> /usr/lib/libpthread.so: undefined reference to `__libc_recv'
> /usr/lib/libpthread.so: undefined reference to `__libc_sendto'
> /usr/lib/libpthread.so: undefined reference to `__libc_connect'

This bug is fixed in more recent libc versions as you have installed.

  Ralf
