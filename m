Received:  by oss.sgi.com id <S554115AbRBEMJy>;
	Mon, 5 Feb 2001 04:09:54 -0800
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51986 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S554245AbRBEMJi>;
	Mon, 5 Feb 2001 04:09:38 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14PkTf-0003DK-00; Mon, 5 Feb 2001 12:10:39 +0000
Subject: Re: Filesystem corruption
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Mon, 5 Feb 2001 12:10:37 +0000 (GMT)
Cc:     carstenl@mips.com (Carsten Langgaard), linux-mips@oss.sgi.com
In-Reply-To: <20010205020241.A30062@bacchus.dhis.org> from "Ralf Baechle" at Feb 05, 2001 02:02:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PkTf-0003DK-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 2.4.1 is known to cause fs corruption for all architectures; 2.4.0 should
> actually be fine.  I just reached 8 days of uptime on a 32p Origin 2000,
> so it can't be that bad.

Im tracking fs corruption and worse on 2.4.0 as well (zero page corruptions
since 2.4.0test10 for example)

I dont believe any 2.4 is currently 'safe'
