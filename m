Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UGjgnC019637
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 09:45:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UGjgd0019636
	for linux-mips-outgoing; Thu, 30 May 2002 09:45:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UGjenC019631
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 09:45:40 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4UGj5U22541;
	Thu, 30 May 2002 09:45:05 -0700
Date: Thu, 30 May 2002 09:45:05 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: pcnet32.c bug?
Message-ID: <20020530094505.B22531@ayrnetworks.com>
References: <3CF4B1A1.3000607@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3CF4B1A1.3000607@murphy.dk>; from brian@murphy.dk on Wed, May 29, 2002 at 12:46:57PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 12:46:57PM +0200, Brian Murphy wrote:
> If I don't apply the following patch to pcnet32.c then the network 
> connection
> on my vr5000 box is extremely jerky. It also seems quite sensible to have a
> dma sync operation here.

Yes, that should be there by all means. We had to add that exact same
line to get our pcnet32 working on MIPS.

Thanks,
William
