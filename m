Received:  by oss.sgi.com id <S554109AbRARDHz>;
	Wed, 17 Jan 2001 19:07:55 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:57608 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554104AbRARDHl>;
	Wed, 17 Jan 2001 19:07:41 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1E91B7FB; Thu, 18 Jan 2001 04:07:38 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B5319F598; Thu, 18 Jan 2001 04:08:10 +0100 (CET)
Date:   Thu, 18 Jan 2001 04:08:10 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ian Chilton <ian@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010118040810.B15780@paradigm.rfc822.org>
References: <20010117175227.A29978@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117175227.A29978@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Wed, Jan 17, 2001 at 05:52:27PM +0000
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 05:52:27PM +0000, Ian Chilton wrote:
> Hello,
> 
> > BTW: Is there any way of deleteing/renaming files in the
> > volume-header-directory ? Is there a way to set "bootfile" ?
> 
> You could do what I do with my tftp boot directory.
> 
> Bootp or whatever points to vmlinux-hostname.
> 
> vmlinux-hostname is a symlink to a kernel.
> 
> Changing kernels is just a matter of changing the symlink.

I do that for a couple of years now for all architectures capable
of netbooting - Nothing new. But as you could read up there
i asked something completely different. I want to boot of DISK !
And i asked questions about dvhtool not tftp and symlinks.

Not my day ...
Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
