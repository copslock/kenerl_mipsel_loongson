Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA01263
	for <pstadt@stud.fh-heilbronn.de>; Mon, 28 Jun 1999 03:19:27 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA2784060; Sun, 27 Jun 1999 18:11:23 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA84920
	for linux-list;
	Sun, 27 Jun 1999 18:06:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA42632
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 27 Jun 1999 18:06:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA00107
	for <linux@cthulhu.engr.sgi.com>; Sun, 27 Jun 1999 18:06:55 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-12.uni-koblenz.de [141.26.131.12])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA01166
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Jun 1999 03:06:52 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id DAA01495;
	Mon, 28 Jun 1999 03:06:15 +0200
Date: Mon, 28 Jun 1999 03:06:12 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andrew Linfoot <andy@derfel99.freeserve.co.uk>
Cc: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: CVS Woes
Message-ID: <19990628030612.A730@uni-koblenz.de>
References: <001401bec0eb$87774220$0a02030a@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <001401bec0eb$87774220$0a02030a@snafu>; from Andrew Linfoot on Sun, Jun 27, 1999 at 11:22:21PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 27, 1999 at 11:22:21PM +0100, Andrew Linfoot wrote:
> 
> DEC Alpha running NT and Internal modem
> samba share on my indy source tree
> 
> I can connect to cvs@linus and do a cvs update. The problem is that samba or
> cvs appears to be converting the files to the DOS CR/LF format! and then
> everything breaks horribly.
> 
> How can i get around this?

What CVS is doing is correct, it converts the files into what the local
system - the NT system - is using.
As a workaround try the keyword expansion mode -kb when checking out.
That will give you the original context of the server which happens to be
just right for your Indy.

> Anyone got a script or something that will strip this crap out!

Use find(1) and tr(1).  Or recode ...

  Ralf
