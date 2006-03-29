Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 01:49:59 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:19864 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133727AbWC2Atu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 01:49:50 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 29 Mar 2006 10:00:20 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1F9DA204BC;
	Wed, 29 Mar 2006 10:00:18 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0C7F1202ED;
	Wed, 29 Mar 2006 10:00:18 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k2T10G4D089546;
	Wed, 29 Mar 2006 10:00:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 29 Mar 2006 10:00:16 +0900 (JST)
Message-Id: <20060329.100016.74752734.nemoto@toshiba-tops.co.jp>
To:	pf@net.alphadv.de
Cc:	linux-mips@linux-mips.org
Subject: Re: compilation problem with kernel 2.6.15 
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.58.0603290104010.634@Indigo2.Peter>
References: <20060328143708.57991.qmail@web53507.mail.yahoo.com>
	<Pine.LNX.4.58.0603290104010.634@Indigo2.Peter>
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
X-archive-position: 10972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 29 Mar 2006 01:06:48 +0200 (CEST), peter fuerst <pf@net.alphadv.de> said:
> defining `__gu_val' of type `const char', which gcc 4.2 (don't know
> about 4.1) no longer accepts as asm-output (lvalue).  At least until
> this macro will be changed, you should switch back to gcc 4.0.

This is same as gcc 4.1 and the macro in kernel 2.6.16 has been fixed
already.  This issue was discussed several times in linux-mips ML.

---
Atsushi Nemoto
