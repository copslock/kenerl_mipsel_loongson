Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OAoq723081
	for linux-mips-outgoing; Thu, 24 Jan 2002 02:50:52 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OAooP23074
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 02:50:50 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g0O9og129966
	for linux-mips@oss.sgi.com; Thu, 24 Jan 2002 01:50:42 -0800
Date: Thu, 24 Jan 2002 01:50:42 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: linux-mips@oss.sgi.com
Subject: Does anyone know how HHL boots?
Message-ID: <20020124015042.B29933@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm somewhat curious...

MontaVista has HHL support for several MIPS boards... including one that my
company makes.  We've never actually seen their HHL distribution for our
board, tho... and we're wondering, how does it boot?

I mean, our boards have an elementary boot loader that can load a kernel
from the network, and disk-booting is something we're trying to figure out.
But how does HHL accomplish this?  And is it a general solution for
multiple platforms?

Matt

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
