Received:  by oss.sgi.com id <S305157AbQAMV1E>;
	Thu, 13 Jan 2000 13:27:04 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:38162 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAMV0m>;
	Thu, 13 Jan 2000 13:26:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA12365; Thu, 13 Jan 2000 13:23:44 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA36747
	for linux-list;
	Thu, 13 Jan 2000 13:15:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA36179;
	Thu, 13 Jan 2000 13:15:48 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id NAA23872;
	Thu, 13 Jan 2000 13:15:36 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14462.16504.84215.298070@liveoak.engr.sgi.com>
Date:   Thu, 13 Jan 2000 13:15:36 -0800 (PST)
To:     eak@sgi.com
Cc:     Vince Weaver <weave@eng.umd.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: identifying sgi system type under Linux
In-Reply-To: <387E2510.43D52D70@detroit.sgi.com>
References: <Pine.GSO.4.21.0001131258320.25401-100000@z.glue.umd.edu>
	<387E2510.43D52D70@detroit.sgi.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Eric Kimminau writes:
 > Vince Weaver wrote:
 > > 
 > > Hello again
 > > 
 > > I was trying to see if I could get this Indigo2 to display that it is an
 > > Indigo2 under /proc/cpuinfo [instead of current behavior, which assumes
 > > all SGI's are indy's].
 > >
 > > Is it possible to figure out what system type it is from this info?  Is
 > > there another way to find out sgi system type?  Or is this just not
 > > possible?
...
 > The problem is that IP22 could be an Indy or an Indigo/2. Even under
 > IRIX if you run hinv it doesn't tell you that a system is an Indy or
 > an Indigo/2. Your only clues come from knowing additional bits about
 > what is or is not Indy or I2 hardware.  For example you would never
 > see Impact graphics on an Indy and you would never see an Indy 8-bit
 > graphics board on an Indigo/2 (although there were 8 bit boards on an
 > Indigo/2 - I have been looking aorund internally to see if I can find
 > one to see what it actually reports at command monitor for graphics).
 > Further confusion would be to try and identify an older Indigo with an
 > R4000 upgrade from an Indy.

      One key difference is that Indigo2 always has an EISA bus and
Indy never does.  

      Note that the Linux kernel (like the IRIX kernel) has a way of
detecting the difference, since it needs to know which box it is
running on, so you could just get the kernel to export the data via
/proc somewhere.  The kernel variable "sgi_guiness" is 1 if the system
is an Indy ("Guinness") and 0 if the system is an Indigo2
("FullHouse").  Look at the file indy_hpc.c to see how this is detected.
