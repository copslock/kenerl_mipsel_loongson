Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2009 00:02:42 +0100 (BST)
Received: from mail-out.m-online.net ([212.18.0.9]:35618 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S28574086AbZEAXCf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2009 00:02:35 +0100
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 241241C15368;
	Sat,  2 May 2009 01:02:15 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 8B89E90197;
	Sat,  2 May 2009 01:02:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id J5MY1fAE9fML; Sat,  2 May 2009 01:02:13 +0200 (CEST)
Received: from igel.home (DSL01.83.171.176.91.ip-pool.NEFkom.net [83.171.176.91])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  2 May 2009 01:02:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E9F0B10DA5D; Sat,  2 May 2009 01:02:12 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	"H. Peter Anvin" <hpa@zytor.com>
Cc:	Sam Ravnborg <sam@ravnborg.org>, linux-mips@linux-mips.org,
	linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Tim Abbott <tabbott@MIT.EDU>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>,
	Jeff Arnold <jbarnold@MIT.EDU>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	Michal Simek <monstr@monstr.eu>, Waseem Daher <wdaher@MIT.EDU>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>,
	Bryan Wu <cooloney@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss sections.
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
	<1241121253-32341-2-git-send-email-tabbott@mit.edu>
	<20090501091848.GB18326@uranus.ravnborg.org>
	<alpine.DEB.1.10.0905010951100.3955@vinegar-pot.mit.edu>
	<49FB2449.1010301@zytor.com>
	<20090501171717.GA26401@uranus.ravnborg.org>
	<49FB2EDC.9050300@zytor.com>
	<20090501174457.GA26559@uranus.ravnborg.org>
	<49FB35C4.6060107@zytor.com>
X-Yow:	I'm MENTALLY here..  but PHYSICALLY I'm purchasing NAUGAHYDE furniture
 in the' SUBURBS of PHOENIX!!
Date:	Sat, 02 May 2009 01:02:12 +0200
In-Reply-To: <49FB35C4.6060107@zytor.com> (H. Peter Anvin's message of "Fri,
	01 May 2009 10:47:48 -0700")
Message-ID: <m2tz44o2a3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.93 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
Precedence: bulk
X-list: linux-mips

"H. Peter Anvin" <hpa@zytor.com> writes:

> Sam Ravnborg wrote:
>>>
>>> What's wrong with @?
>> arm does not support it :-(
>> I recall it denote a comment in arm assembler.
>> 
>> I could do some magic to detect the ARM case but I'm reluctant to do so.
>> I could also ignore the arm issue for now as it is not used by arm,
>> but that strikes me as the wrong approach.
>> 
>
> If we really have to use different tokens, I would say:
>
> #ifdef __ARM__
> # define _PROGBITS %progbits	/* or whatever */
> # define _NOBITS   %nobits
> #else
> # define _PROGBITS @progbits
> # define _NOBITS   @nobits
> #endif

GAS has always supported both '@' and '%', so '%' can be used
everywhere.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
