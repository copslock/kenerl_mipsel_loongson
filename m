Received:  by oss.sgi.com id <S553781AbQLSRJG>;
	Tue, 19 Dec 2000 09:09:06 -0800
Received: from mail.ivm.net ([62.204.1.4]:41513 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553712AbQLSRIz>;
	Tue, 19 Dec 2000 09:08:55 -0800
Received: from franz.no.dom (port53.duesseldorf.ivm.de [195.247.65.53])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA21041;
	Tue, 19 Dec 2000 18:02:55 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001219180301.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.GSO.3.96.1001219140739.10024F-100000@delta.ds2.pg.gda.pl>
Date:   Tue, 19 Dec 2000 18:03:01 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: MIPS_ATOMIC_SET in sys_sysmips()
Cc:     linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>,
        Jun Sun <jsun@mvista.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 19-Dec-00 Maciej W. Rozycki wrote:
> On Mon, 18 Dec 2000, Jun Sun wrote:
>> What do we offer to machines without ll/sc?
> 
>  I asked Ralf for a clarification of the sysmips(MIPS_ATOMIC_SET, ...) 
> call before I write better code.  No response so far.  I'm now really
> cosidering implementing the Ultrix atomic_op() syscall -- at least it has
> a well-known defined behaviour. 

Another possibility would be to rely on the userland ll/sc emulation in the
kernel. The one in the linux-vr tree seems to be working well and can easily be
backported to Linux/MIPS.

Advantage: userland binary compatibility.
Disadvantage: possibility for a lot of context switches for userland atomic
operations.
 
Having a sysmips(MIPS_ATOMIC_SET, ...) or atomic_op() solution would probably a
lot faster.

Maybe we should implement both :)

-- 
Regards,
Harald
