Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9LGBcW16106
	for linux-mips-outgoing; Sun, 21 Oct 2001 09:11:38 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9LGBYD16103
	for <linux-mips@oss.sgi.com>; Sun, 21 Oct 2001 09:11:34 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 25EA1125C8; Sun, 21 Oct 2001 09:11:27 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id C445CEBA6; Sun, 21 Oct 2001 09:11:25 -0700 (PDT)
Date: Sun, 21 Oct 2001 09:11:25 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Klaus Naumann <spock@mgnet.de>
Cc: linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com
Subject: Re: The Linux binutils 2.11.92.0.7 is released.
Message-ID: <20011021091125.A1774@lucon.org>
References: <20011016201334.A31989@lucon.org> <Pine.LNX.4.21.0110211317450.17620-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110211317450.17620-100000@spock.mgnet.de>; from spock@mgnet.de on Sun, Oct 21, 2001 at 04:48:42PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Oct 21, 2001 at 04:48:42PM +0200, Klaus Naumann wrote:
> 
> Hi,
> 
> also with these binutils I still have a problem when compiling mozilla.
> Maybe you know what the issue is ...
> 
> make[2]: Entering directory `/mnt/build/mozilla/mozilla/content/build'
> rm -f libgkcontent.so
> c++ -I/usr/X11R6/include -fno-rtti -fno-exceptions -Wall -Wconversion
> -Wpointer-arith -Wbad-function-cast -Wcast-align -Woverloaded-virtual
> -Wsynth -pedantic -Wno-long-long -pthread  -DNDEBUG -DTRIMMED -Wa,-xgot
> -shared -Wl,-h -Wl,libgkcontent.so -o libgkcontent.so  nsContentDLF.o
> nsContentModule.o nsContentHTTPStartup.o    -Wl,--whole-archive
> ../../dist/lib/libgkconevents_s.a ../../dist/lib/libgkconhtmlcon_s.a
> ../../dist/lib/libgkconhtmldoc_s.a ../../dist/lib/libgkconhtmlstyle_s.a
> ../../dist/lib/libgkconxmlcon_s.a ../../dist/lib/libgkconxmldoc_s.a
> ../../dist/lib/libgkconxsldoc_s.a ../../dist/lib/libgkconxulcon_s.a
> ../../dist/lib/libgkconxuldoc_s.a ../../dist/lib/libgkconxultmpl_s.a
> ../../dist/lib/libgkconxbl_s.a ../../dist/lib/libgkconbase_s.a
> ../../dist/lib/libgkconshared_s.a  -Wl,--no-whole-archive -L../../dist/bin
> -lgkgfx -L../../dist/bin -lxpcom -L../../dist/bin
> -L/mnt/build/mozilla/mozilla/dist/lib -lplds4 -lplc4 -lnspr4 -lpthread
> -ldl -lc  -L../../dist/bin -lmozjs
> -Wl,--version-script,../../build/unix/gnu-ld-scripts/components-version-script
> -ldl -lm  -lc

It is a known problem if

1. You don't compile shared libraries with -fpic/-fPIC.
2. Even if you do, you may overflow GOT table.


H.J.
