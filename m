Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LItGj09234
	for linux-mips-outgoing; Thu, 21 Feb 2002 10:55:16 -0800
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LItC909231
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 10:55:12 -0800
Received: from ocean.lucon.org ([12.234.16.87]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020221175507.LPDA2626.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Thu, 21 Feb 2002 17:55:07 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D60BF125C1; Thu, 21 Feb 2002 09:55:05 -0800 (PST)
Date: Thu, 21 Feb 2002 09:55:05 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
Message-ID: <20020221095505.A28496@lucon.org>
References: <3C745B0B.84203D3F@mvista.com> <20020221163436.76127.qmail@web11907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020221163436.76127.qmail@web11907.mail.yahoo.com>; from wgowcher@yahoo.com on Thu, Feb 21, 2002 at 08:34:36AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 21, 2002 at 08:34:36AM -0800, Wayne Gowcher wrote:
> Could anyone tell me if the 2.4.x kernel / redhat 7.1
> mipsel-linux distribution on the sgi ftp site supports
> posix threads ?

The threads works well with glibc compiled with -mips2. But the threads
in my RedHat 7.1 is broken when compiled with -mips2 :-(. I have fixed
it in glibc CVS.

> 
> In particular, I have a driver that I am trying to
> port from x86 that links against the libraries "-lm
> -lpthread" can anyone tell me what rpms I might find
> them in ?

It is the part of glibc.


H.J.
