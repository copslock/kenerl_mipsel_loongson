Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 06:07:34 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:741 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021368AbXCSGHa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 06:07:30 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 19 Mar 2007 15:07:29 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 424D520468;
	Mon, 19 Mar 2007 15:07:06 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2E08A203FD;
	Mon, 19 Mar 2007 15:07:06 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2J675W0047245;
	Mon, 19 Mar 2007 15:07:05 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 19 Mar 2007 15:07:05 +0900 (JST)
Message-Id: <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>
To:	maillist@jg555.com
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: Building 64 bit kernel on Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45FE1D95.8050204@jg555.com>
References: <45FDB498.1040504@jg555.com>
	<20070319.101209.79013781.nemoto@toshiba-tops.co.jp>
	<45FE1D95.8050204@jg555.com>
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
X-archive-position: 14539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 18 Mar 2007 22:20:21 -0700, Jim Gifford <maillist@jg555.com> wrote:
> Here's the config file I'm using http://ftp.jg555.com/cobalt.config
> Now if I revert all changes that have occurred to setup.c from 2.6.19 to 
> 2.6.20, everything works perfectly.
> 
> Without that patch, this is as far as it gets.

You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
This combination does not work.  Please refer these threads:

http://www.linux-mips.org/archives/linux-mips/2006-10/msg00064.html
http://www.linux-mips.org/archives/linux-mips/2006-10/msg00154.html
http://www.linux-mips.org/archives/linux-mips/2007-01/msg00305.html

Please try CONFIG_BUILD_ELF64=n.

BTW, Ralf, any chance to Franck's CONFIG_BUILD_ELF64 cleanup patchset?
I hope the patchset make things clearer...

---
Atsushi Nemoto
