Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2917UE15166
	for linux-mips-outgoing; Fri, 8 Mar 2002 17:07:30 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2917Q915161
	for <linux-mips@oss.sgi.com>; Fri, 8 Mar 2002 17:07:26 -0800
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id AAA25981;
	Sat, 9 Mar 2002 00:18:07 -0800
Subject: Re: xfs
From: Pete Popov <ppopov@mvista.com>
To: "Martin K. Petersen" <mkp@SunSITE.auc.dk>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <yq1y9h2vp8c.fsf@austin.mkp.net>
References: <1015611727.12994.441.camel@zeus> 
	<yq1y9h2vp8c.fsf@austin.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 08 Mar 2002 16:07:48 -0800
Message-Id: <1015632468.6456.24.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2002-03-08 at 11:22, Martin K. Petersen wrote:
> >>>>> "Pete" == Pete Popov <ppopov@mvista.com> writes:
> 
> Pete> I see on SGI's web site that XFS is supported only on x86 and
> Pete> IA64. Has anyone tried it on mips?
> 
> We did some Linux/XFS testing on an Origin 2000 about a year ago.
> Don't think anyone has tried it since then.
> 
> But it should Just Work<tm>.  Let us know if it doesn't.

I took 1.0.2 patch and applied it against the latest linux_2_4 oss
kernel. Actually, it's the latest oss plus additional patches I've sent
to Ralf, but I think those are stable.  The patch did not apply cleanly
but the problems were easy to fix.  I didn't port the additional x86
syscalls because they appear to be attribute/acl related only.  

I cross compiled the kernel with 2.95.3 based tools (I know the older
toolchain is recommended but ...).  xfsprogs I compiled natively with
the same version tools.  The kernel boots and I was able to create an
XFS file system on one of the partitions.  Mounting works. Unmounting
consistently results in a crash, illegal access to location 0x00000018. 
It's probably easy to fix since it's 100% reproducible.  Back to
mounting the fs -- I ran bonnie++ on it. It ran for quite a while until
it got to the "sequential" write test and then the kernel froze.

If I get to play with it some more, I'll send you any useful info I
might have.

Pete
