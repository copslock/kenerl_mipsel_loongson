Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MJM5U08105
	for linux-mips-outgoing; Thu, 22 Mar 2001 11:22:05 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MJM4M08102
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 11:22:05 -0800
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 178F8109CE; Thu, 22 Mar 2001 11:22:29 -0800 (PST)
Date: Thu, 22 Mar 2001 11:22:29 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: nick@snowman.net
Cc: Justin Carlson <carlson@sibyte.com>, linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
Message-ID: <20010322112229.A5617@foobazco.org>
References: <01032211025209.20180@plugh.sibyte.com> <Pine.LNX.4.21.0103221402430.19179-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103221402430.19179-100000@ns>; from nick@snowman.net on Thu, Mar 22, 2001 at 02:03:43PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 22, 2001 at 02:03:43PM -0500, nick@snowman.net wrote:

> (It sorta produces useable code... usually..... on tuesdays... if it's a
> blue moon)

gcc 3.0 for mips64 requires hacks to even accept the arguments the
kernel compile wants to give, and even then it reliably produces
extremely incorrect code.  For example:

int i = 0;
prom_printf ("%d", i);

Might yield something like

-14777223

- basically, anything but 0.  The code that causes this is horribly
wrong that it wasn't even worth looking at.  There are all sorts of
similar, related, and dissimilar problems.

On the other hand, the same compiler for mips (not 64) reliably
produces working 2.4 kernels...

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
