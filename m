Received:  by oss.sgi.com id <S553738AbQKOUR6>;
	Wed, 15 Nov 2000 12:17:58 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:62714 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553708AbQKOURy>;
	Wed, 15 Nov 2000 12:17:54 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eAFKFN319254;
	Wed, 15 Nov 2000 12:15:23 -0800
Message-ID: <3A12EF72.980C8E92@mvista.com>
Date:   Wed, 15 Nov 2000 12:17:54 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
CC:     linux-mips@oss.sgi.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
References: <XFMail.001115204613.Harald.Koerfgen@home.ivm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Harald Koerfgen wrote:
> > I also doubt if k0 is absolutely non-zero after a context ...
> 
> That's not the problem here, yes, it is. At least for the the CONFIG_CPU_R3000
> case. Have a look at include/asm-mips/stackframe.h, especially the R3000
> version of the RESTORE_SP_AND_RET macro.
> 

I did not doubt the non-zero value of k0.  I really doubted the
approach: a userland primitive is based on non-documented,
non-guarranteed kernel stack restoring code.  Once something changes in
kernel, you will get really obscure bugs.

Jun
