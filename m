Received:  by oss.sgi.com id <S305157AbQAMXlg>;
	Thu, 13 Jan 2000 15:41:36 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:65333 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAMXlQ>;
	Thu, 13 Jan 2000 15:41:16 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03564; Thu, 13 Jan 2000 15:42:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA27898
	for linux-list;
	Thu, 13 Jan 2000 15:32:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA33296;
	Thu, 13 Jan 2000 15:32:42 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id PAA01535;
	Thu, 13 Jan 2000 15:32:31 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14462.24718.670816.841437@liveoak.engr.sgi.com>
Date:   Thu, 13 Jan 2000 15:32:30 -0800 (PST)
To:     John Michael Clemens <clemej@rpi.edu>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
In-Reply-To: <Pine.SOL.3.96.1000113144736.4279E-100000@rcs-sun1.rpi.edu>
References: <Pine.SOL.3.96.1000113144736.4279E-100000@rcs-sun1.rpi.edu>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

John Michael Clemens writes:
 > 
 > I too have been working on getting my Indigo2 to boot... and now that I
 > seem to have mine working as well, I can move on to actually helping.  
 > 
 > Now that the EISA stuff is in the kernel, should it now be possible to
 > write video drivers (framebuffers, console drivers, X servers) for the
 > Indigo2's???.. Having said that, I have GR3-Elan (XZ) graphics on mine,
 > can someone tell me where I can find the specs to start hacking up at
 > least a framebuffer for this?  techpubs.sgi.com doesn't seem to have much
 > info... is this info even availabe to those outside for SGI?

       Basically, XZ hardware documentation is not available outside SGI.
We have agreement inside SGI to provide some information, if a volunteer
inside SGI appears to track it down, but no volunteer so far.  The problem
is that the hardware interface is quite complex, and some of what one
thinks of as hardware is really firmware, a basic version of which is
downloaded by the PROM at startup time.  An X server could rely on the
PROM-loaded firmware, but it still takes quite a bit of code to set up
the hardware.  Note that XZ, like Newport graphics on Indy, does not
have a CPU-addressable frame buffer, so you have to use the rendering interface.
