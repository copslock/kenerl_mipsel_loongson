Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0E6Djq24312
	for linux-mips-outgoing; Sun, 13 Jan 2002 22:13:45 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0E6DVg24301
	for <linux-mips@oss.sgi.com>; Sun, 13 Jan 2002 22:13:37 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g0E5DNc07128
	for linux-mips@oss.sgi.com; Sun, 13 Jan 2002 21:13:23 -0800
Date: Sun, 13 Jan 2002 21:13:23 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: linux-mips@oss.sgi.com
Subject: MIPS64 status?
Message-ID: <20020113211323.A7115@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

So, lots of people are asking me about 64-bit support for MIPS Linux.  And
this is something I think I know, but I'm not sure.  And before I go
spreading any more bad data, I thought I'd ask the experts. :)

As I understand it, 64-bit support is really two different things:  64-bit
data path (i.e. unsigned long long) and 64-bit addressing (for more than 4G
of RAM).

My understanding is that "MIPS64" generally refers to a kernel which
supports a 64-bit data path, but we're still limited to 32-bit addressing.
Is that correct?

I suspect that this is very much a toolchain issue, as I don't think gcc
will generate 64-bit addressing code.

Comments?  Corrections?  Smack-downs? :)

Matt

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
