Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2003 14:42:25 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:41185 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225192AbTEZNmX>; Mon, 26 May 2003 14:42:23 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA06886;
	Mon, 26 May 2003 15:43:05 +0200 (MET DST)
Date: Mon, 26 May 2003 15:43:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: JinuM <jinum@esntechnologies.co.in>
cc: linux-mips@linux-mips.org
Subject: Re: PCI Conf Space in application mode
In-Reply-To: <AF572D578398634881E52418B2892567122B4C@mail.esn.activedirectory>
Message-ID: <Pine.GSO.3.96.1030526154030.4495B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 26 May 2003, JinuM wrote:

> But i believe its not the same in MIPS architecture. How can i read n write
> into some IO port(memory mapped in MIPS) on MIPS platform. Can i only access
> these ports in driver mode?

 Use /dev/port or /dev/mem.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
