Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11CpEF01298
	for linux-mips-outgoing; Fri, 1 Feb 2002 04:51:14 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11CpBd01295
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 04:51:11 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA26608;
	Fri, 1 Feb 2002 12:50:48 +0100 (MET)
Date: Fri, 1 Feb 2002 12:50:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hiroyuki Machida <machida@sm.sony.co.jp>
cc: hjl@lucon.org, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
In-Reply-To: <20020201.123523.50041631.machida@sm.sony.co.jp>
Message-ID: <Pine.GSO.3.96.1020201124611.26449B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 1 Feb 2002, Hiroyuki Machida wrote:

> > It will fail if *p is not same as oldval.
> 
> Please note that "sc" may fail even if nobody write the
> variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
> MIPS RUN" for more detail.) 
> So, after your patch applied, compare_and_swap() may fail, even if
> *p is equal to oldval.

 That's exactly what I meant -- "sc" may fail to execute the store, while
"cmpxchgl" may not. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
