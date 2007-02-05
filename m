Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 07:11:55 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:5248 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027546AbXBEHLv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 07:11:51 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 5 Feb 2007 16:11:48 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4BD8220500;
	Mon,  5 Feb 2007 16:11:24 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 409CE2038D;
	Mon,  5 Feb 2007 16:11:24 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l157BNW0052777;
	Mon, 5 Feb 2007 16:11:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 05 Feb 2007 16:11:23 +0900 (JST)
Message-Id: <20070205.161123.25910611.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Do not allow oprofile to be enabled on SMTC.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20039134AbXBBLSL/20070202111811Z+23663@ftp.linux-mips.org>
References: <S20039134AbXBBLSL/20070202111811Z+23663@ftp.linux-mips.org>
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
X-archive-position: 13923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 02 Feb 2007 11:18:06 +0000, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Fri Feb 2 11:13:35 2007 +0000
> Commit: ef9be4f49c0c69d912f9db55fcb3bee5454c6694
> Gitweb: http://www.linux-mips.org/g/linux/ef9be4f4
> Branch: master
> 
> Oprofile cannot work on SMTC due to the limited number of counters.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/oprofile/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

!!MIPS_MT_SMTC means MIPS_MT_SMTC!=n ...

---
Atsushi Nemoto
