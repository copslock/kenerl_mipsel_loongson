Received:  by oss.sgi.com id <S305160AbQANFGl>;
	Thu, 13 Jan 2000 21:06:41 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:17740 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQANFGY>; Thu, 13 Jan 2000 21:06:24 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id VAA08599; Thu, 13 Jan 2000 21:10:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA04048
	for linux-list;
	Thu, 13 Jan 2000 20:56:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA32807
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 13 Jan 2000 20:56:28 -0800 (PST)
	mail_from (soren@gnyf.wheel.dk)
Received: from gnyf.wheel.dk (gnyf.wheel.dk [193.162.159.104]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA01072
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 20:56:17 -0800 (PST)
	mail_from (soren@gnyf.wheel.dk)
Received: (from soren@localhost)
	by gnyf.wheel.dk (8.9.1/8.9.1) id FAA26982;
	Fri, 14 Jan 2000 05:56:13 +0100 (CET)
Date:   Fri, 14 Jan 2000 05:56:13 +0100
From:   "Soren S. Jorvang" <soren@wheel.dk>
To:     John Michael Clemens <clemej@rpi.edu>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
Message-ID: <20000114055613.A26954@gnyf.wheel.dk>
References: <14462.24718.670816.841437@liveoak.engr.sgi.com> <Pine.A41.3.96.1000113224501.118018F-100000@vcmr-19.rcs.rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3us
In-Reply-To: <Pine.A41.3.96.1000113224501.118018F-100000@vcmr-19.rcs.rpi.edu>; from John Michael Clemens on Thu, Jan 13, 2000 at 10:56:25PM -0500
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Jan 13, 2000 at 10:56:25PM -0500, John Michael Clemens wrote:
> Would there be enough in this firmware to do a basic text console?  even
> that would be better than soldering together a serial cable to run over
> Minicom.

You can always use the PROM callbacks for that.


-- 
Soren
