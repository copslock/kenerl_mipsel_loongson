Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA20303
	for <pstadt@stud.fh-heilbronn.de>; Tue, 24 Aug 1999 00:23:05 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03506; Mon, 23 Aug 1999 15:20:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA23288
	for linux-list;
	Mon, 23 Aug 1999 15:14:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA02218
	for <linux@engr.sgi.com>;
	Mon, 23 Aug 1999 15:14:11 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00493
	for <linux@engr.sgi.com>; Mon, 23 Aug 1999 15:13:55 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-5.uni-koblenz.de [141.26.131.5])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA08335
	for <linux@engr.sgi.com>; Tue, 24 Aug 1999 00:13:42 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA21346;
	Tue, 24 Aug 1999 00:09:37 +0200
Date: Tue, 24 Aug 1999 00:09:37 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andreas Jaeger <aj@arthur.rhein-neckar.de>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: MIPS64
Message-ID: <19990824000937.J19012@uni-koblenz.de>
References: <19990822141504.A15701@uni-koblenz.de> <u87lmmd109.fsf@arthur.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <u87lmmd109.fsf@arthur.rhein-neckar.de>; from Andreas Jaeger on Mon, Aug 23, 1999 at 04:28:54PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 23, 1999 at 04:28:54PM +0200, Andreas Jaeger wrote:

>  > as those who are tracking the CVS archive or the commit mailing list
>  > probably already have seen I've got started to work on a 64-bit kernel.
>  > I'm also using the chance to do a major overhaul of various code which
>  > over the years had turned into a major uglyness.
> Could anybody provide me with infos about the commit mailing list?  I
> couldn't find the information myself:-(.

Yep, because it's not documented.  The mailing list is a plain
sendmail alias.  But I think you can also subscribe to it by

echo "subscribe linux-progress" | mail majordomo@engr.sgi.com

  Ralf
