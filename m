Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 20:47:42 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:2066 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225472AbVFMTr0>; Mon, 13 Jun 2005 20:47:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DD2CDF5981; Mon, 13 Jun 2005 21:47:19 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01017-05; Mon, 13 Jun 2005 21:47:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id AB577F596E; Mon, 13 Jun 2005 21:47:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5DJlOLS026668;
	Mon, 13 Jun 2005 21:47:24 +0200
Date:	Mon, 13 Jun 2005 20:47:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kevin Turner <kevin.m.turner@pobox.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.4] inlines in au1000_eth.c
In-Reply-To: <1118438524.1513.28.camel@troglodyte.asianpear>
Message-ID: <Pine.LNX.4.61L.0506131150220.31851@blysk.ds.pg.gda.pl>
References: <1118438524.1513.28.camel@troglodyte.asianpear>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/935/Mon Jun 13 18:27:50 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 10 Jun 2005, Kevin Turner wrote:

> The following patch against linux_2_4 fixes this sort of compilation
> error with gcc 3.4:
> 
> au1000_eth.c: In function `au1000_init_module':
> au1000_eth.c:97: sorry, unimplemented: inlining failed in call to 'str2eaddr': function body not available
> au1000_eth.c:1219: sorry, unimplemented: called from here
> 
> I'm not wholly sure it's the Right Thing, as I define str2eaddr in
> au1000_eth.c, which makes for more code duplication.

 Note that by somebody's "brillant" idea "inline" is a macro that expands 
to "inline __attribute__((always_inline))".  That said, "inline" in a 
function prototype doesn't make much sense anyway.  In this case simply 
removing the qualifier will let code use the implementation from 
arch/mips/au1000/common/prom.c.

 As a side note it's quite amazing how duplicate copies of a function get 
scattered throughout the tree...

  Maciej
