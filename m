Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f920A8D01391
	for linux-mips-outgoing; Mon, 1 Oct 2001 17:10:08 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f920A4D01380
	for <linux-mips@oss.sgi.com>; Mon, 1 Oct 2001 17:10:04 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9A30F125C8; Mon,  1 Oct 2001 17:10:03 -0700 (PDT)
Date: Mon, 1 Oct 2001 17:10:03 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Bug in pthread glibc 7.0 & 7.1
Message-ID: <20011001171003.A18883@lucon.org>
References: <CBD6266EA291D5118144009027AA63353F922A@xboi05.boi.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CBD6266EA291D5118144009027AA63353F922A@xboi05.boi.hp.com>; from roger_twede@hp.com on Mon, Oct 01, 2001 at 07:52:15PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 01, 2001 at 07:52:15PM -0400, TWEDE,ROGER (HP-Boise,ex1) wrote:
> 
> 
> The following code reveals a bug in the MIPS Gnu C Libraries available via
> ftp on oss.sgi.com (ftp.linux.sgi.com).
> 
> The bug is posix thread related and occurs when using the libc and
> libpthread versions available at:
> /pub/linux/mips/redhat/7.1/RPMS/mipsel/glibc*
> 
> The bug also appears to exist in:
> /pub/linux/mips/mipsel-linux/RedHat-7.0/RPMS/mipsel/glibc*
> 
> The bug does not exist in earlier versions of the pthread library, or on the
> non-MIPS (non-SGI) distributions.  (ie. RedHat 7.0 for ix86 does not exhibit
> a failure with this code, but RedHat 7.0/7.1 on mips does)
> 
> Upon failure the following code sequence will core dump (SEGV) instead of
> exiting normally.
> 
> 

On RedHat 7.1/mips:

# gcc pthread.c -o mips -lpthread -Wall
pthread.c: In function `StartFunction':
pthread.c:64: warning: unsigned int format, pointer arg (arg 3)
pthread.c:69: warning: unsigned int format, pointer arg (arg 3)
# ./mips
pid=21905 Init mutex
pid=21905 About to create thread: mythread
pid=21905 about to cond_wait for mythread init 1.
pid=21907 thread mutex locked at x7fff79c8
pid=21907 thread cond signal sent, unlocking at 0x7fff79c8
pid=21907 thread unlocked
pid=21905 back from cond_wait for mythread init 1.  result=0
pid=21907 yielded and back again
# rpm -q glibc
glibc-2.2.4-11.2


H.J.
