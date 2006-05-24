Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 07:30:00 +0200 (CEST)
Received: from srv5.dvmed.net ([207.36.208.214]:7648 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S8133353AbWEXF3w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2006 07:29:52 +0200
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FilwL-0005a4-63; Wed, 24 May 2006 05:29:49 +0000
Message-ID: <4473EF4C.9010104@pobox.com>
Date:	Wed, 24 May 2006 01:29:48 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Herbert Valerio Riedel <hvr@gnu.org>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH] au1000_eth.c: use ether_crc() from <linux/crc32.h>
References: <E1FaYil-0007A8-HB@fencepost.gnu.org>
In-Reply-To: <E1FaYil-0007A8-HB@fencepost.gnu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Herbert Valerio Riedel wrote:
> since the au1000 driver already selects the CRC32 routines, simply replace
> the internal ether_crc() implementation with the semantically equivalent
> one from <linux/crc32.h>
> 
> Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>

does not apply, please resend
