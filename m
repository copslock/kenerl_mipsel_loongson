Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2006 05:20:10 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:49326 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20037692AbWLBFUF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2006 05:20:05 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1GqNI8-0007sD-3H; Sat, 02 Dec 2006 05:20:00 +0000
Message-ID: <45710CFE.5090007@pobox.com>
Date:	Sat, 02 Dec 2006 00:19:58 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.18] declance: Support the I/O ASIC LANCE w/o TURBOchannel
References: <Pine.LNX.4.64N.0611301306460.1757@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0611301306460.1757@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  The onboard LANCE of I/O ASIC systems is not a TURBOchannel device, at 
> least from the software point of view.  Therefore it does not rely on any 
> kernel TURBOchannel bus services and can be supported even if support for 
> TURBOchannel has not been enabled in the configuration.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

can you (or Andrew) please resend your patches against 2.6.19?

	Jeff
