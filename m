Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 13:29:47 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:55268 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021911AbXFNM3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 13:29:45 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 14 Jun 2007 21:29:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9C6C83EEE9;
	Thu, 14 Jun 2007 21:29:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8980C20468;
	Thu, 14 Jun 2007 21:29:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l5ECTDAF081097;
	Thu, 14 Jun 2007 21:29:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 14 Jun 2007 21:29:13 +0900 (JST)
Message-Id: <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11818164024053-git-send-email-fbuihuu@gmail.com>
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	<11818164024053-git-send-email-fbuihuu@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 14 Jun 2007 12:20:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>  create mode 100644 arch/mips/lib/time.c

I think this to_tm() cleanup should be done in separate patch.

Maybe selecting RTC_LIB in Kconfig and replace all to_tm() calls with

	rtc_time_to_tm(tim, tm);
	tm->tm_year += 1900;

would be enough.

---
Atsushi Nemoto
