Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CIhS8d019672
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 11:43:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CIhRqL019671
	for linux-mips-outgoing; Fri, 12 Apr 2002 11:43:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CIhM8d019665
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 11:43:24 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA17500;
	Fri, 12 Apr 2002 20:44:18 +0200 (MET DST)
Date: Fri, 12 Apr 2002 20:44:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped?
In-Reply-To: <012f01c1e250$c93fb0a0$4c00a8c0@prefect>
Message-ID: <Pine.GSO.3.96.1020412204040.17244B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Apr 2002, Bradley D. LaRonde wrote:

> Which brings up an interesting question - why doesn't the kernel use .so
> files for modules?

 There is no need to bring all the dynamic stuff into the kernel. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
