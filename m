Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6I3D1Rw013518
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 20:13:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6I3D1js013517
	for linux-mips-outgoing; Wed, 17 Jul 2002 20:13:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6I3CvRw013508
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 20:12:57 -0700
Received: from dea.linux-mips.net (shaft16-f92.dialo.tiscali.de [62.246.16.92]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAB04075
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 20:13:45 -0700 (PDT)
	mail_from (ralf@linux-mips.net)
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6HDxUT26639;
	Wed, 17 Jul 2002 15:59:30 +0200
Date: Wed, 17 Jul 2002 15:59:30 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: pread and pwrite
Message-ID: <20020717155930.A25258@dea.linux-mips.net>
References: <3D3532FB.E227A5AD@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3532FB.E227A5AD@mips.com>; from carstenl@mips.com on Wed, Jul 17, 2002 at 11:03:55AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 17, 2002 at 11:03:55AM +0200, Carsten Langgaard wrote:

> 
> Here there is some checking for sane values and a proper error value is
> return.
> I guess this routine is replaced, if we have the syscall implemented
> with the sysdeps/unix/sysv/linux/mips/pread.c file.
> Here there is no check for sane values, is there any reason why ?
> The same thing goes for pwrite.

The kernel does it's own error checking.  No need to duplicate that in
userspace.

  Ralf
