Received:  by oss.sgi.com id <S553660AbQKOTqs>;
	Wed, 15 Nov 2000 11:46:48 -0800
Received: from mail.ivm.net ([62.204.1.4]:48738 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553694AbQKOTqi>;
	Wed, 15 Nov 2000 11:46:38 -0800
Received: from franz.no.dom (port73.duesseldorf.ivm.de [195.247.65.73])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA10519;
	Wed, 15 Nov 2000 20:46:19 +0100
X-To:   ralf@oss.sgi.com
Message-ID: <XFMail.001115204613.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3A11FF44.D7B8D826@mvista.com>
Date:   Wed, 15 Nov 2000 20:46:13 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Jun Sun <jsun@mvista.com>
Subject: Re: Build failure for R3000 DECstation
Cc:     linux-mips@oss.sgi.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ralf Baechle <ralf@oss.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 15-Nov-00 Jun Sun wrote:
[R3000 UP userland spinlocks]
> In fact, I don't think you can perform automic operation ONLY based on
> the knowledge whether a context switch has happened during a specified
> period.  (It should be interesting to see if we can actually "prove"
> it.)

I doubt this as well, although I'd love to be proven wrong.
 
> I also doubt if k0 is absolutely non-zero after a context ...

That's not the problem here, yes, it is. At least for the the CONFIG_CPU_R3000
case. Have a look at include/asm-mips/stackframe.h, especially the R3000
version of the RESTORE_SP_AND_RET macro.

-- 
Regards,
Harald
