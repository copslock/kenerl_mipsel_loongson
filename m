Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2IFeln31661
	for linux-mips-outgoing; Mon, 18 Mar 2002 07:40:47 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2IFei931658
	for <linux-mips@oss.sgi.com>; Mon, 18 Mar 2002 07:40:45 -0800
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16mzGs-0000oY-00; Mon, 18 Mar 2002 16:42:02 +0100
Date: Mon, 18 Mar 2002 16:42:02 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Toolchain question
Message-ID: <20020318154202.GA3092@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	SGI MIPS list <linux-mips@oss.sgi.com>
References: <20020317203406.GG25044@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020317203406.GG25044@lug-owl.de>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 17, 2002 at 09:34:06PM +0100, Jan-Benedict Glaw wrote:
> 
> Which cross compiler and binutils are currently known to be good for
> kernel compilation? I'm (for both LE and BE) currently still using
> this gcc-3.0 snapshot from the simple/crossdev "package". It's a
> bit old, but working quite good.
> 
> What compiler/binutils are currently advisable? Current CVS from
> binutils, current gcc 3.0 branch from CVS?

I'm using binutils-2.12.90.0.1 and gcc-2.95.4-debian, which
was recommended here. Read the the thread on "gcc include strangeness"
around Feb. 11 for details.


Regards,
Johannes
