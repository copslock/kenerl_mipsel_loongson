Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FFfqR25815
	for linux-mips-outgoing; Fri, 15 Feb 2002 07:41:52 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FFfe925811;
	Fri, 15 Feb 2002 07:41:41 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA06254;
	Fri, 15 Feb 2002 15:41:50 +0100 (MET)
Date: Fri, 15 Feb 2002 15:41:49 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
In-Reply-To: <20020215152132.A602@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020215152948.29773L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Ralf Baechle wrote:

> >  BTW, why do people insist on sending patches as attachments -- it makes
> > commenting them helly twisted, sigh... 
> 
> How true.  MIME - broken solution for a broken design ;)  More serious,

 Why broken?  It's not broken for what it was invented to, i.e. for
passing unsafe characters via SMTP.  Source patches do not qualify as
containing such. 

> MIME makes sense when using a MUA that garbles patches like Netscape or
> certain versions of Pine.

 MIME is not a solution for broken MUAs or MDAs and was not intended as
one, definitely.  Pine got broken quite recently (it eats white space at
line ends; that may be circumvented by using `patch -l' and may actually
be advantageous in not adding white space there if present in the patch;
the drawback is `patch' doesn't eat white space to be removed either) and
there is a patch available (the package I have at my site doesn't have it
applied, though, I admit; the next version should).  The ancient version
I'm using here seems safe as is. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
