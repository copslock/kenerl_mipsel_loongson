Received:  by oss.sgi.com id <S305160AbQANEJk>;
	Thu, 13 Jan 2000 20:09:40 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15689 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQANEJS>; Thu, 13 Jan 2000 20:09:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA06103; Thu, 13 Jan 2000 20:13:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA72924
	for linux-list;
	Thu, 13 Jan 2000 19:56:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA03523;
	Thu, 13 Jan 2000 19:56:29 -0800 (PST)
	mail_from (clemej@rpi.edu)
Received: from mail.rpi.edu (mail.rpi.edu [128.113.100.7]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03756; Thu, 13 Jan 2000 19:56:27 -0800 (PST)
	mail_from (clemej@rpi.edu)
Received: from vcmr-19.rcs.rpi.edu (clemej@vcmr-19.rcs.rpi.edu [128.113.113.12])
	by mail.rpi.edu (8.9.3/8.9.3) with SMTP id WAA60998;
	Thu, 13 Jan 2000 22:56:26 -0500
Date:   Thu, 13 Jan 2000 22:56:25 -0500 (EST)
From:   John Michael Clemens <clemej@rpi.edu>
X-Sender: clemej@vcmr-19.rcs.rpi.edu
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
In-Reply-To: <14462.24718.670816.841437@liveoak.engr.sgi.com>
Message-ID: <Pine.A41.3.96.1000113224501.118018F-100000@vcmr-19.rcs.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, 13 Jan 2000, William J. Earl wrote:

>        Basically, XZ hardware documentation is not available outside SGI.
> We have agreement inside SGI to provide some information, if a volunteer
> inside SGI appears to track it down, but no volunteer so far.  

:), I kindav figured as much, but it never hurts to ask.  I'd
volunteer to come work at SGI to do it to, but my resume I sent there
seems to be .. umm.. ignored.

> The problem
> is that the hardware interface is quite complex, and some of what one
> thinks of as hardware is really firmware, a basic version of which is
> downloaded by the PROM at startup time.  An X server could rely on the
> PROM-loaded firmware, but it still takes quite a bit of code to set up
> the hardware.  

Would there be enough in this firmware to do a basic text console?  even
that would be better than soldering together a serial cable to run over
Minicom.

> Note that XZ, like Newport graphics on Indy, does not
> have a CPU-addressable frame buffer, so you have to use the rendering interface.

Would this be at all analgous to the code I saw poking around the Xfree
tree once that implemented a server for the Voodoo(2) 3D-only cards?
For that matter, how closely related are the XZ and XL?

thanks for the info.

on an unrelated note: I'm slightly confused... is the R4400-Indigo2 32 or
64 bit?

thanks again,
john.c

- --
/* John Clemens     http://www.rpi.edu/~clemej _/ "I Hate Quotes"       */
/* ICQ: 7175925     clemej@rpi.edu           _/    -- Samuel L. Clemens */ 
/* RPI Comp. Eng. 2000, Linux Parallel/Network/OS/Driver Specialist     */
