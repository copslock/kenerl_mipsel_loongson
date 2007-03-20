Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 01:23:31 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:33650 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022418AbXCTBX3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 01:23:29 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for [194.74.144.162] [194.74.144.162]) with ESMTP; Tue, 20 Mar 2007 10:23:28 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6455041B5C;
	Tue, 20 Mar 2007 10:22:51 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 50B0D201E9;
	Tue, 20 Mar 2007 10:22:51 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2K1MmW0051833;
	Tue, 20 Mar 2007 10:22:48 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 20 Mar 2007 10:22:48 +0900 (JST)
Message-Id: <20070320.102248.68134682.nemoto@toshiba-tops.co.jp>
To:	dsaxena@plexity.net
Cc:	netdev@vger.kernel.org, ralf@linux-mips.org, jeff@garzik.org,
	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: Re: [PATCH] Netpoll support for Sibyte MAC
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070319224311.GA10176@plexity.net>
References: <20070319224311.GA10176@plexity.net>
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
X-archive-position: 14578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 15:43:11 -0700, Deepak Saxena <dsaxena@plexity.net> wrote:
> NETPOLL support for Sibyte MAC
> 
> Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
> Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

If you added NETPOLL support, do not forget to ensure hard_start_xmit
routine callable from interrupt context (or irq disabled).
See commit bce305f4fe779f29d99d414685243f5da0803254 for example.

---
Atsushi Nemoto
