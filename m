Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EHRQ201145
	for linux-mips-outgoing; Fri, 14 Sep 2001 10:27:26 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EHRPe01142
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 10:27:25 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f8EHRLuI025376;
	Fri, 14 Sep 2001 10:27:21 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f8EHRKvM025372;
	Fri, 14 Sep 2001 10:27:20 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 14 Sep 2001 10:27:20 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix offset of mmap
In-Reply-To: <20010914101549.A16156@lucon.org>
Message-ID: <Pine.LNX.4.10.10109141024170.20461-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > I believe this would break certain pieces of hardware. For example the
> > mq200 framebuffer in the sigmarion is not paged aligned. You have to
> > supply a offset to make it work.
> 
> How do you mmap a memory whose offset is not page aligned? The code
> here is
> 
> return do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> 					    ^^^^^^^^^^^^^^^^^^^^
> 
> It is up to the user code to make sure everything is ok.

Sorry. Mix up in the meaning of offset. 
