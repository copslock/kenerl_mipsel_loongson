Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 01:06:58 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:18714 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022011AbXCTBG4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 01:06:56 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 20 Mar 2007 10:06:55 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B3F924218A;
	Tue, 20 Mar 2007 10:06:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9F3BF20399;
	Tue, 20 Mar 2007 10:06:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2K16VW0051758;
	Tue, 20 Mar 2007 10:06:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 20 Mar 2007 10:06:31 +0900 (JST)
Message-Id: <20070320.100631.71882772.nemoto@toshiba-tops.co.jp>
To:	Marc_St-Jean@pmc-sierra.com
Cc:	stjeanma@pmc-sierra.com, akpm@linux-foundation.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45FECF32.9020600@pmc-sierra.com>
References: <45FECF32.9020600@pmc-sierra.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 09:58:10 -0800, Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:
> By "using new flow handler" do you mean specifying "handle_level_irq",
> "handle_edge_irq". etc?

Yes.  Maybe handle_level_irq would be enough.  And you can remove .end
routine.

---
Atsushi Nemoto
