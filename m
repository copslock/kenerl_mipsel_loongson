Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78FWCL15489
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:32:12 -0700
Received: from fe170.worldonline.dk (fe170.worldonline.dk [212.54.64.199])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78FWBV15486
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:32:11 -0700
Received: (qmail 12894 invoked by uid 0); 8 Aug 2001 15:31:18 -0000
Received: from 213.237.49.98.skovlyporten.dk (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe170.worldonline.dk with SMTP; 8 Aug 2001 15:31:18 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id 218933D9B; Wed,  8 Aug 2001 17:31:58 +0200 (CEST)
Date: Wed, 8 Aug 2001 17:31:58 +0200
From: Lars Munch Christensen <c948114@student.dtu.dk>
To: Shuanglin Wang <swang@mmc.atmel.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: How to build a kernel for the malta board?
Message-ID: <20010808173157.B868@tuxedo.skovlyporten.dk>
References: <3B71649E.95BEEFCD@mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B71649E.95BEEFCD@mmc.atmel.com>; from swang@mmc.atmel.com on Wed, Aug 08, 2001 at 11:11:10AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 11:11:10AM -0500, Shuanglin Wang wrote:
> I want to compile Linux Kernel (2.4.3) for a Malta board.  I downloaded
> both MIPS Linux distribution and cross-compiler tools. Now, the problem
> is how to configure the Linux kernel  for malta boards.

If you got the kernel from the MIPS ftp site, you will see a
file called .config.malta in the root of the source tree. This
is a good starting point for configuring the kernel for the Malta 
board.

Regards
-- Lars Munch  
