Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA84073 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 May 1999 14:55:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA64168
	for linux-list;
	Sat, 1 May 1999 14:52:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA85693
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 May 1999 14:52:46 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08052
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 May 1999 17:52:44 -0400 (EDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-4.uni-koblenz.de [141.26.131.4])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA24388
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 May 1999 23:52:41 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id XAA20068;
	Sat, 1 May 1999 23:52:26 +0200
Message-ID: <19990501235225.F8069@uni-koblenz.de>
Date: Sat, 1 May 1999 23:52:25 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: jcoffin@sv.usweb.com, linux@cthulhu.engr.sgi.com
Subject: Re: Yet closer
References: <199905011939.MAA23712@lil.brown-dog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199905011939.MAA23712@lil.brown-dog.org>; from jcoffin@sv.usweb.com on Sat, May 01, 1999 at 12:39:44PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, May 01, 1999 at 12:39:44PM -0700, jcoffin@sv.usweb.com wrote:

> I have SGI-Linux up on my headless Indy R5000, but I stupidly forgot to
> "change setup-1.9.1-2.noarch.rpm to add some securetty's so that you can
> log in over the network as root.", so I can't get in.  I tried all the
> recent kernels to see if one had a serial console, but no luck.
> 
> Is there a kernel around that has a serial console enabled so I can fix my
> situation or do I have to re-install?
> 
> Any suggestions as to other ways to get in and add securetty's?
> 
> In any event, what do I need to do to "change setup-1.9.1-2.noarch.rpm to
> add some securetty's"?

When booting the kernel pass the additional argument init=/bin/sh.  You'll
end up in a single user shell, can remount your root fs r/w and fix things.

The whole securetty thing has become a senseless annoyance since the
introduction of pseudo terminals and more fine grained mechanisms for
controlling access from networks.

  Ralf
