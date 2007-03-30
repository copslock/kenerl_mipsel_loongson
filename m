Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2007 07:09:45 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:18972 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021417AbXC3GJo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Mar 2007 07:09:44 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 30 Mar 2007 15:09:38 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6768142701;
	Fri, 30 Mar 2007 15:09:13 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5C2EF42700;
	Fri, 30 Mar 2007 15:09:13 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2U69CW0097613;
	Fri, 30 Mar 2007 15:09:12 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 30 Mar 2007 15:09:12 +0900 (JST)
Message-Id: <20070330.150912.11964158.nemoto@toshiba-tops.co.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <460CA1AB.1080608@gentoo.org>
References: <460C7404.2020209@gentoo.org>
	<20070330.120106.96687664.nemoto@toshiba-tops.co.jp>
	<460CA1AB.1080608@gentoo.org>
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
X-archive-position: 14778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 30 Mar 2007 01:35:39 -0400, Kumba <kumba@gentoo.org> wrote:
> > So I should ask you again, does current git (or 2.6.20-stable) kernel
> > compiled by binutils-2.17/gcc-4.[12] work for IP32 if you disabled
> > CONFIG_BUILD_ELF64?
> [snip]
> > So I had thought CONFIG_BUILD_ELF64=n worked for IP32...
> 
> 
> If memory serves, yes, it'll boot, because it's close to the old way I that I 
> used to use when building them.  Prior to 2.6.17, I did CONFIG_BUILD_ELF64=n 
> with -mabi=o64.  This let me use the plain 'vmlinux' target without any special 
> changes.  2.6.17 is when I stopped using gcc-3.x for kernels, moved to 4.x, and 
> started using CONFIG_BUILD_ELF64=y w/ -msym32 and friends.  Thus I now use 
> vmlinux.32.  I was told that that was the RightWay(TM) to do it.

IMHO here is a root of confusion.  The -msym32 option is/was enabled
only if CONFIG_BUILD_ELF64=n.  The vmlinux.32 thing are controled by
CONFIG_BOOT_ELF32 or CONFIG_BOOT_ELF64.  The word BOOT and BUILD seems
too umbiguous ;)

> Hence, the real point of this long chain is mainly to accomplish two things:
> 
> 1) Finally determine the OneTrueWay(TM) to build 64bit kernels for our three 
> main CKSEG0-based systems (ip22, ip32, cobalt), and get that way documented so 
> as to avoid confusion in the future.
> 
> 2) Get a solution into the tree that does #1, and does it well.  So far, Frank's 
> patch seems like the leading contender here.

Yes.  I agree.

And I think the answer is

1) Disable CONFIG_BUILD_ELF64 in short term.

2) Apply Franck's patchset with a slight change (enclose -msym32 by
   $(call cc-option)).

And _if_ this did not work on IP32, something needs to be fixed, but I
can not see why for now.

---
Atsushi Nemoto
