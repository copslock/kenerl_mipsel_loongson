Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03Mrg830552
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:53:42 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03Mrbg30546;
	Thu, 3 Jan 2002 14:53:37 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 53DF0125C8; Thu,  3 Jan 2002 13:53:34 -0800 (PST)
Date: Thu, 3 Jan 2002 13:53:34 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: binutils bug workaround
Message-ID: <20020103135334.A3978@lucon.org>
References: <Pine.LNX.4.21.0201032241030.8906-200000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201032241030.8906-200000@melkor>; from vivien.chappelier@enst-bretagne.fr on Thu, Jan 03, 2002 at 10:44:30PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 03, 2002 at 10:44:30PM +0100, Vivien Chappelier wrote:
> Hi,
> 
> 	There is a binutils bug (as) which produces bad addresses when
> getting the address of a struct member for initializing the same struct,
> and when there is data or static functions declared before:
> int test = 0xdeadbeef;
> 
> struct {
>         int dummy;
>         void *ptr;
> } bug =
> {
>   ptr:  &bug.ptr
> };
> 
> will produce bad value for bug.ptr.
> 
> 	This patch move the declaration of kswapd_wait as a workaround to
> this compiler bug. This probably affects all mips64 kernels.
> 

Shouldn't you fix the assmbler instead?


H.J.
