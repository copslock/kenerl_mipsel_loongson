Received:  by oss.sgi.com id <S553915AbQKDKjs>;
	Sat, 4 Nov 2000 02:39:48 -0800
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2846 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S553912AbQKDKje>;
	Sat, 4 Nov 2000 02:39:34 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 13s0ke-0004Sa-00; Sat, 4 Nov 2000 10:40:44 +0000
Subject: Re: Kernel compiler
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Sat, 4 Nov 2000 10:40:42 +0000 (GMT)
Cc:     kaos@melbourne.sgi.com (Keith Owens), linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
In-Reply-To: <20001104035326.A29005@bacchus.dhis.org> from "Ralf Baechle" at Nov 04, 2000 03:53:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13s0ke-0004Sa-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> The reports regarding egcs 2.96 and newer misscompiling the kernel only
> affect x86 or are other architecture affected as well?  I don't have any
> pending compiler >= 2.96 related bug reports.

The Red Hat 2.96 seems to compile 2.2 correctly when you fix the 2.2 bugs but
does miscompile x86 fs/buffers.c on 2.4 according to reports. I think with mips
you'd have to experiment. Also AFAIK that tree branch hasn't been tested on
mips 
