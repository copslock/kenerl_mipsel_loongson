Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9PMPdY07006
	for linux-mips-outgoing; Thu, 25 Oct 2001 15:25:39 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9PMPc007003
	for <linux-mips@oss.sgi.com>; Thu, 25 Oct 2001 15:25:38 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B6F65125CD; Thu, 25 Oct 2001 15:25:32 -0700 (PDT)
Date: Thu, 25 Oct 2001 15:25:32 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RedHat 7.1/mips update
Message-ID: <20011025152532.A32043@lucon.org>
References: <20011024121646.A6520@lucon.org> <20011025151506.A13071@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011025151506.A13071@idiom.com>; from espin@idiom.com on Thu, Oct 25, 2001 at 03:15:06PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 25, 2001 at 03:15:06PM -0700, Geoffrey Espin wrote:
> 
>  mipsel-linux-gcc ...
>  Assembler messages:  
>  Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.
>  Warning: The -march option is incompatible to -mipsN and therefore ignored.

It is intentional. Do what the message says. I only have to check my
arch/mips/Makefile from -mcpu=xxx to -mtune=xxx.


H.J.
