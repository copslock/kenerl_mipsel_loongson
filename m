Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBKIGGw15694
	for linux-mips-outgoing; Thu, 20 Dec 2001 10:16:16 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBKIGEX15691
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 10:16:14 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id JAA08410;
	Thu, 20 Dec 2001 09:16:01 -0800
Date: Thu, 20 Dec 2001 09:16:01 -0800
From: Jun Sun <jsun@mvista.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: an old FPU context corruption problem when signal happens
Message-ID: <20011220091601.A8386@mvista.com>
References: <3C21390A.FA23978D@mvista.com> <3C219A3B.6DA93A75@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C219A3B.6DA93A75@mips.com>; from carstenl@mips.com on Thu, Dec 20, 2001 at 08:58:51AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 20, 2001 at 08:58:51AM +0100, Carsten Langgaard wrote:
> Are you sure this hasn't been fix in the latest sources (2.4.16) ?
> I have send a patch to Ralf, which I believe solves a similar problem as you describe below.
> 
> Ralf have you applied the patch ?
> 

Apparently not.  My patch is against the latest 2.4.16 tree,
which should also applies to 2.5 tree.

BTW, does my fix look reasonable?  What is your fix?  There are several
places which are tricky.

Jun
