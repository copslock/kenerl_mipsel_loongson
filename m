Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6GHFa24600
	for linux-mips-outgoing; Tue, 6 Nov 2001 08:17:15 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA6GHC024594
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 08:17:12 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA03037;
	Tue, 6 Nov 2001 17:14:40 +0100 (MET)
Date: Tue, 6 Nov 2001 17:14:39 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Scott A McConnell <samcconn@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [Fwd: Kernel panic: Caught reserved exception - should not happen.]
In-Reply-To: <3BE1D1C0.E32905BA@mvista.com>
Message-ID: <Pine.GSO.3.96.1011106171112.24538A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 1 Nov 2001, Jun Sun wrote:

> *sigh* We need another ugly #ifdef in the head.S file.

 A better approach would be to define a macro in a header file and only
expand it in head.S.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
