Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA84532 for <linux-archive@neteng.engr.sgi.com>; Tue, 8 Sep 1998 14:22:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA26546
	for linux-list;
	Tue, 8 Sep 1998 14:21:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (ripple.nashua.sgi.com [169.238.59.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA03501;
	Tue, 8 Sep 1998 14:21:31 -0700 (PDT)
	mail_from (lembree@sgi.com)
Message-ID: <35F59FCD.F7A6E459@sgi.com>
Date: Tue, 08 Sep 1998 17:21:17 -0400
From: Rob Lembree <lembree@sgi.com>
Organization: Silicon Graphics, Inc.
X-Mailer: Mozilla 4.5b1C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: Leon Verrall <leon@reading.sgi.com>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Success at last...
References: <Pine.LNX.3.96.980904130745.26347A-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> 
> On Fri, 4 Sep 1998, Leon Verrall wrote:
> >
> > FInally got rid of the "Warning, unable to open console" message. I think I
> > managed it by not letting IRIX anywhere near the tarball of hard hat.
> > Downloaded and extracted entirely on Debian Linux.
> 
> This is really weird.  Can you explain in greater detail what you changed
> to make sure that it worked?

I found that IRIX's tar wasn't very careful with modification dates,
which I don't think is a problem, but the major and minor IDs of the
dev files were all zero -- clearly broken.  I haven't experimented,
but I believe this to be the failure.

-r

-- 

Rob Lembree                Strategic Software Organization

Silicon Graphics, Inc.                  http://www.sgi.com
One Cabot Road                             rob@lembree.com
Hudson, MA 01749                           lembree@sgi.com
Phone: 978-567-2141                      FAX: 978-567-2341

PGP: 1F EE F8 58 30 F1 B1 20  C5 4F 12 21 AD 0D 6B 29
