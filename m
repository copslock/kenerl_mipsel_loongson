Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 14:21:36 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:11193 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225221AbSLKNVf>; Wed, 11 Dec 2002 14:21:35 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22321;
	Wed, 11 Dec 2002 14:21:49 +0100 (MET)
Date: Wed, 11 Dec 2002 14:21:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Subject: Re: IDE module problem
In-Reply-To: <20021209115842.Q8642@mvista.com>
Message-ID: <Pine.GSO.3.96.1021211141709.22157A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 9 Dec 2002, Jun Sun wrote:

> If you configure IDE support as a module (CONFIG_IDE), you
> will soon find that ide-std.o and ide-no.o are missing.
> This is because arch/mips/lib/Makefile says:
> 
> obj-$(CONFIG_IDE)               += ide-std.o ide-no.o
[...]
> 3) use some smart trick in Makefile so that we include those
> two files only if CONFIG_IDE is 'y' or 'm'.  (How?)

 obj-$(CONFIG_IDE_MODULE)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
