Received:  by oss.sgi.com id <S305160AbQCMTT2>;
	Mon, 13 Mar 2000 11:19:28 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14678 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCMTTW>; Mon, 13 Mar 2000 11:19:22 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05124; Mon, 13 Mar 2000 11:10:45 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA77544
	for linux-list;
	Mon, 13 Mar 2000 10:37:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA16985;
	Mon, 13 Mar 2000 10:37:16 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA22532;
	Mon, 13 Mar 2000 10:36:56 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14541.13640.518144.418083@liveoak.engr.sgi.com>
Date:   Mon, 13 Mar 2000 10:36:56 -0800 (PST)
To:     Warner Losh <imp@village.org>
Cc:     Hiroo HAYASHI <hiroo.hayashi@toshiba.co.jp>,
        "Kevin D. Kissell" <kevink@mips.com>,
        "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: R39xx and Processor IDs (was Re: FP emulation patch available) 
In-Reply-To: <200003130735.AAA85454@harmony.village.org>
References: <200003130602.PAA07981@toshiba.co.jp>
	<200003130735.AAA85454@harmony.village.org>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Warner Losh writes:
 > In message <200003130602.PAA07981@toshiba.co.jp> Hiroo HAYASHI writes:
 > : I've checked this issue in Toshiba.  As far as I could know, Toshiba
 > : is using PrIDs which are assigned through the agreement between MIPS
 > : Technology and Toshiba.  I hope that the R4650 value in the source
 > : code is in error, too.
 > 
 > The R4650 from IDT is definitely documented as having a PrID of 0x22
 > in at least two docuements that I have in my posession.  I have a
 > R4650, but no software that I can easily boot to check it out for
 > sure.

      I have had the R4650 as 0x22 for quite a few years.  It was my 
understanding that QED had all of the 0x2?  numbers, but at least
0x20..0x23 and 0x28.
