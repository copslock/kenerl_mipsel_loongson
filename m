Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OIJaY23176
	for linux-mips-outgoing; Wed, 24 Oct 2001 11:19:36 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OIJXD23172
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 11:19:33 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9OIJSE0014546;
	Wed, 24 Oct 2001 11:19:28 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9OIJRHI014540;
	Wed, 24 Oct 2001 11:19:27 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 24 Oct 2001 11:19:27 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: I am looking for a mips machine
In-Reply-To: <20011024080356.A2440@lucon.org>
Message-ID: <Pine.LNX.4.10.10110241118420.10287-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


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

I use a Cobalt Qube for alot of my developement. It works fine. I know it
is not in Ralph's tree yet but I plan to send him my work soon.
