Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f51Ee0R25403
	for linux-mips-outgoing; Fri, 1 Jun 2001 07:40:00 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f51Eb5h25184
	for <linux-mips@oss.sgi.com>; Fri, 1 Jun 2001 07:37:30 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA03732;
	Fri, 1 Jun 2001 16:21:26 +0200 (MET DST)
Date: Fri, 1 Jun 2001 16:21:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
In-Reply-To: <hoelt4xqdn.fsf@gee.suse.de>
Message-ID: <Pine.GSO.3.96.1010601160422.26484C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 1 Jun 2001, Andreas Jaeger wrote:

> We normally do not define anything to 0 - unless there's no other
> way.  And looking briefly over your code there should be other
> solutions.  Sorry, I'm limited in time currently, otherwise I would
> rewrite it myself.

 OK, I'll check how to write it better and still get good optimization
results.  Please don't bother writing it yourself -- we don't have any
kernel code yet, so there is no real need to get involved so much.

> Look at i386/lockf64.c for a cleaner example.

 Hmm, glibc rules certainly look different from Linux's ones -- I tried to
avoid interspersing real code with preprocessor conditionals.  Since you
state it's OK, I should have no problem with coding accrdingly.

> >  It's a syscall wrapper.  We want to export syscall wrappers, don't
> >  we? 
> 
> No, not everything - we already export _test_and_set and that should
> be enough.

 OK, then.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
