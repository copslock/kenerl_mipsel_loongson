Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PHYqQ21981
	for linux-mips-outgoing; Mon, 25 Feb 2002 09:34:52 -0800
Received: from dea.linux-mips.net (a1as16-p206.stg.tli.de [195.252.192.206])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PHYm921978
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 09:34:48 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1PGYXW03690;
	Mon, 25 Feb 2002 17:34:33 +0100
Date: Mon, 25 Feb 2002 17:34:33 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Hartvig Ekner <hartvige@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020225173433.B3680@dea.linux-mips.net>
References: <200202251516.QAA22570@copsun18.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202251516.QAA22570@copsun18.mips.com>; from hartvige@mips.com on Mon, Feb 25, 2002 at 04:16:20PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 04:16:20PM +0100, Hartvig Ekner wrote:

>         .globl ENTRY_POINT
>         .type ENTRY_POINT,@function
> ENTRY_POINT:
> #ifdef __PIC__
>         SET_GP
> #else
>         la  $28, _gp
> #endif
> 
> Makes things work (this code ends in crt1.o). Is this the right place to 
> fix it?

Non-PIC code doesn't use $gp, so any reference to $gp is a bug.  Note
that we don't support global data optimization for ELF either that is,
-G 0 is the default.

  Ralf
