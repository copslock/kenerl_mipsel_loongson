Received:  by oss.sgi.com id <S305155AbQCJVvT>;
	Fri, 10 Mar 2000 13:51:19 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4922 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCJVvB>; Fri, 10 Mar 2000 13:51:01 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA00498; Fri, 10 Mar 2000 13:54:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA30932; Fri, 10 Mar 2000 13:50:59 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA15964
	for linux-list;
	Wed, 8 Mar 2000 18:04:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA15203
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 18:04:27 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07304
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 18:04:26 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from harmony.village.org (harmony.village.org [10.0.0.6])
	by rover.village.org (8.9.3/8.9.3) with ESMTP id TAA65599;
	Wed, 8 Mar 2000 19:04:15 -0700 (MST)
	(envelope-from imp@harmony.village.org)
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.3/8.8.3) with ESMTP id TAA05642; Wed, 8 Mar 2000 19:03:59 -0700 (MST)
Message-Id: <200003090203.TAA05642@harmony.village.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: FP emulation patch available 
Cc:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-reply-to: Your message of "Wed, 08 Mar 2000 21:12:49 +0100."
		<042401bf893a$b15465b0$0ceca8c0@satanas.mips.com> 
References: <042401bf893a$b15465b0$0ceca8c0@satanas.mips.com>  
Date:   Wed, 08 Mar 2000 19:03:59 -0700
From:   Warner Losh <imp@village.org>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

In message <042401bf893a$b15465b0$0ceca8c0@satanas.mips.com> "Kevin D. Kissell" writes:
: If Philips/Tosh are really aliasing the PrID of the R4650, sombody has
: done something Deeply Evil (and probably in violation of one agreement
: or another).  I'm checking with MIPS HQ on this, and hoping that in fact
: the R4650 value in the source code is in error.

The R45650 is evil incarnate :-)  It doesn't have an MMU at all, so
maybe that's how you can tell the difference.

Warner
