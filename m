Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FKefK08086
	for linux-mips-outgoing; Fri, 15 Feb 2002 12:40:41 -0800
Received: from dea.linux-mips.net (a1as10-p172.stg.tli.de [195.252.189.172])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FKeb908059
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 12:40:38 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1FJapp20048;
	Fri, 15 Feb 2002 20:36:51 +0100
Date: Fri, 15 Feb 2002 20:36:51 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: SGI Question
Message-ID: <20020215203651.A6491@dea.linux-mips.net>
References: <000901c1b652$146680c0$631510ac@delllaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000901c1b652$146680c0$631510ac@delllaptop>; from robru@teknuts.com on Fri, Feb 15, 2002 at 10:53:38AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 10:53:38AM -0800, Robert Rusek wrote:

> Is it possible to build a linux root from within IRIX?  I created an efs
> partition on a new drive.  Can I build the root on the new drive then
> point to it from my Linux kernel?

Not really.  Linux has only read-only support for EFS filesystems.

>  If not, is there any benefit of running a dual os on the system?

You have twice as many possibilities to get angry about an OS ;-)

  Ralf
> 
