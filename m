Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FHJpp29953
	for linux-mips-outgoing; Fri, 15 Feb 2002 09:19:51 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FHJc929888;
	Fri, 15 Feb 2002 09:19:42 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA09259;
	Fri, 15 Feb 2002 17:19:32 +0100 (MET)
Date: Fri, 15 Feb 2002 17:19:31 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
In-Reply-To: <20020215164201.A21563@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.GSO.3.96.1020215171630.29773O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Guido Guenther wrote:

> While we're at this: The machine selection in config.in is of type bool. Shouldn't this 
> be of type "choice"? Do we really support several(arbitrary) machine selections in
> one kernel?

 Not at this time, AFAIK, but the intent is to do one day, I believe, at
least for ones that it's possible. 

> Does this look better?

 OK for me.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
