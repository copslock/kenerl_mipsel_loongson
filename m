Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JDRYj26889
	for linux-mips-outgoing; Fri, 19 Oct 2001 06:27:34 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JDRRD26885
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 06:27:27 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA07912;
	Fri, 19 Oct 2001 15:26:12 +0200 (MET DST)
Date: Fri, 19 Oct 2001 15:26:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: Strange behavior of serial console under 2.4.9
In-Reply-To: <20011018194014.A8744@lucon.org>
Message-ID: <Pine.GSO.3.96.1011019152309.1657F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 18 Oct 2001, H . J . Lu wrote:

> I am using 9600 buad. It used to be ok under 2.4.3/2.4.5. But under
> 2.4.9, the first 10 minutes after boot is very slow. After that, it
> seems ok.

 That might be driver-specific.  I'm using drivers/tc/zs.c and it works
fine at 115200 bps.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
