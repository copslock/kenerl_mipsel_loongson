Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 01:12:38 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:11761 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022928AbXCSBMg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 01:12:36 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 19 Mar 2007 10:12:35 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2DEBD41DB3;
	Mon, 19 Mar 2007 10:12:11 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 214A6201D4;
	Mon, 19 Mar 2007 10:12:11 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2J1C9W0045956;
	Mon, 19 Mar 2007 10:12:10 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 19 Mar 2007 10:12:09 +0900 (JST)
Message-Id: <20070319.101209.79013781.nemoto@toshiba-tops.co.jp>
To:	maillist@jg555.com
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: Building 64 bit kernel on Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45FDB498.1040504@jg555.com>
References: <45F5F709.6060707@jg555.com>
	<cda58cb80703130338t57240ba9m15e6b0e37da875b4@mail.gmail.com>
	<45FDB498.1040504@jg555.com>
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
X-archive-position: 14535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 18 Mar 2007 14:52:24 -0700, Jim Gifford <maillist@jg555.com> wrote:
> Frank,
>     Got it narrowed down further. This reverting these 3 sections will 
> allow it to boot, but then mounting root it gives a unaligned access 
> error. Reverting all the changes to setup.c, fixes the issue and boots 
> completely.

You said you are not using initrd, right?  I can not see why these
changes affects non-initrd environment.  Full boot log and .config
would help us to find what was wrong.

---
Atsushi Nemoto
