Received:  by oss.sgi.com id <S553655AbQLLNdy>;
	Tue, 12 Dec 2000 05:33:54 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:50852 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553647AbQLLNdl>;
	Tue, 12 Dec 2000 05:33:41 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14345;
	Tue, 12 Dec 2000 14:23:48 +0100 (MET)
Date:   Tue, 12 Dec 2000 14:23:47 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
In-Reply-To: <3A35D5FC.11372085@mvista.com>
Message-ID: <Pine.GSO.3.96.1001212140804.9082C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 11 Dec 2000, Jun Sun wrote:

> Here is my patch.  I think it should be safe for mips64.  Please double check
> it.

 I don't think we should allow access to non page-mapped areas as well as
read()/write() for non-memory areas.  That would be inconsistent with the
idea of /dev/kmem and the implementation for other ports. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
