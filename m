Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 15:41:36 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:54775 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029687AbXKDPl2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Nov 2007 15:41:28 +0000
Received: from localhost (p5165-ipad307funabasi.chiba.ocn.ne.jp [123.217.183.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 80BDC9937; Mon,  5 Nov 2007 00:40:06 +0900 (JST)
Date:	Mon, 05 Nov 2007 00:42:08 +0900 (JST)
Message-Id: <20071105.004208.74752504.anemo@mba.ocn.ne.jp>
To:	fbuihuu@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Kill __bzero() 
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <472D8058.5080209@gmail.com>
References: <472D8058.5080209@gmail.com>
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
X-archive-position: 17388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 04 Nov 2007 09:18:32 +0100, Franck Bui-Huu <fbuihuu@gmail.com> wrote:
>   2/ For the caller, it makes no difference to call memset instead
>   since it has to setup the second parameter of __bzero to 0.

__bzero() does not clobber v0 but memset() does.  I don't know if gcc
does some magical thing to protect v0, but it would be safer to add v0
explicitly to clobber-list of __clear_user().

---
Atsushi Nemoto
