Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1N7Be600692
	for linux-mips-outgoing; Fri, 22 Feb 2002 23:11:40 -0800
Received: from rwcrmhc53.attbi.com (rwcrmhc53.attbi.com [204.127.198.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1N7Bb900686
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 23:11:37 -0800
Received: from ocean.lucon.org ([12.234.16.87]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020223061131.LBYD2951.rwcrmhc53.attbi.com@ocean.lucon.org>;
          Sat, 23 Feb 2002 06:11:31 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D4F52125C1; Fri, 22 Feb 2002 22:11:28 -0800 (PST)
Date: Fri, 22 Feb 2002 22:11:28 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: pthread support in mipsel-linux
Message-ID: <20020222221128.A28938@lucon.org>
References: <200202230415.g1N4FI930898@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202230415.g1N4FI930898@oss.sgi.com>; from fxzhang@ict.ac.cn on Sat, Feb 23, 2002 at 11:12:06AM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Feb 23, 2002 at 11:12:06AM +0800, Zhang Fuxin wrote:
> hi,
> 
> >
> >Mutex is now implemented with spin lock by default. BTW, how many
> >people have run "make check" on glibc compiled -mips1?
> I did with glibc-2.2.4 natively compiled,no failure till libm-test

The linuxthreads test comes after math.

> (i configured it by default,then it used -mips1?)
> 

Yes. BTW, I found the ll/sc bug by doing "make check" on gcc 3.1 in
CVS.


H.J.
