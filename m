Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77EgSo22173
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:42:28 -0700
Received: from tennyson.netexpress.net (IDENT:root@tennyson.netexpress.net [64.22.192.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77EgRV22170
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:42:27 -0700
Received: from localhost (vorlon@localhost)
	by tennyson.netexpress.net (8.9.3/8.9.3) with ESMTP id JAA32724;
	Tue, 7 Aug 2001 09:42:15 -0500
X-Authentication-Warning: tennyson.netexpress.net: vorlon owned process doing -bs
Date: Tue, 7 Aug 2001 09:42:14 -0500 (CDT)
From: Steve Langasek <vorlon@netexpress.net>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: cross-mipsel-linux-ld --prefix library path
In-Reply-To: <074001c11ef4$fdbd7530$3501010a@ltc.com>
Message-ID: <Pine.LNX.4.30.0108070939230.32641-100000@tennyson.netexpress.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 6 Aug 2001, Bradley D. LaRonde wrote:

> Another odd thing is that binutils installs:

>     /usr/mipsel-linux/bin/mipsel-linux-ld

> and an identical copy at:

>     /usr/mipsel-linux/mipsel-linux/bin/ld

The places you /want/ these to show up are /usr/mipsel-linux/bin/ld and
/usr/bin/mipsel-linux-ld.  The reason for having two copies is that when
you're calling these tools directly (or from a make script), you want them to
be in your path, so you want them to have a unique name
(/usr/bin/mipsel-linux-ld); but internally, I believe the tools prefer /not/
to have to mess with the name mangling used there, so instead they look for a
tool with the normal name (ld) in an architecture-specific directory
(/usr/mipsel-linux/bin).

Steve Langasek
postmodern programmer
