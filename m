Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3U9iGG03233
	for linux-mips-outgoing; Mon, 30 Apr 2001 02:44:16 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3U9i2M03221;
	Mon, 30 Apr 2001 02:44:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA02524;
	Mon, 30 Apr 2001 11:34:33 +0200 (MET DST)
Date: Mon, 30 Apr 2001 11:34:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Pete Popov <ppopov@mvista.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
In-Reply-To: <20010420215841.D15990@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010430113243.889B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 20 Apr 2001, Florian Lohoff wrote:

> A different solution would be to take the usual exit in sysmips via
> the return at the end (for which the compiler generated a correct
> epilogue) and modify the return address - This is an very ugly hack
> and you cant tell where the compiler stores the ra on the stack.

 It could be doable with __builtin_frame_address().  Haven't investigated
it further, though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
