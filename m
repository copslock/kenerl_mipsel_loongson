Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2003 11:09:00 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:53776 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225199AbTCLLI7>;
	Wed, 12 Mar 2003 11:08:59 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 49CC26EC; Wed, 12 Mar 2003 12:08:58 +0100 (CET)
To: KUNITAKE Koichi <kunitake@linux-ipv6.org>
Cc: usagi-users@linux-ipv6.org, linux-mips@linux-mips.org
Subject: Re: (usagi-users 02267) Re: Usagi kernel for MIPS target
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <E18t3LT-0002It-00@stardust> (KUNITAKE Koichi's message of
 "Wed, 12 Mar 2003 19:20:22 +0900")
References: <20030312084946.7398.qmail@webmail27.rediffmail.com>
	<E18t3LT-0002It-00@stardust>
Date: Wed, 12 Mar 2003 12:08:58 +0100
Message-ID: <86y93kalkl.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "kunitake" == KUNITAKE Koichi <kunitake@linux-ipv6.org> writes:

kunitake> I think you cant use "xconfig" on Cross-compiling env, please edit
kunitake> linux24/Makefile and use "make config". After all, please exec following
kunitake> commands.

kunitake> $ make config
kunitake> $ make dep; make clean; make zImage

I bet that a make vmlinux or make vmlinux.ecoff is better than zImage
on mips :p

Go to source.

My mips tree don't have a zImage at all :p

Later, juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
