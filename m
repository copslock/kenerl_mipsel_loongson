Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2HIe6E05151
	for linux-mips-outgoing; Sun, 17 Mar 2002 10:40:06 -0800
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2HIe2905148
	for <linux-mips@oss.sgi.com>; Sun, 17 Mar 2002 10:40:02 -0800
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020317184126.JUYU2626.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Sun, 17 Mar 2002 18:41:26 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4B83C125C7; Sun, 17 Mar 2002 10:41:25 -0800 (PST)
Date: Sun, 17 Mar 2002 10:41:24 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Hartvig Ekner <hartvige@mips.com>
Cc: user alias <linux-mips@oss.sgi.com>
Subject: Re: Compiler problem in glibc
Message-ID: <20020317104124.A4002@lucon.org>
References: <200203171052.g2HAqGb27844@coplin09.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203171052.g2HAqGb27844@coplin09.mips.com>; from hartvige@mips.com on Sun, Mar 17, 2002 at 11:52:15AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 17, 2002 at 11:52:15AM +0100, Hartvig Ekner wrote:
> I have found a problem in glibc caused by the gcc-2.96-99.1 compiler
> from H.J's miniport.
> 
> in the exp() function (file w_expf.c), there is code like: 
> 
> #ifdef __STDC__
>         float __expf(float x)           /* wrapper expf */
> #else
>         float __expf(x)                 /* wrapper expf */
>         float x;
> #endif
> {
> #ifdef _IEEE_LIBM
>         return __ieee754_expf(x);
> #else
>         float z;
>         z = __ieee754_expf(x);
>         if(_LIB_VERSION == _IEEE_) return z;
> 
>         if(__finitef(x)) {
>             if(x>o_threshold)
> 
> 
> (IEEE_LIBM is not set). Note that there are two function calls (ieee754_expf
> and finitef()) followed by a FP if-statement (x>o_threshold). This 
> translates into:
> 

I believe it has been reported before and is fixed in gcc 3.1 at the
time.


H.J.
