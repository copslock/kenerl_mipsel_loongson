Received:  by oss.sgi.com id <S553972AbRAaQDb>;
	Wed, 31 Jan 2001 08:03:31 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:5392 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553682AbRAaQDX>;
	Wed, 31 Jan 2001 08:03:23 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0C3797F9; Wed, 31 Jan 2001 17:03:11 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 27560EE9C; Wed, 31 Jan 2001 16:52:46 +0100 (CET)
Date:   Wed, 31 Jan 2001 16:52:46 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Filesystem corruption
Message-ID: <20010131165246.B32399@paradigm.rfc822.org>
References: <3A781F33.6B28D19C@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A781F33.6B28D19C@mips.com>; from carstenl@mips.com on Wed, Jan 31, 2001 at 03:20:35PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 31, 2001 at 03:20:35PM +0100, Carsten Langgaard wrote:
> 
> Has anyone seen problems with fsck on the latest 2.4.0 kernel ?
> My filesystem gets corrupted from time to time when I use the latest
> 2.4.0 kernel.
> 

Hmm - nope - 2.4.0 Bigendian here 

resume:~# uptime
 3:50pm  up 6 days, 10 min,  1 user,  load average: 0.00, 0.00, 0.00
resume:~# uname -a
Linux resume.rfc822.org 2.4.0 #3 Thu Jan 25 16:25:23 CET 2001 mips unknown

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
