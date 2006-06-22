Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 02:22:19 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:18606 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133901AbWFVBWI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Jun 2006 02:22:08 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 22 Jun 2006 10:22:02 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id F2C63203DD;
	Thu, 22 Jun 2006 10:21:51 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id DFC152028B;
	Thu, 22 Jun 2006 10:21:51 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k5M1LpW0037430;
	Thu, 22 Jun 2006 10:21:51 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 22 Jun 2006 10:21:51 +0900 (JST)
Message-Id: <20060622.102151.126573974.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	libc-ports@sourceware.org
Subject: Re: mips RDHWR instruction in glibc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060617.005845.93020013.anemo@mba.ocn.ne.jp>
References: <20060616.002837.59465125.anemo@mba.ocn.ne.jp>
	<20060615153252.GA21598@nevyn.them.org>
	<20060617.005845.93020013.anemo@mba.ocn.ne.jp>
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
X-archive-position: 11803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 Jun 2006 00:58:45 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> It looks too bad for arg == 0 case.  I should ask on gcc list.

Filed to gcc bugzilla.

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28126

---
Atsushi Nemoto
