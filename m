Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EHFp200956
	for linux-mips-outgoing; Fri, 14 Sep 2001 10:15:51 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EHFoe00953
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 10:15:50 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 61947125C3; Fri, 14 Sep 2001 10:15:49 -0700 (PDT)
Date: Fri, 14 Sep 2001 10:15:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix offset of mmap
Message-ID: <20010914101549.A16156@lucon.org>
References: <20010914100700.A16047@lucon.org> <Pine.LNX.4.10.10109141009260.20461-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10109141009260.20461-100000@transvirtual.com>; from jsimmons@transvirtual.com on Fri, Sep 14, 2001 at 10:10:58AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 14, 2001 at 10:10:58AM -0700, James Simmons wrote:
> 
> > We should check if offset of mmap is on the page boundary.
> 
> I believe this would break certain pieces of hardware. For example the
> mq200 framebuffer in the sigmarion is not paged aligned. You have to
> supply a offset to make it work.

How do you mmap a memory whose offset is not page aligned? The code
here is

return do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
					    ^^^^^^^^^^^^^^^^^^^^

It is up to the user code to make sure everything is ok.


H.J.
