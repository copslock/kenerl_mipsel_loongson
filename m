Received:  by oss.sgi.com id <S305158AbQCHXPn>;
	Wed, 8 Mar 2000 15:15:43 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60750 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCHXPS>; Wed, 8 Mar 2000 15:15:18 -0800
Received: from cthulhu.engr.sgi.com ([192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA04567; Wed, 8 Mar 2000 15:18:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA10995
	for linux-list;
	Wed, 8 Mar 2000 15:00:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA27300
	for <linux@engr.sgi.com>;
	Wed, 8 Mar 2000 15:00:12 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00644
	for <linux@engr.sgi.com>; Wed, 8 Mar 2000 15:00:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407898AbQCHW7q>;
	Wed, 8 Mar 2000 19:59:46 -0300
Date:   Wed, 8 Mar 2000 19:59:46 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     Tim Wilkinson <tim@transvirtual.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: Mips/Linux integration of latest GCC, Binutils & GLibc
Message-ID: <20000308195946.A8173@uni-koblenz.de>
References: <38C54F05.458A3EFE@transvirtual.com> <20000308140301.B1425@uni-koblenz.de> <38C6A5D4.F08DFCE4@transvirtual.com> <20000308174251.A6399@uni-koblenz.de> <38C6BE35.C58B0630@transvirtual.com> <20000308180850.D6399@uni-koblenz.de> <59c501bf894d$31be85c0$0a00000a@decoy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <59c501bf894d$31be85c0$0a00000a@decoy>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 08, 2000 at 05:25:18PM -0500, Jay Carlson wrote:

> As Ralf sez, because MIPS PIC and non-PIC code can't intercall, generation
> of non-PIC code for use in static libraries is incorrect, unless
> EVERYTHING you're linking is non-PIC.  Most people feel that giving up
> shared libraries is too high a price for the potential gain in code
> density and efficiency from non-PIC/non-ABI builds.  Me, I still have
> lingering doubts, but I don't have working code yet, so...

Even if just two programs are sharing libc you're already on the winning
side.

> Originally I thought that it would not be necessary to ever pass -KPIC to
> the assembler; at the top of each PIC/abicalls assembly file GCC produces,
> it sticks in a ".abicalls" directive which has the same effect as the
> -KPIC option.  That worked just great until I encountered .S files that
> didn't have that directive and didn't know any better, so I had to put the
> -KPIC back in :-(

We've got assembler files that without any change can be assembled both into
pic and non-pic code, so the caller of the assembler should handle this.

  Ralf
