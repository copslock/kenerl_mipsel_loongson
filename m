Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA20386
	for <pstadt@stud.fh-heilbronn.de>; Thu, 15 Jul 1999 02:56:33 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA01686; Wed, 14 Jul 1999 17:50:40 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA81837
	for linux-list;
	Wed, 14 Jul 1999 17:46:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA68284
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Jul 1999 17:46:46 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06320
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jul 1999 17:46:44 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA10361
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 02:46:41 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id WAA01008;
	Wed, 14 Jul 1999 22:52:22 +0200
Date: Wed, 14 Jul 1999 22:52:22 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Float / Double issues
Message-ID: <19990714225222.A998@uni-koblenz.de>
References: <378AADF5.96152E0B@cobaltnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <378AADF5.96152E0B@cobaltnet.com>; from Tim Hockin on Mon, Jul 12, 1999 at 08:09:41PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 12, 1999 at 08:09:41PM -0700, Tim Hockin wrote:

> 2) Floats and va_arg crash with an FPE
> 
> below are two snippets that show these, at least on our boxes.  If
> someone could confirm or deny their existence on any other platform?

The float / va_arg bug is a pilot error.  See ANSI C draft chapter 6.5.2.2,
paragraph 6 and7.  In short the problem is that float parameters will be
promoted to double.  You therefore have to to change the call of va_arg
in your float.c to va_arg(va, float).

Obvious, heh ;-)

Btw, SGI's compiler also doesn't attempt to get va_arg(..., float) right.

  Ralf
