Received:  by oss.sgi.com id <S553785AbRBHL1x>;
	Thu, 8 Feb 2001 03:27:53 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42909 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553777AbRBHL1n>;
	Thu, 8 Feb 2001 03:27:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA01590;
	Thu, 8 Feb 2001 12:22:15 +0100 (MET)
Date:   Thu, 8 Feb 2001 12:22:15 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <Pine.GSO.4.10.10102081151560.23477-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010208122024.29177F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 8 Feb 2001, Geert Uytterhoeven wrote:

> Alternatively you can make (most of) it a loadable module. I don't think
> /sbin/modprobe needs the FPU :-)

 I bet libc will want to initialize FPU's control word or something like
that at the least expected moment. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
