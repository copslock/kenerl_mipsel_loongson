Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA44049 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Apr 1999 09:54:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA85799
	for linux-list;
	Tue, 13 Apr 1999 09:53:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA53770
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Apr 1999 09:53:05 -0700 (PDT)
	mail_from (adisaacs@mtu.edu)
Received: from news.mtu.edu (news.mtu.edu [141.219.70.11]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09627
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 09:53:03 -0700 (PDT)
	mail_from (adisaacs@mtu.edu)
Received: from mtu.edu (root@mtu.edu [141.219.70.1])
	by news.mtu.edu (8.8.8/8.8.8) with ESMTP id MAA02763
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 12:53:01 -0400 (EDT)
Received: from wiley.sas.it.mtu.edu (wiley.sas.it.mtu.edu [141.219.36.70])
	by mtu.edu (8.8.8/8.8.8) with ESMTP id MAA26888
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 12:53:01 -0400 (EDT)
Received: (from adisaacs@localhost)
	by wiley.sas.it.mtu.edu (8.8.7/8.8.7/mturelay-1.2) id MAA20974
	for linux@cthulhu.engr.sgi.com; Tue, 13 Apr 1999 12:52:55 -0400 (EDT)
Date: Tue, 13 Apr 1999 12:52:54 -0400
From: Andrew Isaacson <adisaacs@mtu.edu>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Resources in X11 port
Message-ID: <19990413125254.A20170@mtu.edu>
References: <199904130857.OAA23664@bhairavi.newdelhi.sgi.com> <19990413122357.A16312@ruvild.bun.falkenberg.se> <371371D7.A8187D38@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <371371D7.A8187D38@hol.gr>; from Theodoros Nikitopoulos on Tue, Apr 13, 1999 at 07:33:28PM +0300
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://www.csl.mtu.edu/~adisaacs/pgp.txt
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Apr 13, 1999 at 07:33:28PM +0300, Theodoros Nikitopoulos wrote:
> Hello there,
> 
> I've just setup a web page containing helpfull resources I found in
> the net, in concern of the X11 Linux/SGI port. Maybe you know about
> it but well just in case.. :-)
> 
> Although an X11 port seems at first sight quite difficult--in case
> someone has a valuable ammount of information about--it seems
> to be quiete easy.
> 
> Unfortunately, I cannot personally offer any other help in due of a
> project I have to work during the period April-June at INRIA. But
> in any case drop me an e-mail for any progress !  I would be glad
> to hear about it  :-)
> 
> The page is located at :   http://users.hol.gr/~tnik/X11/

Interesting page.  However, I would suggest that anybody who plans to
tackle porting XFree86 to Linux/SGI should contact xfree86@xfree86.org
and ask to become an XFree86 developer.  There are several resources
which are available only to developers, including mailing list
archives and the 4.0 development tree, which will likely prove
invaluable to anyone attempting a port.

If you (the porters) are willing to wait until June to have publicly
distributable code, you should develop for the 4.0 branch rather than
the 3.3 branch.  There are a lot of useful new features in the new
code base, and the new design is quite a bit easier to code for than
the old.

Also, Theodoros, I'm curious why you recommend starting with a 6.3
tree and patching up to XFree86 3.3.3.  Why not just grab the 3.3.3.1
source tarballs and be done with it?

-andy
-- 
Andy Isaacson adisaacs@mtu.edu adi@acm.org    Fight Spam, join CAUCE:
http://www.csl.mtu.edu/~adisaacs/              http://www.cauce.org/
