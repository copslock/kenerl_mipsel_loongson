Received:  by oss.sgi.com id <S305181AbQERNcb>;
	Thu, 18 May 2000 13:32:31 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:2678 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQERNc0>;
	Thu, 18 May 2000 13:32:26 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA16611; Thu, 18 May 2000 06:27:34 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA09920; Thu, 18 May 2000 06:30:38 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA55679
	for linux-list;
	Thu, 18 May 2000 06:17:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA54193
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 May 2000 06:17:00 -0700 (PDT)
	mail_from (soren@gnyf.wheel.dk)
Received: from gnyf.wheel.dk (gnyf.wheel.dk [193.162.159.104]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA05838
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 May 2000 06:16:58 -0700 (PDT)
	mail_from (soren@gnyf.wheel.dk)
Received: (from soren@localhost)
	by gnyf.wheel.dk (8.9.1/8.9.1) id PAA05928;
	Thu, 18 May 2000 15:16:57 +0200 (CEST)
Date:   Thu, 18 May 2000 15:16:57 +0200
From:   "Soren S. Jorvang" <soren@wheel.dk>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: O2 ARCS
Message-ID: <20000518151657.A5906@gnyf.wheel.dk>
References: <20000517051524.A21067@gnyf.wheel.dk> <20000517215310.F779@uni-koblenz.de> <20000518011656.A721@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000518011656.A721@paradigm.rfc822.org>; from flo@rfc822.org on Thu, May 18, 2000 at 01:16:56AM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 18, 2000 at 01:16:56AM +0200, Florian Lohoff wrote:
> On Wed, May 17, 2000 at 09:53:11PM +0200, Ralf Baechle wrote:
> > The ARCS firmware isn't the big deal but the R10000 support for this
> > system or any other non-cachecoherent system.  Harald Koerfgen has
> > started poking at an O2 port and he's got first success.
> 
> BTW: Is there any Documentation for the ARC Firmware of the SGIs ?

While not quite identical to the SGI ARCS firmware, 
http://www.microsoft.com/hwdev/download/respec/riscspec.zip
is useful.


-- 
Soren
