Received:  by oss.sgi.com id <S42310AbQJEMJ2>;
	Thu, 5 Oct 2000 05:09:28 -0700
Received: from u-143.karlsruhe.ipdial.viaginterkom.de ([62.180.18.143]:51460
        "EHLO u-143.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42201AbQJEMJB>; Thu, 5 Oct 2000 05:09:01 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868668AbQJEMH6>;
        Thu, 5 Oct 2000 14:07:58 +0200
Date:   Thu, 5 Oct 2000 14:07:58 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Current CVS kernel doesnt compile
Message-ID: <20001005140758.D30075@bacchus.dhis.org>
References: <20001005120843.D346@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001005120843.D346@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Oct 05, 2000 at 12:08:43PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 05, 2000 at 12:08:43PM +0200, Florian Lohoff wrote:

> /var/tmp/mips/src/linux-decr4k-current/include/asm/semaphore-helper.h: In function `waking_non_zero':
> In file included from semaphore.c:7:
> /var/tmp/mips/src/linux-decr4k-current/include/asm/semaphore-helper.h:95: warning: implicit declaration of function `__atomic_fool_gcc'
> /var/tmp/mips/src/linux-decr4k-current/include/asm/semaphore-helper.h:96: output number 2 not directly addressable
> make[1]: *** [semaphore.o] Error 1
> make[1]: Leaving directory `/var/tmp/mips/src/linux-decr4k-current/arch/mips/kernel'
> make: *** [_dir_arch/mips/kernel] Error 2

Sorry, the tags of my private cvs archive got messed up which resulted in
a bogus patch that I merged into oss.  I'll tackle that immeditely.

  Ralf
