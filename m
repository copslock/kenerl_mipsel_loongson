Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id AAA294485; Fri, 11 Jul 1997 00:57:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA13583 for linux-list; Fri, 11 Jul 1997 00:57:41 -0700
Received: from refugee.engr.sgi.com (fddi-refugee.engr.sgi.com [192.26.75.26]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA13578; Fri, 11 Jul 1997 00:57:38 -0700
Received: from refugee.engr.sgi.com (localhost [127.0.0.1]) by refugee.engr.sgi.com (970321.SGI.8.8.5/970502.SGI.AUTOCF) via ESMTP id AAA21125; Fri, 11 Jul 1997 00:57:37 -0700 (PDT)
Message-Id: <199707110757.AAA21125@refugee.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@cthulhu.engr.sgi.com
In-reply-to: Message from miguel@nuclecu.unam.mx of 10 Jul 1997 23:28:17 CDT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Jul 1997 00:57:37 -0700
From: Steve Alexander <sca@refugee.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza <miguel@nuclecu.unam.mx> writes:
>   I have a new question for all of you lucky STREAMS experts.  Ok,
>the thing is, I am not familiar with STREAMS at all, so I am not quite
>sure at what to do next.

To paraphrase Michael Stipe, "STREAMS, they complicate my life."

>   What is the ioctl (fd, I_STR, XXXX) thing supposed to do with a
>STREAM file handle?  I just can't find any documentation on what this
>is for. 

I_STR is the catch-all ioctl.  What it means is that some random, device-
specific ioctl is being sent down.  The way that this works is that the app.
fills in a structure, and then magic happens.  The third argument to ioctl()
is a 'strioctl' structure, which is defined in <sys/stropts.h>.

For example, suppose my STREAMS driver supported a "panic the system" ioctl.
Suppose, too, that this ioctl took an argument which was the message to print
out, e.g., "eat me."

The app would have code which did something like:

	#define SYS_PANIC 0xbadd0g
	struct strioctl si;
	char *foo = "eat me";
	int fd, r;

	si.ic_cmd = SYS_PANIC;
	si.ic_dp = foo;
	si.ic_len = strlen(foo);
	si.ic_timout = INFTIM;		/* infinite time out */

	fd = open("/dev/strcrash", O_RDWR);
	r = ioctl(fd, I_STR, (char *)&si);

Meanwhile, in the kernel...

The data area pointed to by si gets converted into a two-part STREAMS message:

The first part is a block containing an 'iocblk' structure, which has the
command and a length, etc...  The continuation pointer (b_cont) of the first
block points to the data portion (i.e. ic_dp), which in this case is the string 
pointed to by 'foo'.  The length of the first block is sizeof(struct iocblk)
and the length of the second block is strlen(foo).  The data is pointed to by
the 'read pointer' (b_rptr) field of the message block structure.  This leads
to code similar to the following:

/* write put procedure for STREAMS crash driver */
stc_wput(queue_t *q, mblk_t *bp)
{
	struct iocblk *ioc;

	/* determine message type */
	switch (bp->b_type) {
	case ...
	case M_IOCTL:			/* it's an ioctl message */
		ioc = (struct iocblk *)bp->b_rptr;
		/* what command */
		switch (ioc->ioc_cmd) {
		case SYS_PANIC:
			ASSERT(bp->b_cont);
			cmn_err(CE_PANIC, bp->b_cont->b_rptr);
		}
		default:
			ioc->ioc_error = ENOTTY;
			freemsg(bp->b_cont);	/* safe to call with NULL*/
			bp->b_cont = 0;
			qreply(q, bp);
	}
	...
}

So, basically, without cracking the M_IOCTL message, you can't figure out what
to do with an I_STR; it's completely driver-specific.  (streamio(7) gives some
info; the USL manual called "Programmer's Guide: STREAMS" has way more than you
want to know).  STREAMS sucks.  Trust me; I did STREAMS TCP/IP for 8 years.

-- Steve
