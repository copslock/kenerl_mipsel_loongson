Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 16:53:14 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:11675 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S869531AbSK1PxD>; Thu, 28 Nov 2002 16:53:03 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA02130;
	Thu, 28 Nov 2002 16:51:57 +0100 (MET)
Date: Thu, 28 Nov 2002 16:51:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: atul srivastava <atulsrivastava9@rediffmail.com>
cc: linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
In-Reply-To: <20021127091114.27117.qmail@webmail24.rediffmail.com>
Message-ID: <Pine.GSO.3.96.1021128164709.8C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 27 Nov 2002, atul srivastava wrote:

> following is the relevant code:--
> 
> #ifdef CONFIG_MIPS_UNCACHED
>          change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
> #else
>          change_cp0_config(CONF_CM_CMASK, 
> CONF_CM_CACHABLE_NONCOHERENT);
> #endif

 You are looking at obsolete code -- unless you have specific conditions
to use an explicit caching attribute for KSEG0, you should set it like the
rest of the code does it, i.e.:

change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);

To avoid surprises here and elsewhere, you should make sure
CONFIG_NONCOHERENT_IO is set appropriately, too.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
