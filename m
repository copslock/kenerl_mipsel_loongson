Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 09:00:05 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28100 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037485AbWJSIAD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 09:00:03 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 17:00:02 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id AB8BE41B95;
	Thu, 19 Oct 2006 17:00:00 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9D3AA41B5D;
	Thu, 19 Oct 2006 17:00:00 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9J7xvW0069701;
	Thu, 19 Oct 2006 16:59:57 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 16:59:57 +0900 (JST)
Message-Id: <20061019.165957.45517509.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for
 64 bit kernels
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45372CBC.9090602@innova-card.com>
References: <20061019154138.0343bbd0.yoichi_yuasa@tripeaks.co.jp>
	<20061019.160145.63741509.nemoto@toshiba-tops.co.jp>
	<45372CBC.9090602@innova-card.com>
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
X-archive-position: 13015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 09:43:56 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> or why not simply replacing _LLCONST_ usages by _LCONST_ ? After all,
> 64 bits value seems to be used only for 64 bits kernels.

Well, I suppose 32bit kernel might want to use 64bit values, for
example, CONFIG_64BIT_PHYS_ADDR.

---
Atsushi Nemoto
