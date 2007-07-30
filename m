Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 16:53:40 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:15763 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022987AbXG3Pxg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 16:53:36 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IFXVm-0001iD-SQ; Mon, 30 Jul 2007 15:50:23 +0000
Message-ID: <46AE08BD.1080400@garzik.org>
Date:	Mon, 30 Jul 2007 11:50:21 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, perex@suse.cz,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] DDB5477: Remove driver bits of support
References: <20070730154116.GA25008@linux-mips.org>
In-Reply-To: <20070730154116.GA25008@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  drivers/net/tulip/tulip_core.c |    8 
>  drivers/serial/8250_pci.c      |   20 
>  include/linux/pci_ids.h        |    1 
>  sound/oss/Kconfig              |    8 
>  sound/oss/Makefile             |    1 
>  sound/oss/nec_vrc5477.c        | 2060 -----------------------------------------
>  6 files changed, 2098 deletions(-)

ACK
