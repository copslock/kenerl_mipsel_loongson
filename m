Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3BI77613137
	for linux-mips-outgoing; Wed, 11 Apr 2001 11:07:07 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3BI73M13124;
	Wed, 11 Apr 2001 11:07:03 -0700
Received: from google.engr.sgi.com ([163.154.53.18]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAB05416; Wed, 11 Apr 2001 11:07:02 -0700 (PDT)
	mail_from (kanoj@google.engr.sgi.com)
Received: (from kanoj@localhost)
	by google.engr.sgi.com (SGI-8.9.3/8.9.3) id LAA23131;
	Wed, 11 Apr 2001 11:00:16 -0700 (PDT)
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200104111800.LAA23131@google.engr.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
To: ralf@oss.sgi.com (Ralf Baechle)
Date: Wed, 11 Apr 2001 11:00:15 -0700 (PDT)
Cc: kanoj@oss.sgi.com (Kanoj Sarcar), linux-origin@oss.sgi.com,
   linux-mips@oss.sgi.com
In-Reply-To: <20010411093556.B1337@bacchus.dhis.org> from "Ralf Baechle" at Apr 11, 2001 09:35:56 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> 
> On Tue, Apr 10, 2001 at 03:42:48PM -0700, Kanoj Sarcar wrote:
> 
> > CVSROOT:	/home/pub/cvs
> > Module name:	linux
> > Changes by:	kanoj@oss.sgi.com	01/04/10 15:42:47
> > 
> > Modified files:
> > 	drivers/char   : serial.c 
> > 
> > Log message:
> > 	Fix the IP27 serial driver after the 2.4.3 merge. This is what you
> > 	need in /etc/inittab: "7:2345:respawn:/sbin/getty ttyS0 DT9600".
> > 	mingetty can also probably be made to work.
> 
> Mingetty starts ok but it's impossible to enter something.  This is caused
> by CREAD being cleared on the tty.  I don't know why this happens; it
> started in 2.4.3.
> 
>   Ralf
> 

receive_chars() was updated to look at ignore_mask ... if CREAD is not
set, around the time of opening via ioctls etc, it will not take inputs.
I haven't figured the details out, but I believe it is more of a *getty
config issue than anything else. 

Kanoj
