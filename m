Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 14:31:59 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:55785 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024934AbXJQNbu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 14:31:50 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6F918400A5;
	Wed, 17 Oct 2007 15:31:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id MnTjXM587nqO; Wed, 17 Oct 2007 15:31:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 977F7400A4;
	Wed, 17 Oct 2007 15:31:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9HDVKFC029754;
	Wed, 17 Oct 2007 15:31:20 +0200
Date:	Wed, 17 Oct 2007 14:31:15 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Nigel Stephens <nigel@mips.com>
cc:	Thiemo Seufer <ths@networkno.de>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <47160D31.5080201@mips.com>
Message-ID: <Pine.LNX.4.64N.0710171429310.28993@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
 <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
 <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de>
 <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com>
 <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com>
 <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4542/Tue Oct 16 22:31:56 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 17 Oct 2007, Nigel Stephens wrote:

> Aha, that probably explains it. Franck is using the "SDE for Linux v6.05"
> toolchain, and in that version of GCC -march=mips32r2 implies a default of
> -mtune=24k. Tuning for 24K implies -falign-loops=8 -falign-jumps=8 and
> -falign-functions=8. This is undoubtedly why code compiled with
> "-march=mips32r2 -msmartmips" contains more nops than "-march=4ksd".nIn theory
> the extra nops should also disappear if you compile with -Os instead of -O2.

 Another argument for using "-mtune=" explicitly when tuning for a 
particular CPU implementation is desired. :-)

  Maciej
