Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA62030 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Feb 1999 15:16:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA42781
	for linux-list;
	Tue, 9 Feb 1999 15:15:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (kilimanjaro.engr.sgi.com [150.166.49.139])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA38328
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 Feb 1999 15:15:33 -0800 (PST)
	mail_from (owner-linux@kilimanjaro.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by kilimanjaro.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA90507; Tue, 9 Feb 1999 15:15:29 -0800 (PST)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA42452;
	Tue, 9 Feb 1999 15:15:28 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03326; Tue, 9 Feb 1999 15:15:23 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA08763;
	Tue, 9 Feb 1999 18:19:03 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 9 Feb 1999 18:19:03 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
cc: linux@kilimanjaro.engr.sgi.com
Subject: Re: glibc SRPM
In-Reply-To: <199902092258.OAA92704@kilimanjaro.engr.sgi.com>
Message-ID: <Pine.LNX.3.96.990209181640.7989B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 9 Feb 1999, Joan Eslinger wrote:
> Hi. I'm trying to unpack one of the glibc SRPMS from HardHat and am
> getting the error
> 
>   % rpm -i glibc-2.0.6.src.rpm
>   unpacking of archive failed on file glibc-2.0.6.tar.gz: 1: Success
>   error: glibc-2.0.6-3.src.rpm cannot be installed

Oh my god! That file must be corrupt on the CD! What kind of irresponsible
distribution would ever do that? :)

You can find a more modern version in:
ftp://ftp.linux.sgi.com:/pub/linux/mips/test/glibc-2.0.6-6.src.rpm

- Alex

-- 
Alex deVries, puffin on LinuxNet.
I know exactly what I want in life.
