Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 01:06:51 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:50099 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022374AbXCNBGY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Mar 2007 01:06:24 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 14 Mar 2007 10:06:23 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 99AE142043;
	Wed, 14 Mar 2007 10:05:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8BE023A3E0;
	Wed, 14 Mar 2007 10:05:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2E15wW0023847;
	Wed, 14 Mar 2007 10:05:58 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 14 Mar 2007 10:05:57 +0900 (JST)
Message-Id: <20070314.100557.33857330.nemoto@toshiba-tops.co.jp>
To:	shemminger@linux-foundation.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org, jeff@garzik.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] tc35815: Fix an usage of streaming DMA API.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070313120418.554a3a43@freekitty>
References: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>
	<20070314.010220.65192616.anemo@mba.ocn.ne.jp>
	<20070313120418.554a3a43@freekitty>
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
X-archive-position: 14462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 13 Mar 2007 12:04:18 -0700, Stephen Hemminger <shemminger@linux-foundation.org> wrote:
> > + *	1.35	Fix an usage of streaming DMA API.
> >   */
> 
> Please don't use comments as changelog anymore. It gets out of date.
> The use of change control systems has made this practice obsolete.

OK, Jeff, should I send a revised patch dropping this line?

---
Atsushi Nemoto
