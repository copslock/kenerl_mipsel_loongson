Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 19:13:41 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:14795 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225343AbUA3TNk>; Fri, 30 Jan 2004 19:13:40 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DE5D147854; Fri, 30 Jan 2004 20:13:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id D2A0147622; Fri, 30 Jan 2004 20:13:38 +0100 (CET)
Date: Fri, 30 Jan 2004 20:13:38 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] enable genrtc for MIPS
In-Reply-To: <20040130103913.E31937@mvista.com>
Message-ID: <Pine.LNX.4.55.0401302012200.10311@jurand.ds.pg.gda.pl>
References: <20040130103913.E31937@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 30 Jan 2004, Jun Sun wrote:

> Of course, individual board is still free to choose the old rtc.c
> or implement some peculiar ones of its own - although I can't see why. :)

 s/old/full-featured/

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
