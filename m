Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 12:37:22 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:32529 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225273AbVBGMhH>;
	Mon, 7 Feb 2005 12:37:07 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Cy8Db-0005DU-00; Mon, 07 Feb 2005 12:42:19 +0000
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Cy88J-0005Fs-00; Mon, 07 Feb 2005 12:36:51 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1Cy88I-0008AS-00; Mon, 07 Feb 2005 12:36:50 +0000
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16903.24802.504192.330272@arsenal.mips.com>
Date:	Mon, 7 Feb 2005 12:36:50 +0000
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
In-Reply-To: <20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
	<4203890B.5030305@mips.com>
	<20050204145803.GA5618@linux-mips.org>
	<20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.897,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Atsushi Nemoto (anemo@mba.ocn.ne.jp) writes:

> 20KC Users Manual says it has physically indexed data cache.

That's correct.

> For other MIPS64 core, 5Kc has virtually indexed cache.

Yes.

> How about 25KF?

Physically indexed, it's a descendent of the 20Kc core.

--
Dominic
