Received:  by oss.sgi.com id <S305181AbQDZJnn>;
	Wed, 26 Apr 2000 02:43:43 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:58391 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305157AbQDZJn2>;
	Wed, 26 Apr 2000 02:43:28 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA12745; Wed, 26 Apr 2000 02:38:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA50356
	for linux-list;
	Wed, 26 Apr 2000 02:28:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA05480;
	Wed, 26 Apr 2000 02:28:16 -0700 (PDT)
	mail_from (aj@suse.de)
Received: from news-ma.rhein-neckar.de (news-ma.rhein-neckar.de [193.197.90.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06157; Wed, 26 Apr 2000 02:28:15 -0700 (PDT)
	mail_from (aj@suse.de)
Received: from arthur.rhein-neckar.de (uucp@localhost)
	by news-ma.rhein-neckar.de (8.8.8/8.8.8) with bsmtp id LAA11765;
	Wed, 26 Apr 2000 11:28:17 +0200 (CEST)
	(envelope-from aj@suse.de)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.rhein-neckar.de with esmtp (Exim 3.11 #1)
	id 12kNZj-0001q8-00; Wed, 26 Apr 2000 10:53:39 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 69FBE1821; Wed, 26 Apr 2000 10:53:38 +0200 (CEST)
Mail-Copies-To: never
To:     Jun Sun <jsun@mvista.com>
Cc:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: failed to compile glibc 2.1.2 - BFD_RELOC_16_PCREL_S2 problem
References: <Pine.LNX.4.21.0004241837420.1735-100000@calypso.engr.sgi.com> <3904ED75.209AFD22@mvista.com>
From:   Andreas Jaeger <aj@suse.de>
Date:   26 Apr 2000 10:53:38 +0200
In-Reply-To: Jun Sun's message of "Mon, 24 Apr 2000 17:57:25 -0700"
Message-ID: <u8og6xi6p9.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0804 (Gnus v5.8.4) XEmacs/21.1 (Canyonlands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>>>>> Jun Sun writes:

 > Ulf Carlsson wrote:
>> 
>> On Mon, 24 Apr 2000, Jun Sun wrote:
>> 
>> >
>> > I am having this problem while I am trying to build glibc v2.1.2.  Does
>> > anybody know about this problem?  Do I need some MIPS patch for building
>> > this?  Thanks.
>> 
>> You can't use glibc 2.1.2 on MIPS, 

 > Is there a specific reason why I can't use glibc 2.1.2?  We have been
 > using this version for other platforms (ppc, i386).  It would be nice to
 > stick with the same version for MIPS.

It's just that nobody did the work of porting glibc.  A lot of has
changed between glibc 2.0 and 2.1 (and also between 2.1 and 2.2).
I've decided to port glibc 2.2 for MIPS.  This involved a number of
patches and but I don't have the time to backport everything - and I
will not support such a backport at all.

All my glibc 2.2 patches have been added to the glibc archives and
therefore will be in the official sources of 2.2.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.rhein-neckar.de
