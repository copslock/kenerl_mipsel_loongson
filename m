Received:  by oss.sgi.com id <S305176AbQD1Bo4>;
	Thu, 27 Apr 2000 18:44:56 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39694 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305175AbQD1Bop>; Thu, 27 Apr 2000 18:44:45 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA04663; Thu, 27 Apr 2000 18:48:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id SAA84046; Thu, 27 Apr 2000 18:44:14 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA15306
	for linux-list;
	Thu, 27 Apr 2000 18:36:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA09185
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Apr 2000 18:36:42 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1406384AbQDZUGD>;
	Wed, 26 Apr 2000 13:06:03 -0700
Date:   Wed, 26 Apr 2000 13:06:03 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@suse.de>
Cc:     Jun Sun <jsun@mvista.com>,
        Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: failed to compile glibc 2.1.2 - BFD_RELOC_16_PCREL_S2 problem
Message-ID: <20000426130603.E757@uni-koblenz.de>
References: <Pine.LNX.4.21.0004241837420.1735-100000@calypso.engr.sgi.com> <3904ED75.209AFD22@mvista.com> <u8og6xi6p9.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8og6xi6p9.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Wed, Apr 26, 2000 at 10:53:38AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Apr 26, 2000 at 10:53:38AM +0200, Andreas Jaeger wrote:

> It's just that nobody did the work of porting glibc.  A lot of has
> changed between glibc 2.0 and 2.1 (and also between 2.1 and 2.2).
> I've decided to port glibc 2.2 for MIPS.  This involved a number of
> patches and but I don't have the time to backport everything - and I
> will not support such a backport at all.
> 
> All my glibc 2.2 patches have been added to the glibc archives and
> therefore will be in the official sources of 2.2.

All in all I think that given the work that has been invested into making
a solid 2.2 port 2.2 might soon be the better choice than 2.0 and
source compatibility issues should make a port of 2.1 mostly a non-issue.

  Ralf
