Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 12:44:53 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1544 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022751AbXCZLov (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 12:44:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 63463E1C72;
	Mon, 26 Mar 2007 13:43:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nWqYYqh1FXwn; Mon, 26 Mar 2007 13:43:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5A49EE1F4F;
	Mon, 26 Mar 2007 13:35:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2QBa4go007218;
	Mon, 26 Mar 2007 13:36:04 +0200
Date:	Mon, 26 Mar 2007 12:35:59 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
In-Reply-To: <20070325144515.GB21439@networkno.de>
Message-ID: <Pine.LNX.4.64N.0703261234260.16083@blysk.ds.pg.gda.pl>
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp>
 <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
 <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org>
 <20070325144515.GB21439@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2931/Mon Mar 26 10:43:40 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 25 Mar 2007, Thiemo Seufer wrote:

> AFAICS this loses -mno-explicit-relocs completely, but it is needed for
> all non-ckseg0 CONFIG_64BIT builds.

 Why?  I reckon GCC should support them just fine these days.

  Maciej
