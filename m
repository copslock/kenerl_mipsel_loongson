Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GG6xB14426
	for linux-mips-outgoing; Mon, 16 Jul 2001 09:06:59 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GG6uV14423;
	Mon, 16 Jul 2001 09:06:56 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08534; Mon, 16 Jul 2001 09:06:54 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA13591;
	Mon, 16 Jul 2001 14:04:44 +0200 (MET DST)
Date: Mon, 16 Jul 2001 14:04:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
In-Reply-To: <20010715213224.A19636@mvista.com>
Message-ID: <Pine.GSO.3.96.1010716140346.12988C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 15 Jul 2001, Jun Sun wrote:

> For compatibility reasons, I assume we still keep sysmips() around
> for a while, right?  And if that is yes, we better take either flo's or
> my fix (derived from Maceij's new syscall) to get rid of the illegal 
> instruction bug, which really becomes an untolerable FAQ now.

 I don't think it would be wise to remove MIPS_ATOMIC_SET before 2.5.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
