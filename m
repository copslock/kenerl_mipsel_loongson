Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DFHel09019
	for linux-mips-outgoing; Wed, 13 Jun 2001 08:17:40 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DFHYP09009;
	Wed, 13 Jun 2001 08:17:34 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA04834; Wed, 13 Jun 2001 08:16:28 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA23794;
	Wed, 13 Jun 2001 17:08:20 +0200 (MET DST)
Date: Wed, 13 Jun 2001 17:08:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@melbourne.sgi.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   Raoul Borenius <borenius@shuttle.de>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays) 
In-Reply-To: <10108.992441232@ocs4.ocs-net>
Message-ID: <Pine.GSO.3.96.1010613170729.9854K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 14 Jun 2001, Keith Owens wrote:

> ksymoops also reads the output from nm and objdump internally, it is
> just a little difficult to run cut -c8- on that data ;).

 I see.  So a workaround is likely needed for now.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
