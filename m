Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OLOll06020
	for linux-mips-outgoing; Wed, 24 Oct 2001 14:24:47 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OLOiD06017
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 14:24:44 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9OLQjB14950;
	Wed, 24 Oct 2001 14:26:45 -0700
Message-ID: <3BD73196.CA3DFF9@mvista.com>
Date: Wed, 24 Oct 2001 14:24:38 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: I am looking for a mips machine
References: <20011024080356.A2440@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> Hi,
> 
> I am looking for a mips machine to continue working on my mips port
> of RedHat. My requirements are
> 
> 1. It has the stable, up to date kernel support. That means I can do
> 
> # ./configure
> # make bootstrap
> # make check
> 
> for gcc 3.1 without a kernel oops.
> 
> 2. It has decent CPU. I hate to wait a day for
> 
> # make bootstrap
> 
> 3. Inexpensive.
> 
> 4. Support serial console.
> 
> 5. Little endian is preferred.
> 
> Does anyone have any recommendations?
> 

It appears Malta from MIPS and Ocelot Dev box from Momentum should fit your
need.  I think both would cost about $3000 a piece though.

Jun
