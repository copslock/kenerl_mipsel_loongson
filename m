Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0BIf4F28755
	for linux-mips-outgoing; Fri, 11 Jan 2002 10:41:04 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0BIerg28749;
	Fri, 11 Jan 2002 10:40:57 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA23341;
	Fri, 11 Jan 2002 18:40:07 +0100 (MET)
Date: Fri, 11 Jan 2002 18:40:07 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] disable interrupt for non-LLSC atomic set
In-Reply-To: <20020111092346.C32345@mvista.com>
Message-ID: <Pine.GSO.3.96.1020111183653.15977D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 11 Jan 2002, Jun Sun wrote:

> >  No need to -- no sane interrupt handler will ever access a user's atomic
> > variable. 
> 
> OK, I have to reveal the secret desire :-).  I have a patch
> that makes MIPS kernel preemptible, and that unprotected operation
> becomes very volunerable with the preemptible patch.

 I see.  But why not to keep the MIPS_ATOMIC update together with the
patch then?  It doesn't look like such a patch is going into the official
kernel anytime soon.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
