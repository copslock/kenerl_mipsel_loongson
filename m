Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 16:41:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:38378 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022615AbXCYPlp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Mar 2007 16:41:45 +0100
Received: from localhost (p7179-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.179])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1456AB8D0; Mon, 26 Mar 2007 00:40:25 +0900 (JST)
Date:	Mon, 26 Mar 2007 00:40:24 +0900 (JST)
Message-Id: <20070326.004024.126573604.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org, vagabon.xyz@gmail.com
Subject: Re: Building 64 bit kernel on Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070324231602.GP2311@networkno.de>
References: <46049BAD.1010705@gentoo.org>
	<20070324.234727.25910303.anemo@mba.ocn.ne.jp>
	<20070324231602.GP2311@networkno.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 24 Mar 2007 23:16:02 +0000, Thiemo Seufer <ths@networkno.de> wrote:
> IMO -msym32 should depend on:
>     ((Compiler can do -msym32)
>      && (load address is in ckseg0)
>      && CONFIG_64BIT)
> 
> which obsoletes the whole CONFIG_BUILD_ELF* stuff.

Sure.  And it is already done by Franck but is still pending (why?).

http://www.linux-mips.org/archives/linux-mips/2007-02/msg00228.html
http://www.linux-mips.org/archives/linux-mips/2007-02/msg00227.html
http://www.linux-mips.org/archives/linux-mips/2007-02/msg00231.html

---
Atsushi Nemoto
