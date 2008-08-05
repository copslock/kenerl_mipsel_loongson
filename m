Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 01:33:24 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:11316 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20040155AbYHEAdO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 01:33:14 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Tue, 5 Aug 2008 09:33:12 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4D292448F3;
	Tue,  5 Aug 2008 09:33:07 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 385F544416;
	Tue,  5 Aug 2008 09:33:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m750X6fl054861;
	Tue, 5 Aug 2008 09:33:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 05 Aug 2008 09:33:05 +0900 (JST)
Message-Id: <20080805.093305.233543912.nemoto@toshiba-tops.co.jp>
To:	tsbogend@alpha.franken.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2] IP27: Switch over to RTC class driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080804170021.AAE18C2EAA@solo.franken.de>
References: <20080804170021.AAE18C2EAA@solo.franken.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon,  4 Aug 2008 19:00:21 +0200 (CEST), Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> +	res.start = XPHYSADDR(KL_CONFIG_CH_CONS_INFO(master_nasid)->memory_base +
> +			      IOC3_BYTEBUS_DEV0);
> +	res.end = res.start + 32768;

res.end should be res.start + 32767 ?
