Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9MKh9I15909
	for linux-mips-outgoing; Mon, 22 Oct 2001 13:43:09 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9MKh4D15905
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 13:43:04 -0700
Received: from scotty.mgnet.de (pD9024741.dip.t-dialin.net [217.2.71.65])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA09121
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 22:43:02 +0200 (MET DST)
Received: (qmail 32254 invoked from network); 22 Oct 2001 20:43:01 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 22 Oct 2001 20:43:01 -0000
Date: Mon, 22 Oct 2001 22:43:00 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com
Subject: Re: The Linux binutils 2.11.92.0.7 is released.
In-Reply-To: <20011021091125.A1774@lucon.org>
Message-ID: <Pine.LNX.4.21.0110222242190.18455-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 21 Oct 2001, H . J . Lu wrote:

> On Sun, Oct 21, 2001 at 04:48:42PM +0200, Klaus Naumann wrote:
> > 
> > Hi,
> > 
> > also with these binutils I still have a problem when compiling mozilla.
> > Maybe you know what the issue is ...
> > 
> > make[2]: Entering directory `/mnt/build/mozilla/mozilla/content/build'
> > rm -f libgkcontent.so
> > c++ -I/usr/X11R6/include -fno-rtti -fno-exceptions -Wall -Wconversion
> > -Wpointer-arith -Wbad-function-cast -Wcast-align -Woverloaded-virtual
> > -Wsynth -pedantic -Wno-long-long -pthread  -DNDEBUG -DTRIMMED -Wa,-xgot
> > -shared -Wl,-h -Wl,libgkcontent.so -o libgkcontent.so  nsContentDLF.o
> > nsContentModule.o nsContentHTTPStartup.o    -Wl,--whole-archive
> > ../../dist/lib/libgkconevents_s.a ../../dist/lib/libgkconhtmlcon_s.a
> > ../../dist/lib/libgkconhtmldoc_s.a ../../dist/lib/libgkconhtmlstyle_s.a
> > ../../dist/lib/libgkconxmlcon_s.a ../../dist/lib/libgkconxmldoc_s.a
> > ../../dist/lib/libgkconxsldoc_s.a ../../dist/lib/libgkconxulcon_s.a
> > ../../dist/lib/libgkconxuldoc_s.a ../../dist/lib/libgkconxultmpl_s.a
> > ../../dist/lib/libgkconxbl_s.a ../../dist/lib/libgkconbase_s.a
> > ../../dist/lib/libgkconshared_s.a  -Wl,--no-whole-archive -L../../dist/bin
> > -lgkgfx -L../../dist/bin -lxpcom -L../../dist/bin
> > -L/mnt/build/mozilla/mozilla/dist/lib -lplds4 -lplc4 -lnspr4 -lpthread
> > -ldl -lc  -L../../dist/bin -lmozjs
> > -Wl,--version-script,../../build/unix/gnu-ld-scripts/components-version-script
> > -ldl -lm  -lc
> 
> It is a known problem if
> 
> 1. You don't compile shared libraries with -fpic/-fPIC.
> 2. Even if you do, you may overflow GOT table.

Well, even adding -fpic doesn't help a whole lot.
What is a GOT table ? And do you see any fix for the problem ?


	Thanks, Klaus



-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
