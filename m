Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 01:28:34 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28511 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039457AbXBNB23 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Feb 2007 01:28:29 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 14 Feb 2007 10:28:26 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 511D241EA4;
	Wed, 14 Feb 2007 10:28:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4463F20608;
	Wed, 14 Feb 2007 10:28:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1E1S1W0093759;
	Wed, 14 Feb 2007 10:28:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 14 Feb 2007 10:28:01 +0900 (JST)
Message-Id: <20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
References: <11713582901742-git-send-email-fbuihuu@gmail.com>
	<20070213161801.GA9700@linux-mips.org>
	<cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
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
X-archive-position: 14086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 13 Feb 2007 18:09:32 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> It should be done by patch #3 instead where CONFIG_BUILD_ELF64 is
> renamed into CONFIG_64BIT_BUILD_ELF32. Any suggestions for a better
> name ?

I think "ELF32" or "ELF64" word is improper while this is irrelevant
to ELF format.  This makes confusion with CONFIG_BOOT_ELF32.

How about simple BUILD_SYM32?  And replase BUILD_ELF32 with
BUILD_SYM32 too?

---
Atsushi Nemoto
