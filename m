Received:  by oss.sgi.com id <S305157AbQCMHzH>;
	Sun, 12 Mar 2000 23:55:07 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:44064 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCMHyo>; Sun, 12 Mar 2000 23:54:44 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id XAA08525; Sun, 12 Mar 2000 23:58:04 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA07652
	for linux-list;
	Sun, 12 Mar 2000 23:35:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA25134
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Mar 2000 23:35:32 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA03484
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Mar 2000 23:35:29 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from harmony.village.org (harmony.village.org [10.0.0.6])
	by rover.village.org (8.9.3/8.9.3) with ESMTP id AAA84014;
	Mon, 13 Mar 2000 00:35:15 -0700 (MST)
	(envelope-from imp@harmony.village.org)
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.3/8.8.3) with ESMTP id AAA85454; Mon, 13 Mar 2000 00:35:14 -0700 (MST)
Message-Id: <200003130735.AAA85454@harmony.village.org>
To:     Hiroo HAYASHI <hiroo.hayashi@toshiba.co.jp>
Subject: Re: R39xx and Processor IDs (was Re: FP emulation patch available) 
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-reply-to: Your message of "Mon, 13 Mar 2000 15:02:21 +0900."
		<200003130602.PAA07981@toshiba.co.jp> 
References: <200003130602.PAA07981@toshiba.co.jp>  
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85448.952932909.1@harmony.village.org>
Date:   Mon, 13 Mar 2000 00:35:14 -0700
From:   Warner Losh <imp@village.org>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

In message <200003130602.PAA07981@toshiba.co.jp> Hiroo HAYASHI writes:
: I've checked this issue in Toshiba.  As far as I could know, Toshiba
: is using PrIDs which are assigned through the agreement between MIPS
: Technology and Toshiba.  I hope that the R4650 value in the source
: code is in error, too.

The R4650 from IDT is definitely documented as having a PrID of 0x22
in at least two docuements that I have in my posession.  I have a
R4650, but no software that I can easily boot to check it out for
sure.

: BTW Toshiba is also working for Linux on MIPS.  Porting to TX3912,
: TX3922, and TX4955 is done on our reference boards.  We made a contact
: with Ralf and asked him how to contribute our code.  Our engneer is
: now cleaning up code and I hope he will release it in these months.

Cool.  What's a TX4955?  I haven't heard about that one.c

Warner
