Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15NigY24816
	for linux-mips-outgoing; Tue, 5 Feb 2002 15:44:42 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15NicA24813
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 15:44:38 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A73B4125C8; Tue,  5 Feb 2002 15:44:37 -0800 (PST)
Date: Tue, 5 Feb 2002 15:44:37 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: another gcc optimization bug?
Message-ID: <20020205154437.A9605@lucon.org>
References: <200202051457.g15EvfA12401@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202051457.g15EvfA12401@oss.sgi.com>; from fxzhang@ict.ac.cn on Tue, Feb 05, 2002 at 10:54:42PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 10:54:42PM +0800, Zhang Fuxin wrote:
> hi,
>     It seems gcc with optimization > -O2 will produce incorrect code for fp code:
> I find this example when tracking down the libm-test failures.
>   ( expf(NaN) == NaN will report an extra "invalid operation" exception )
> The faulting code snippet is:
> 	float __my_expf(float x)		/* wrapper expf */
> {
> 	float z;
> 	unsigned int hx;
> 	z = __ieee754_expf(x);
> 	if(_LIB_VERSION == _IEEE_) return z;
> 	if(__finitef(x)) {
> 	    if(x>o_threshold)
> 		return 1.0;
> 	    else if(x<u_threshold)
> 		return 2.0;
>             printf("haha\n");
> 	} 
> 	return z;
> }
> 
> with -O2(or higher),some statements inside "if (__finitef(x))" are put before
> testing the return value of __finitef(x),one of which is a c.lt.s that cause
> the extra "invalid operation" exception being raised.
> 

This bug seem fixed in gcc 3.1.


H.J.
