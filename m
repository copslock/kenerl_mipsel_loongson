Received:  by oss.sgi.com id <S553702AbQKOTqi>;
	Wed, 15 Nov 2000 11:46:38 -0800
Received: from mail.ivm.net ([62.204.1.4]:45410 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553660AbQKOTqd>;
	Wed, 15 Nov 2000 11:46:33 -0800
Received: from franz.no.dom (port73.duesseldorf.ivm.de [195.247.65.73])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA10526;
	Wed, 15 Nov 2000 20:46:21 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001115204615.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20001115004122.G927@bacchus.dhis.org>
Date:   Wed, 15 Nov 2000 20:46:15 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 14-Nov-00 Ralf Baechle wrote:
> In any case, for uniprocessor non-ll/sc machines there is also a better
> solution availble with no syscalls at all.  It's easy to implement, just
> use the fact that any exception will change the values of k0/k1.  That of
> course breaks silently on SMP.

Please, we do not even want to think about SMP boxen without ll/sc, do we?

;-)

-- 
Regards,
Harald
