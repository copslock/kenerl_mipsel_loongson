Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2B0A9Y13194
	for linux-mips-outgoing; Sun, 10 Mar 2002 16:10:09 -0800
Received: from surfers.oz.agile.tv (fw.oz.agile.tv [210.9.52.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2B0A2913190
	for <linux-mips@oss.sgi.com>; Sun, 10 Mar 2002 16:10:03 -0800
Received: from liamlaptop (surfers.oz.agile.tv [192.168.16.1])
	by surfers.oz.agile.tv (8.11.6/8.11.2) with SMTP id g2AN8qE29918;
	Mon, 11 Mar 2002 09:08:52 +1000
Message-ID: <002301c1c887$e3815a50$0f1fa8c0@liamlaptop>
Reply-To: "Liam Davies" <ldavies@agile.tv>
From: "Liam Davies" <liam.davies@agile.tv>
To: "Pete Popov" <ppopov@mvista.com>,
   "Martin K. Petersen" <mkp@SunSITE.auc.dk>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
References: <1015611727.12994.441.camel@zeus> <yq1y9h2vp8c.fsf@austin.mkp.net> <1015632468.6456.24.camel@zeus>
Subject: Re: xfs
Date: Mon, 11 Mar 2002 09:04:09 +1000
Organization: AgileTV Corporation
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete,

>
> I took 1.0.2 patch and applied it against the latest linux_2_4 oss
> kernel.
I tried the same against 2.4.14, but had the same problems you
described below. I then tried the split-only and split-kernel patches from
the
2.4.14 XFS cvs snapshot, taken just before or after 1.0.2 release - no
changes required. Everything seems to be working dandy.

>
> I cross compiled the kernel with 2.95.3 based tools (I know the older
> toolchain is recommended but ...).  xfsprogs I compiled natively with
> the same version tools.
I haven't tried any compilers earlier that gcc 3.0, but 3.0.1 and 3.0.3
have both worked for me.

> The kernel boots and I was able to create an
> XFS file system on one of the partitions.  Mounting works. Unmounting
> consistently results in a crash, illegal access to location 0x00000018.
> It's probably easy to fix since it's 100% reproducible.  Back to
> mounting the fs -- I ran bonnie++ on it. It ran for quite a while until
> it got to the "sequential" write test and then the kernel froze.
I had both of these symptoms after applying the 1.0.2 patch in its
entirety.  After switching to split-kernel and split-only patches only
these things went away. I didn't delve any deeper.


Liam

------
Agile Tv
