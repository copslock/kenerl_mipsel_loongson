Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 19:01:47 +0000 (GMT)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:40136 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225193AbTCKTBq>;
	Tue, 11 Mar 2003 19:01:46 +0000
Received: from mahes.visi.com (mahes.visi.com [209.98.98.96])
	by mail-out.visi.com (Postfix) with ESMTP id 28DA439D3
	for <linux-mips@linux-mips.org>; Tue, 11 Mar 2003 13:01:39 -0600 (CST)
Received: from mahes.visi.com (localhost [127.0.0.1])
	by mahes.visi.com (8.12.5/8.12.5) with ESMTP id h2BJ1c2k071260
	for <linux-mips@linux-mips.org>; Tue, 11 Mar 2003 13:01:38 -0600 (CST)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mahes.visi.com (8.12.5/8.12.5/Submit) id h2BJ1b7L071259
	for linux-mips@linux-mips.org; Tue, 11 Mar 2003 19:01:37 GMT
X-Authentication-Warning: mahes.visi.com: www set sender to erik@greendragon.org using -f
Received: from stpns.guidant.com (stpns.guidant.com [132.189.76.10]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Tue, 11 Mar 2003 19:01:37 +0000
Message-ID: <1047409297.3e6e3291472c1@my.visi.com>
Date: Tue, 11 Mar 2003 19:01:37 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: linux-mips@linux-mips.org
Subject: SGI contact info needed
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 132.189.76.10
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips


Hello all;

I'm about to make a serious attempt at getting Linux running on the Octane
(IP30) and I'm currently gathering information on the hardware while my Octane
is being shipped to me.

I realize that this may be (probably is) a futile effort, but I'm trying to
locate a contact at SGI who can discuss the "Heart" ASIC or provide
documentation for same.  This is the memory controller in the Octane systems,
and as I understand things it's the major difference between Origin and Octane
systems.  I also would love a set of docs on the XIO bus and SE graphics, but
the Heart is the show stopper at this point.

I would deeply appreciate either information on the appropriate person at SGI to
contact if anyone knows this, or else contact from someone @sgi in the know.

My last resort is reverse engineering, which seems silly to have to do given the
dependence of SGI on Linux at the moment.

Erik


PS:


<vent>

I've so far sent about 20-ish e-mails to various folks at SGI, trying to get any
information or even pointers to the right people, and gotten only one actual
reply (thanks Dave) saying "I dunno".

I realize SGI has had a lot of employee turn-over in the last few years, but I'm
seeing an amazingly schizoid company in bits and pieces.  They have released a
new flagship product, the Altix, but they don't seem to have a contact person
listed anywhere to deal with the Linux community in general, even for that product.

In my previous effort to get information on the Impact graphics boards, I
finally got ahold of a single engineer who informed me that only partial docs
existed, probably for the wrong board, and which he might be willing to copy if
I paid for copies.  Shortly after this offer, I no longer received responses
from him.  I can only conclude that he was abducted by Microsoft customer service.

Contrast this with the PS docs for the Indy on the linux-mips ftp site.  I'm
starting to think the Indy was designed and properly documented by Interns, and
the Indigo2 by old timers who retired and took their knowledge with them,
leaving only cryptic notes and binary drivers.

</vent>

-- 
Erik J. Green
erik@greendragon.org
