Received:  by oss.sgi.com id <S42217AbQGESYc>;
	Wed, 5 Jul 2000 11:24:32 -0700
Received: from mail.ivm.net ([62.204.1.4]:26905 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S42213AbQGESYN>;
	Wed, 5 Jul 2000 11:24:13 -0700
Received: from franz.no.dom (port94.duesseldorf.ivm.de [195.247.65.94])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA00684;
	Wed, 5 Jul 2000 20:24:11 +0200
X-To:   ulfc@oss.sgi.com
Message-ID: <XFMail.000705202420.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20000704232215.B4977@bacchus.dhis.org>
Date:   Wed, 05 Jul 2000 20:24:20 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
Cc:     linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com, Ulf Carlsson <ulfc@oss.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 04-Jul-00 Ralf Baechle wrote:
> I've commited a fix for this.  It only tackles the __udelay() functions
> for mips and mips64 but not the other multu instruction in the
> DECstation HZ_TO_STD function.  Can you take a look at this one?

Done.

-- 
Regards,
Harald
