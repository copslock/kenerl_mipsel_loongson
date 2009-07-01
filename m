Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 17:46:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42850 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492039AbZGAPqs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 17:46:48 +0200
Date:	Wed, 1 Jul 2009 16:46:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Malta: Remove unneeded function protos from
 malta-reset.c
In-Reply-To: <20090701063116.GA6101@linux-mips.org>
Message-ID: <alpine.LFD.2.00.0907011640530.18056@eddie.linux-mips.org>
References: <1246035565-24015-1-git-send-email-dmitri.vorobiev@movial.com> <20090628181702.GB20084@linux-mips.org> <alpine.LFD.2.00.0907010108380.23134@eddie.linux-mips.org> <20090701063116.GA6101@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Jul 2009, Ralf Baechle wrote:

> Code written to require intimate knowledge of all operator priorities is
> probably as bad as overuse.  Here a few examples:
> 
> 	return (1);
> #define FOO	(42)
> 	a = (b + c);
> 	a = (b + c) + d;
> 	a = (b * c) + (d * e);
> 	if ((a > b) && (a < c))

 Sometimes additional brackets are useful to emphasise some logical 
grouping of entities used, so I would accept even such a construct as:

	a = (b + c + d) + (e + f);

to bring attention of the reader that a, b and c refer to something other 
than e and f, but yes, it would require explicit justification and I 
wouldn't consider it a blanket accept statement for such kinds of 
expressions.

 The #define case makes my eyes hurt.  OTOH we require unnecessary 
brackets in the context of sizeof. ;)

  Maciej
