Received:  by oss.sgi.com id <S554221AbRBEVjH>;
	Mon, 5 Feb 2001 13:39:07 -0800
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3335 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S554120AbRBEViw>;
	Mon, 5 Feb 2001 13:38:52 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14PtMY-0004Ei-00; Mon, 5 Feb 2001 21:39:54 +0000
Subject: Re: NFS root with cache on
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Mon, 5 Feb 2001 21:39:51 +0000 (GMT)
Cc:     jsun@mvista.com (Jun Sun), jensenq@Lineo.COM (Quinn Jensen),
        linux-mips@oss.sgi.com
In-Reply-To: <20010205115026.C2487@bacchus.dhis.org> from "Ralf Baechle" at Feb 05, 2001 11:50:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PtMY-0004Ei-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> On Mon, Feb 05, 2001 at 10:07:18AM -0800, Jun Sun wrote:
> 
> > Did you set rx_copybreak to 1518?  I sent patches long time ago to the driver
> > authors for MIPS, but I am not sure they are not there.
> 
> Copybreak is just an optimization.  So even with this unused or set to a
> wrong value the driver should work.

If you set it wrongly you can get network failures/stalls. The normal cases
are not a problem however. You need to copybreak small frames to avoid filling
the socket queue with empty spaces. Some platforms set it to 1518 to force
a copy thereby aligning the IP header on a 4 byte boundary, which most
PCI bus master drivers wont do if you are not copying
