Received:  by oss.sgi.com id <S553860AbQKOA6w>;
	Tue, 14 Nov 2000 16:58:52 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:4814 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553816AbQKOA63>;
	Tue, 14 Nov 2000 16:58:29 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id BAA12683;
	Wed, 15 Nov 2000 01:58:21 +0100 (MET)
Date:   Wed, 15 Nov 2000 01:58:21 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
In-Reply-To: <20001115004122.G927@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001115014410.11897A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 15 Nov 2000, Ralf Baechle wrote:

> In any case, for uniprocessor non-ll/sc machines there is also a better
> solution availble with no syscalls at all.  It's easy to implement, just
> use the fact that any exception will change the values of k0/k1.  That of
> course breaks silently on SMP.

 Can you guarantee it???  Well I can guarantee k0 and k1 won't change when
least expected. ;-)  AFAIK, the only fact guaranteed is that exception
handlers do not preserve the values of the scratch registers, but it does
not mean the last value written there is always different from what was
there upon a handler's entry... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
