Received:  by oss.sgi.com id <S305166AbQBQXse>;
	Thu, 17 Feb 2000 15:48:34 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:65314 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQBQXs3>;
	Thu, 17 Feb 2000 15:48:29 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA12933; Thu, 17 Feb 2000 15:43:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA51265; Thu, 17 Feb 2000 15:48:28 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA73221
	for linux-list;
	Thu, 17 Feb 2000 15:17:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA37189
	for <linux@engr.sgi.com>;
	Thu, 17 Feb 2000 15:17:07 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02779
	for <linux@engr.sgi.com>; Thu, 17 Feb 2000 15:17:10 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-4.uni-koblenz.de (cacc-4.uni-koblenz.de [141.26.131.4])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA27832;
	Fri, 18 Feb 2000 00:16:50 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBQQoc>;
	Thu, 17 Feb 2000 17:44:32 +0100
Date:   Thu, 17 Feb 2000 17:44:32 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: 32-bit MIPS with > 512mb mem
Message-ID: <20000217174432.B5659@uni-koblenz.de>
References: <20000216192427.A6330@uni-koblenz.de> <38ABD8F8.E25D670F@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38ABD8F8.E25D670F@niisi.msk.ru>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Feb 17, 2000 at 02:18:16PM +0300, Gleb O. Raiko wrote:

> Not exactly > 512 mb, but related things. On Baget and DECstations, if
> memory serves correctly, there is IO space mapped on KSEG2. Now, Baget
> uses kseg2_allocate_io for it, DECstation also has something similar. IO
> space on Jazz and Co. are located in virtual address window too, can't
> remember where. In princple, access to such IO spaces may be done by
> using highmem.

I've only been refering to RAM where an efficient solution is much more
difficult.

Devices on some R4k machines are special anyway because sometimes they
reside at physical addresses outside the lowest 4gb which means we cannot
even address them using our current page tables.  And changing those in
general isn't a good idea unless we also have RAM at >= 512mb.

  Ralf
