Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14N2dd19186
	for linux-mips-outgoing; Mon, 4 Feb 2002 15:02:39 -0800
Received: from dea.linux-mips.net (a1as18-p231.stg.tli.de [195.252.193.231])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14N2ZA19183
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 15:02:36 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g14N19j07967;
	Tue, 5 Feb 2002 00:01:09 +0100
Date: Tue, 5 Feb 2002 00:01:09 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc 3.x, -ansi and "static inline"
Message-ID: <20020205000109.A7512@dea.linux-mips.net>
References: <20020201115206.A18085@mvista.com> <20020203180151.A5371@dea.linux-mips.net> <3C5EE0D0.F2CC94CE@mvista.com> <20020204232108.A7266@dea.linux-mips.net> <3C5F11AB.957DDA6C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5F11AB.957DDA6C@mvista.com>; from jsun@mvista.com on Mon, Feb 04, 2002 at 02:56:43PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 02:56:43PM -0800, Jun Sun wrote:

> In theory, yes.  In practice, kernel head is all a big mesh where we don't
> have a clear division as which part can go to userland and which part can't.

The answer is already l-k faq probably - copy the kernel header to
userspace and hack it into your favorite shape.  I'm not a fan of this
policy but ...

  Ralf
