Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 20:54:37 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:657 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTGPTyf>; Wed, 16 Jul 2003 20:54:35 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA01453;
	Wed, 16 Jul 2003 21:54:30 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 16 Jul 2003 21:54:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ladislav Michl <ladis@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sudo oops on mips64 linux_2_4
In-Reply-To: <Pine.GSO.4.21.0307162104450.10176-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030716215248.25959N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2003, Geert Uytterhoeven wrote:

> >  Well, that's not wrong per se and is actually valid at least for
> > CONFIG_FB_VIRTUAL.  And the code should fail gracefully if there nothing
> > useful to do.
> 
> You do not want to set CONFIG_FB_VIRTUAL=y, since the virtual frame buffer
> device is meant for testing only.

 Sure -- and I should expect random crashes if I happen to enable it,
right? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
