Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PDqKRw004193
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 06:52:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PDqK6H004192
	for linux-mips-outgoing; Thu, 25 Jul 2002 06:52:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f67.dialo.tiscali.de [62.246.16.67])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PDqERw004183
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 06:52:15 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6PDr3J11563;
	Thu, 25 Jul 2002 15:53:03 +0200
Date: Thu, 25 Jul 2002 15:53:03 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Seeger <sseeger@stellartec.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: kernel BUG at slab.c:1073!
Message-ID: <20020725155303.A3636@dea.linux-mips.net>
References: <3D3EFCDE.5050503@mvista.com> <011101c233d3$bab16860$3501a8c0@wssseeger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <011101c233d3$bab16860$3501a8c0@wssseeger>; from sseeger@stellartec.com on Thu, Jul 25, 2002 at 05:06:37AM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.9 required=5.0 tests=IN_REP_TO,PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 25, 2002 at 05:06:37AM -0700, Steven Seeger wrote:

> I had this problem when trying to run a module compiled for kernel version
> 2.4.18 on the old 2.4.0-test9 VR kernel. Something to do with different flag
> values I think. A recompile with links to the proper kernel sources solved
> the problem. Kmalloc was causing the issue. The flag value of GFP_KERNEL was
> different or something.

Normally CONFIG_MODVERSIONS is supposed to avoid such accidents.

  Ralf
