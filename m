Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77JRpi09901
	for linux-mips-outgoing; Tue, 7 Aug 2001 12:27:51 -0700
Received: from tennyson.netexpress.net (IDENT:root@tennyson.netexpress.net [64.22.192.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77JRoV09893
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 12:27:50 -0700
Received: from localhost (vorlon@localhost)
	by tennyson.netexpress.net (8.9.3/8.9.3) with ESMTP id OAA00981;
	Tue, 7 Aug 2001 14:27:44 -0500
X-Authentication-Warning: tennyson.netexpress.net: vorlon owned process doing -bs
Date: Tue, 7 Aug 2001 14:27:44 -0500 (CDT)
From: Steve Langasek <vorlon@netexpress.net>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: cross-mipsel-linux-ld --prefix library path
In-Reply-To: <094d01c11f55$31969d40$3501010a@ltc.com>
Message-ID: <Pine.LNX.4.30.0108071420150.32641-100000@tennyson.netexpress.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 7 Aug 2001, Bradley D. LaRonde wrote:

> OK, so say I leave off --prefix entirely, and the binutils get installed in
> /usr/bin and /usr/mipsel-linux/bin.  Now, I suppose that mipsel-linux-ld
> will look for libs in /usr/mipsel-linux/lib, which is cool.  But, how to I
> convince the cross-built glibc that's where his libraries belong?
>  Just --prefix=/usr/mipsel-linux to glibc's configure?

That should be enough to force glibc to use /usr/mipsel-linux, but I don't
think it's correct to use that as a /configure/ option.  Effectively,
libraries used for cross-building should be identical to the native libraries
in every way[1], only installed in a different place on the system.  You would
never /run/ glibc-based applications against /usr/mipsel-linux on a native
system.

On Debian, I find that dpkg-cross is a very useful utility.  You can pass it
the filename of a package from another architecture, as well as the
architecture it belongs to, and it will reconstruct an Architecture: all
package that places the libraries under /usr/<arch>-linux.  This seems a bit
easier than trying to worry about install directories for glibc at compile
time.

HTH,
Steve Langasek
postmodern programmer

[1] ok, with the exception of /usr/lib/libc.so, which is not a library at all,
    but rather a GNU linker script.  dpkg-cross also takes care of rewriting
    this script, which I found rather impressive the first time I saw it
    happen.
