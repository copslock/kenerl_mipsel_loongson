Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA55346 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 19:46:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA23786
	for linux-list;
	Fri, 26 Jun 1998 19:46:26 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA29462
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 19:46:22 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA02862
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 19:46:21 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA21268;
	Fri, 26 Jun 1998 22:44:45 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 26 Jun 1998 22:44:45 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: /dev/mouse ?
In-Reply-To: <19980626074948.06850@life.nthu.edu.tw>
Message-ID: <Pine.LNX.3.95.980626224406.19185C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 26 Jun 1998, Francis M.J. Hsieh wrote:
> Dear SGI/Linuxer:
> Do anybody know which device should the /dev/mouse linked to?

/dev/psaux, I would think, but seeing as the psaux driver isn't working,
it'll go nowhere.

Hm.  Someone should look at that.

- Alex
