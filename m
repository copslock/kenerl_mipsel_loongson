Received:  by oss.sgi.com id <S42288AbQHWQZG>;
	Wed, 23 Aug 2000 09:25:06 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:18716 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42333AbQHWQYd>;
	Wed, 23 Aug 2000 09:24:33 -0700
Received: from ledzep.cray.com (ledzep.americas.sgi.com [137.38.226.97]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA01631
	for <linux-mips@oss.sgi.com>; Wed, 23 Aug 2000 09:16:26 -0700 (PDT)
	mail_from (bcasavan@sgi.com)
Received: from daisy-e185.americas.sgi.com (daisy.mw.cray.com [128.162.185.214]) by ledzep.cray.com (SGI-SGI-8.9.3/craymail-smart-nospam1.0) with ESMTP id LAA33067; Wed, 23 Aug 2000 11:21:31 -0500 (CDT)
Received: from kzerza.americas.sgi.com (kzerza.americas.sgi.com [128.162.191.33]) by daisy-e185.americas.sgi.com (980427.SGI.8.8.8/SGI-server-1.6) with ESMTP id LAA63247; Wed, 23 Aug 2000 11:21:31 -0500 (CDT)
Received: from localhost by kzerza.americas.sgi.com (SGI-8.9.3/SGI-client-1.6c) via ESMTP id LAA52022; Wed, 23 Aug 2000 11:21:30 -0500 (CDT)
Date:   Wed, 23 Aug 2000 11:21:30 -0500
From:   Brent Casavant <bcasavan@sgi.com>
X-Sender: bcasavan@kzerza.americas.sgi.com
Reply-To: Brent Casavant <bcasavan@sgi.com>
To:     linux-mips@oss.sgi.com
cc:     Pete Popov <ppopov@mvista.com>
Subject: Re: indigo2
In-Reply-To: <20000823165051.I2501@paradigm.rfc822.org>
Message-ID: <Pine.SGI.4.21.0008231120070.57618-100000@kzerza.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 23 Aug 2000, Florian Lohoff wrote:

> On Tue, Aug 22, 2000 at 04:52:26PM -0700, Pete Popov wrote:
> > Does anyone know where I can get hardware documentation for the Indigo2?
> > I'm interested in the hardware memory map and what's on the board
> > itself, such as ethernet controller, the serial ports, rtc, etc.
> 
> Most of the stuff from the Indy should be true also. It should also
> be reconstructable from the Kernel source - AFAIK there is no documentation
> available for the Indigo2.

There are quite a few Indy documents available at:

	ftp://oss.sgi.com/pub/linux/mips/doc/indy/

I've been led to believe that Indigo^2 and Indy are close enough to
eachother that this sort of documentation may be all you need.

Hope that helps,
Brent

-- 
Brent Casavant            bcasavan@sgi.com
Kernel Engineer           http://reality.sgi.com/bcasavan
Silicon Graphics, Inc.
