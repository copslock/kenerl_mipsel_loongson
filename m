Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3U9XOs02685
	for linux-mips-outgoing; Mon, 30 Apr 2001 02:33:24 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3U9WwM02674;
	Mon, 30 Apr 2001 02:32:59 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA02377;
	Mon, 30 Apr 2001 11:28:00 +0200 (MET DST)
Date: Mon, 30 Apr 2001 11:28:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bryan Chua <chua@ayrnetworks.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, "George Gensure,,," <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: glibc build
In-Reply-To: <3AE0BA3E.A9D7658@ayrnetworks.com>
Message-ID: <Pine.GSO.3.96.1010430111547.889A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 20 Apr 2001, Bryan Chua wrote:

> gcc 2.95.2, 2.95.2.1, 2.95.3
> 
> The bug was that the specs file in 2.95.? seems to be missing a
> -K__PIC__ in the spec for *cpp %{.S...}

 None of 2.95.* compilers works for MIPS/Linux without additional patches. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
