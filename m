Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39Jare15370
	for linux-mips-outgoing; Mon, 9 Apr 2001 12:36:53 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39JanM15366;
	Mon, 9 Apr 2001 12:36:49 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3DF4B7D9; Mon,  9 Apr 2001 21:36:47 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8F3A2F385; Mon,  9 Apr 2001 21:36:32 +0200 (CEST)
Date: Mon, 9 Apr 2001 21:36:32 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com, rmurray@cyberhqz.com
Subject: Re: sgiwd93 multiple disk problem
Message-ID: <20010409213632.B22835@paradigm.rfc822.org>
References: <20010403174749.B4135@paradigm.rfc822.org> <013801c0bc58$7abe2700$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <013801c0bc58$7abe2700$0deca8c0@Ulysses>; from kevink@mips.com on Tue, Apr 03, 2001 at 06:09:27PM +0200
Organization: rfc822 - pure communication
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f39JaoM15367
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>From a test Ryan Murray has made we do have some interesting output:

Case 1
 Data gets lost - From a diff on a large directory on ascii data 
 i can see chunks to get lost e.g. 32K (31926 byte)

Case 2 
 Data gets lost and some additional bytes get inserted:

 Example:
------------- schnipp ---------------------------------------
   tcl.h      found in  /build/buildd/blt-2.4u/debian/tcl8.0/include
-  tk.h       found in  /build/buildd/blt-2.4u/debian/tk8.0/include
[...]
-gcc -c -Wall -O6   -I. -I.  -I/build/buildd/blt-2.4u/debian/tk8.0/include -I/build/buildd/blt-2.4u/debian/tcl8.0/include bltGrPs.c
+  tk.h       found in  /build/ltGrPs.c
 gcc -c -Wall -O6   -I. -I.  -I/build/buildd/blt-2.4u/debian/tk8.0/include -I/build/buildd/blt-2.4u/debian/tcl8.0/include bltGraph.c
------------- schnapp ---------------------------------------

Case 3
 Zero bytes get inserted (2561 bytes and 3073 bytes)

 Example:

------------- schnipp ---------------------------------------
 gcc -c -Wall -O6   -I. -I.  -I/build/buildd/blt-2.4u/debian/tk8.0/include -I/build/buildd/blt-2.4u/debian/tcl8.0/include tkFrame.c
-gcc -c -Wall -O6   -I. -I.  -I/build/buildd/blt-2.4u/debian/tk8.0/include -I/build/buildd/blt-2.4u/debian/tcl8.0/include tkScrollbar.c
+gcc -c -Wall -O6   -I. -I.  -I/build/buildd/blt-2.4u                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         /debian/tk8.0/include -I/build/buildd/blt-2.4u/debian/tcl8.0/include tkScrollbar.c
 gcc -c -Wall -O6   -I. -I.  -I/build/buildd/blt-2.4u/debian/tk8.0/include -I/build/buildd/blt-2.4u/debian/tcl8.0/include bltTed.c
------------- schnapp ---------------------------------------

Case 4
 Garbage data gets inserted (Go and find the rootpw :) )
 
 Example:

------------- schnipp ---------------------------------------
 455663    4 -rw-r--r--   1 root     root         2514 Oct  6  1998 ./usr/share/doc/fltk/examples/whiteking_3.xbm
-455664    4 -rw-r--r--   1 root     root         2514 Oct  6  1998 ./usr/share/doc/fltk/examples/whiteking_4.xbm
+455664    4 -rw-r--r--   1 roo\p   .   Zp   ..  ]p   Root^p  
+ Repository  jp � Entries                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         kp   .   Zp   ..  lp   CVS pp   Makefileqp  	 ipldump.S   rp  	 ipleckd.S   sp � iplfba.S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    lp   .   kp   ..  mp   Rootnp  
+ Repository  op � Entries                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         t     root         2514 Oct  6  1998 ./usr/share/doc/fltk/examples/whiteking_4.xbm
 455665    4 -rw-r--r--   1 root     root         2213 Apr  1 12:16 ./usr/share/doc/fltk/examples/makeinclude
 455666    0 lrwxrwxrwx   1 root     root           38 Apr  1 12:33 ./usr/share/doc/fltk/examples/CubeView -> ../../../../lib/fltk/examples/CubeView
------------- schnapp ---------------------------------------

I suspect there is DMA corruption going on.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
