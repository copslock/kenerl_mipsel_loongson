Received:  by oss.sgi.com id <S554034AbRA1MOr>;
	Sun, 28 Jan 2001 04:14:47 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:16653 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S554028AbRA1MO3>;
	Sun, 28 Jan 2001 04:14:29 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com (dhcp-163-154-5-240.engr.sgi.com [163.154.5.240]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA05801
	for <linux-mips@oss.sgi.com>; Sun, 28 Jan 2001 04:13:30 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870761AbRA1MK1>; Sun, 28 Jan 2001 04:10:27 -0800
Date: 	Sun, 28 Jan 2001 04:10:26 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Mike McDonald <mikemac@mikemac.com>
Cc:     Karel van Houten <K.H.C.vanHouten@research.kpn.com>,
        linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
Message-ID: <20010128041025.C4287@bacchus.dhis.org>
References: <200101271052.LAA21268@sparta.research.kpn.com> <200101272257.OAA05689@saturn.mikemac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101272257.OAA05689@saturn.mikemac.com>; from mikemac@mikemac.com on Sat, Jan 27, 2001 at 02:57:24PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jan 27, 2001 at 02:57:24PM -0800, Mike McDonald wrote:

>   I was thinking of what the MINIMUM set of RPMs you needed installed
> so you could bootstrap a system up from sources, not what's the
> minimum needed to recompile any arbitrary RPM.

Really depends on what you want to do.  Many packages detect other packages
or features of other packages.  This builds a big evil network of
dependencies which make bootstrapping somewhat hard.  It's a good idea to
start with an as complete installation as possible.

>   With less than 150 files installed in a root file system, I can
> install the bin-utils, gcc, make, and glibc RPMs. From there, I should
> be able to begin cross compiling the other basic RPMs for a system.
> That's my ultimate goal.

  Ralf
