Received:  by oss.sgi.com id <S553726AbQKOLXp>;
	Wed, 15 Nov 2000 03:23:45 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:56529 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553695AbQKOLXh>;
	Wed, 15 Nov 2000 03:23:37 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA26149;
	Wed, 15 Nov 2000 12:18:59 +0100 (MET)
Date:   Wed, 15 Nov 2000 12:18:57 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
In-Reply-To: <20001115024358.A3182@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001115121537.25921A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 15 Nov 2000, Ralf Baechle wrote:

> Make that change k0 to a non-zero value.  So a R3000 UP spinlock can look
> like:
> 
> 	move	k0, zero
> 	li	t0, 1
> 0:	sw	t0, spin
> 	bnez	k0, 0b
> 
> 	[critical section]
> 
> 	sw	zero, spin

 Great! -- I haven't thought of such a solution.  I'll prepare some code
and see whether there are no races.  It should work fine, indeed.

> (Who should write thousant times ``I shall not post with a phone in my hand'')

 ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
