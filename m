Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39CQ2b04238
	for linux-mips-outgoing; Mon, 9 Apr 2001 05:26:02 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39CPeM04233
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 05:25:56 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14849;
	Mon, 9 Apr 2001 14:16:53 +0200 (MET DST)
Date: Mon, 9 Apr 2001 14:16:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <3ACF323D.3030704@redhat.com>
Message-ID: <Pine.GSO.3.96.1010409141238.9470E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 7 Apr 2001, Joe deBlaquiere wrote:

> You might call it a hack, but it makes life easy if you do something like:
> 
> export ac_cv_sizeof_short=2
> export ac_cv_sizeof_int=4
> export ac_cv_sizeof_long=4
> 
> sh ./configure --target=$CONFIG_TARGET --host=$CONFIG_HOST 
> --prefix=$CONFIG_PREFIX --exec-prefix=$CONFIG_EXECPR
> 
> This will short circuit a "broken" configure trying to execute programs 
> for this kind of thing. If configure doesn't care about sizeof_int, then 
> this definition is silently ignored...

 If you look at my RPM packages, you'll see I'm already doing this.  I've
already thought of making global cross-compilation configuration files for
each host containing appropriate definitions.  I'm not sure how to
integrate it with RPM, yet (the macro definition file is a good
candidate).  I didn't make any progress due to a low priority of this
task. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
