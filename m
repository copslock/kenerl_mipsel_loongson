Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GKVTF26808
	for linux-mips-outgoing; Mon, 16 Jul 2001 13:31:29 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GKVRV26803
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 13:31:27 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA23178;
	Mon, 16 Jul 2001 22:33:43 +0200 (MET DST)
Date: Mon, 16 Jul 2001 22:33:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Mike McDonald <mikemac@mikemac.com>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
In-Reply-To: <20010716130913.A1412@lucon.org>
Message-ID: <Pine.GSO.3.96.1010716222350.22824A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 16 Jul 2001, H . J . Lu wrote:

> ls shouldn't bother with clock_gettime, which is in librt and librt
> needs libpthreads. RedHat 7.1 has a similar patch to make 3.79.1 to
> get around it. Otherwise, make won't work right due to the 2MB stack
> limit imposed by libpthreads.

 ls.c contains an explicit reference to clock_gettime() in its
get_current_time() function.  The reference was added quite recently but
ChangeLog does not contain a relevant entry.  In any case clock_gettime()
provides a better resolution than gettimeofday() does.  Did you or someone
else contacted the maintainer to clarify the issue?  RedHat isn't the
whole world. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
