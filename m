Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48LcKY00724
	for linux-mips-outgoing; Tue, 8 May 2001 14:38:20 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48Lc5F00719
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 14:38:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA10834;
	Tue, 8 May 2001 23:32:21 +0200 (MET DST)
Date: Tue, 8 May 2001 23:32:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <15096.23421.564537.144351@pizda.ninka.net>
Message-ID: <Pine.GSO.3.96.1010508232117.4713F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 8 May 2001, David S. Miller wrote:

> There are several get_unmapped_area() implementations besides the
> standard one (search for HAVE_ARCH_UNMAPPED_AREA).  Please fix
> them up too.

 Yep, I know (ia64 and sparc*).  But being lazy enough (and being short on
time) I won't do it until I know the idea of the change is accepted.  I'm
sorry -- I sent previous versions of the patch twice since last Summer
with no response at all and doing bits no one is interested in is a waste
of time.

 Thanks for your response, though -- maybe there is someone interested,
after all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
