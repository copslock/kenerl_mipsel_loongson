Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2007 04:02:04 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:39047 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021887AbXC3DBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Mar 2007 04:01:37 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 30 Mar 2007 12:01:35 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B8388427BA;
	Fri, 30 Mar 2007 12:01:07 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8AA2D427E0;
	Fri, 30 Mar 2007 12:01:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2U316W0096851;
	Fri, 30 Mar 2007 12:01:06 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 30 Mar 2007 12:01:06 +0900 (JST)
Message-Id: <20070330.120106.96687664.nemoto@toshiba-tops.co.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <460C7404.2020209@gentoo.org>
	<45D8B070.7070405@gentoo.org>
References: <460A6CED.1070308@gentoo.org>
	<20070329.002453.18311528.anemo@mba.ocn.ne.jp>
	<460C7404.2020209@gentoo.org>
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
X-archive-position: 14776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 29 Mar 2007 22:20:52 -0400, Kumba <kumba@gentoo.org> wrote:
> > Just an optimization.  For CKSEG0 symbol, a LUI instruction can fill
> > high 32-bit by sign-extention.  Either code should work for CKSEG0
> > kernel.
> 
> Well, thinking about it some more, can this stackframe change be segmented out 
> of Frank's main patches, so we can get them into git, and spend time in 
> 2.6.21/2.6.22/2.6.23 chasing down what exactly is up with this specific asm 
> sequence?

This is not Franck's fault.  His patchset does not change behavior if
kernel load address was CKSEG0 and CONFIG_BUILD_ELF64 was not set
(unless you are using gcc 3.x).

Let's clarify things a bit: The Franck's patchset is _not_ fix.  It
just tried to avoid undesirable configuration (CKSEG0 kernel with
BUILD_ELF64=y), and clarify some namings.

So I should ask you again, does current git (or 2.6.20-stable) kernel
compiled by binutils-2.17/gcc-4.[12] work for IP32 if you disabled
CONFIG_BUILD_ELF64?

On Sun, 18 Feb 2007 15:00:48 -0500, Kumba <kumba@gentoo.org> wrote:
> The [short-term] fix highlighted by Ilya is to make __pa() unconditionally be 
> defined to "((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)"; Discovered by 
> building IP32 with CONFIG_BUILD_ELF64=n.

So I had thought CONFIG_BUILD_ELF64=n worked for IP32...

---
Atsushi Nemoto
