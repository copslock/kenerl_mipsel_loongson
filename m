Received:  by oss.sgi.com id <S305155AbQCJV67>;
	Fri, 10 Mar 2000 13:58:59 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:9229 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQCJV6v>;
	Fri, 10 Mar 2000 13:58:51 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA02572; Fri, 10 Mar 2000 13:54:14 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA49674; Fri, 10 Mar 2000 13:58:49 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA21349
	for linux-list;
	Wed, 8 Mar 2000 18:14:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA17154
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 18:14:13 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA06059
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 18:14:12 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from harmony.village.org (harmony.village.org [10.0.0.6])
	by rover.village.org (8.9.3/8.9.3) with ESMTP id TAA65675;
	Wed, 8 Mar 2000 19:14:03 -0700 (MST)
	(envelope-from imp@harmony.village.org)
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.3/8.8.3) with ESMTP id TAA05780; Wed, 8 Mar 2000 19:13:47 -0700 (MST)
Message-Id: <200003090213.TAA05780@harmony.village.org>
To:     Dominic Sweetman <dom@algor.co.uk>
Subject: Re: FP emulation patch available 
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-reply-to: Your message of "Wed, 08 Mar 2000 22:23:15 GMT."
		<200003082223.WAA00605@gladsmuir.algor.co.uk> 
References: <200003082223.WAA00605@gladsmuir.algor.co.uk>  <042401bf893a$b15465b0$0ceca8c0@satanas.mips.com> 
Date:   Wed, 08 Mar 2000 19:13:47 -0700
From:   Warner Losh <imp@village.org>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

In message <200003082223.WAA00605@gladsmuir.algor.co.uk> Dominic Sweetman writes:
: The R3900 should be 34 (decimal).  We don't have a record of the
: R4640/4650, which must surely be the same as each other.

My IDT79R46[45]0 RISC processor Hardware user's manual lists 0x22 as
on Page 4-10.  I don't have any software that will boot on the 4650
that I have, so I've not actually checked this.

I agree with your hobby horse :-)

Warner
