Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 14:28:31 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:5211 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225192AbTCaN2a>;
	Mon, 31 Mar 2003 14:28:30 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id 2F409720; Mon, 31 Mar 2003 15:28:30 +0200 (CEST)
To: linux-mips@linux-mips.org
Subject: Re: [Patch-2.5] Add path to elf2ecoff
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030331124940.GL26678@lug-owl.de> (Jan-Benedict Glaw's
 message of "Mon, 31 Mar 2003 14:49:40 +0200")
References: <20030331124940.GL26678@lug-owl.de>
Date: Mon, 31 Mar 2003 15:28:30 +0200
Message-ID: <86fzp34qdd.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "jbglaw" == Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

jbglaw> Hi!
jbglaw> This small patch is needed since `pwd` is _not_ the directory a
jbglaw> Makefile resides in.

jbglaw> MfG, JBG


jbglaw> Index: arch/mips/boot/Makefile
jbglaw> ===================================================================
jbglaw> RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/arch/mips/boot/Makefile,v
jbglaw> retrieving revision 1.22
jbglaw> diff -u -r1.22 Makefile
jbglaw> --- arch/mips/boot/Makefile	9 Mar 2003 13:58:13 -0000	1.22
jbglaw> +++ arch/mips/boot/Makefile	31 Mar 2003 12:38:59 -0000
jbglaw> @@ -32,7 +32,7 @@
jbglaw> $< $@
 
jbglaw> vmlinux.ecoff:	$(obj)/elf2ecoff vmlinux
jbglaw> -	./elf2ecoff vmlinux $(obj)/vmlinux.ecoff $(E2EFLAGS)
jbglaw> +	$(obj)/elf2ecoff vmlinux $(obj)/vmlinux.ecoff $(E2EFLAGS)
 
jbglaw> $(obj)/elf2ecoff: $(obj)/elf2ecoff.c
jbglaw> $(HOSTCC) -o $@ $^

I agree, I had to add it also to get it to compile :p


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
