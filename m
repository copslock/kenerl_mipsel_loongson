Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 02:45:58 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:6237 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038827AbWJWBpy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 02:45:54 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 23 Oct 2006 10:45:53 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BFAB240222;
	Mon, 23 Oct 2006 10:45:50 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id ABE6620D4E;
	Mon, 23 Oct 2006 10:45:50 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9N1joW0085276;
	Mon, 23 Oct 2006 10:45:50 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 23 Oct 2006 10:45:50 +0900 (JST)
Message-Id: <20061023.104550.41630731.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Oct 2006 03:34:07 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> +++ b/arch/mips/sibyte/sb1250/time.c
...
> +		mips_hpt_mask = V_SCD_TIMER_WIDTH;

Oops, this line should be

+		mips_hpt_mask = M_SCD_TIMER_INIT;

---
Atsushi Nemoto
