Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA49674 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Mar 1999 01:21:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA75820
	for linux-list;
	Wed, 10 Mar 1999 01:20:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA61446
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Mar 1999 01:20:48 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA01832
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Mar 1999 01:20:41 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.0/8.9.0/WIREfire-1.2) with SMTP id KAA19668;
	Wed, 10 Mar 1999 10:20:13 +0100 (MET)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA27758; Wed, 10 Mar 99 10:20:19 +0100
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id KAA01213; Wed, 10 Mar 1999 10:20:19 +0100
Date: Wed, 10 Mar 1999 10:20:19 +0100
Message-Id: <199903100920.KAA01213@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: eedthwo@eede.ericsson.se, linux@cthulhu.engr.sgi.com
Subject: Re: Illegal f_magic number while install-procedure
In-Reply-To: <19990309000234.A2804@alpha.franken.de>
References: <199903081247.NAA02741@sun168.eu>
	<19990309000234.A2804@alpha.franken.de>
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > On Mon, Mar 08, 1999 at 01:47:03PM +0100, Tom Woelfel wrote:
 > > Cannot load bootp()/vmlinux
 > > Illegal f_magic number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC.
 > 
 > your prom is too old to understand ELF files. To solve this problem you
 > need either a newer prom or an Indy kernel in ECOFF format.
 > 
 > I've successful booted a converted kernel a few minutes ago and will upload
 > this kernel to
 > 
 > ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990226.ecoff.gz
 > 
 > Please try it.

My Indy has seen the light ;-). The kernel boots and goes it's way
through the device checking. All disk's are recognized and the
mount-request for the root-file-system is send to the server. The
(root)-dir is mounted from the Indy. (I can see this in the server-log)
Then the prom-memory is freed and the last thing I see is: 
freeing unused kernel memory 52k

Then nothing happens anymore. I think the next thing to come should be 
the 'init' process (init doesn't need to be an ECOFF - exec ?).

Or do I nedd a modified init to jump into setup?
                              
partial sucess,
Tom
