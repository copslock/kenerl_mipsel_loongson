Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MISfg02738
	for linux-mips-outgoing; Sun, 22 Jul 2001 11:28:41 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MISeV02735
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 11:28:40 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id DAB8A125BA; Sun, 22 Jul 2001 11:28:38 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id EA0B0EC2D; Sun, 22 Jul 2001 11:28:37 -0700 (PDT)
Date: Sun, 22 Jul 2001 11:28:37 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Steve Papacharalambous <stevep@lineo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Interrupts in modules
Message-ID: <20010722112837.A22440@lucon.org>
References: <3B59FC0D.6CAD443C@lineo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B59FC0D.6CAD443C@lineo.com>; from stevep@lineo.com on Sat, Jul 21, 2001 at 11:02:53PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 11:02:53PM +0100, Steve Papacharalambous wrote:
> Hi All,
> 
> Are there any limitations or precautions needed with interrupt handlers
> in loadable modules?
> 
> The reason for asking is that I have an interrupt handler which works
> fine when compiled into the kernel, but causes the kernel to crash when
> it is a loadable module,

There are some gas bugs which may generate the bad binary code. It
happened to me with the tulip driver. The current Linux binutils
should be ok.


H.J.
