Received:  by oss.sgi.com id <S553832AbRA2PGA>;
	Mon, 29 Jan 2001 07:06:00 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53140 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553829AbRA2PFa>;
	Mon, 29 Jan 2001 07:05:30 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA22559;
	Mon, 29 Jan 2001 16:03:48 +0100 (MET)
Date:   Mon, 29 Jan 2001 16:03:46 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Joe deBlaquiere <jadb@redhat.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
In-Reply-To: <20010127114211.L867@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010129155334.20889A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 27 Jan 2001, Ralf Baechle wrote:

> Sorry, the specs is code and docs I have access to here inside SGI and which
> I cannot pass on ...

 Hmm, weird -- I thought a manual page would be available somewhere, as
it's practised in Unix.  Error conditions is what would be most
interesting.

> We have an IRIX 5 emulation and if I remember right for IRIX 5
> MIPS_ATOMIC_SET is still supported, so we need to also.  So I fear we'll
> have to keep sysmips.  Which still doesn't mean we should come up with
> something better.

 OK, then, but still we should do it properly, even for MIPS1.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
