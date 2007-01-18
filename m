Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 11:23:00 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:58837 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28580215AbXARLW6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 11:22:58 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 18 Jan 2007 20:22:57 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 60EF13A3E0;
	Thu, 18 Jan 2007 20:22:53 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4D97C20403;
	Thu, 18 Jan 2007 20:22:53 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l0IBMqW0073293;
	Thu, 18 Jan 2007 20:22:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 18 Jan 2007 20:22:52 +0900 (JST)
Message-Id: <20070118.202252.29576513.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	danieljlaird@hotmail.com, linux-mips@linux-mips.org
Subject: Re: Install Headers Target
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070118110643.GC23469@networkno.de>
References: <8426876.post@talk.nabble.com>
	<20070118110643.GC23469@networkno.de>
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
X-archive-position: 13706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 18 Jan 2007 11:06:43 +0000, Thiemo Seufer <ths@networkno.de> wrote:
> > Is it possible for this to go in? (Any one any problems with this patch)
> > Is this mailing list the correct one for this patch?
> 
> For a glibc configuration those files are provided by glibc. I think
> uClibc should do the same, the files aren't Linux specific.

uClibc svn already do the same.  If any references to asm/asm.h,
asm/regdef was remained in uClibc, please fix them.

---
Atsushi Nemoto
