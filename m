Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 17:11:47 +0100 (BST)
Received: from p060080.ppp.asahi-net.or.jp ([IPv6:::ffff:221.113.60.80]:2295
	"EHLO mitou.ysato.dip.jp") by linux-mips.org with ESMTP
	id <S8225433AbTJVQLo>; Wed, 22 Oct 2003 17:11:44 +0100
Received: from ss3380.ysato.zive.net (ss3380.localdomain [192.168.16.12])
	by mitou.ysato.dip.jp (Postfix) with ESMTP
	id 32B591C194; Thu, 23 Oct 2003 01:11:39 +0900 (JST)
Date: Thu, 23 Oct 2003 01:11:39 +0900
Message-ID: <m2he218d6s.wl%ysato@users.sourceforge.jp>
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Matthew Wilcox <willy@debian.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Jeff Dike <jdike@karaya.com>,
	linux-mips@linux-mips.org,
	user-mode-linux-devel@lists.sourceforge.net
Subject: Re: asm/smplock.h is dead
In-Reply-To: <20031021230932.GM18370@parcelfarce.linux.theplanet.co.uk>
References: <20031021230932.GM18370@parcelfarce.linux.theplanet.co.uk>
User-Agent: Wanderlust/2.11.7 (Wonderwall) SEMI/1.14.5 (Awara-Onsen) LIMIT/1.14.7 (Fujiidera) APEL/10.6 Emacs/21.3 (i386-pc-linux-gnu) MULE/5.0 (SAKAKI)
MIME-Version: 1.0 (generated by SEMI 1.14.5 - "Awara-Onsen")
Content-Type: text/plain; charset=US-ASCII
Return-Path: <ysato@users.sourceforge.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ysato@users.sourceforge.jp
Precedence: bulk
X-list: linux-mips

At Wed, 22 Oct 2003 00:09:32 +0100,
Matthew Wilcox wrote:
> 
> 
> asm/smplock.h is dead, you're the only three arches that still have it.
> Can you delete next time you merge?  Thanks.
> 
> $ find -type f |xargs grep smplock.h      
> ./arch/mips/sibyte/sb1250/bcm1250_tbprof.c:#include <asm/smplock.h>
> ./include/asm-h8300/smplock.h: * <asm/smplock.h>
> ./include/asm-um/smplock.h:#include "asm/arch/smplock.h"
> $ find -name smplock.h
> ./include/asm-h8300/smplock.h
> ./include/asm-mips/smplock.h
> ./include/asm-um/smplock.h
> 
> (the sibyte driver can just lose this line.  it doesn't do any SMP locking)
> 

I deleted it.
Thank you.

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
