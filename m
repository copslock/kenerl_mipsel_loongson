Received:  by oss.sgi.com id <S42294AbQFSWOG>;
	Mon, 19 Jun 2000 15:14:06 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55815 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42239AbQFSWNv>; Mon, 19 Jun 2000 15:13:51 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA01573
	for <linux-mips@oss.sgi.com>; Mon, 19 Jun 2000 15:18:56 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA24509
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 19 Jun 2000 15:13:18 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from rotor.chem.unr.edu (rotor.chem.unr.edu [134.197.32.176]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08996
	for <linux@cthulhu.engr.sgi.com>; Mon, 19 Jun 2000 15:13:18 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id PAA30510;
	Mon, 19 Jun 2000 15:13:09 -0700
Date:   Mon, 19 Jun 2000 15:13:09 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Mitja Bezget <gw@sers.s-sers.mb.edus.si>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Mouse on Indy
Message-ID: <20000619151309.A29509@chem.unr.edu>
References: <Pine.LNX.3.95.1000619234901.23507C-100000@sers.s-sers.mb.edus.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1000619234901.23507C-100000@sers.s-sers.mb.edus.si>; from gw@sers.s-sers.mb.edus.si on Mon, Jun 19, 2000 at 11:58:44PM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jun 19, 2000 at 11:58:44PM +0200, Mitja Bezget wrote:

> Is there a way to get the IndyMouse to work? What kind
> of mouse is that anyway? ps2? some kind of bus-mouse?

It's plain PS2.

> What kernel options am I supposed to enable?

I've always built with PS2 enabled only. Make sure you have /dev/psaux
made too. Character, major 10, minor 1. It works for me.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
