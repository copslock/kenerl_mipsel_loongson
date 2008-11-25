Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:00:41 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:35715 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S23909259AbYKYRA0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 17:00:26 +0000
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1L51Gv-0003pI-7w; Tue, 25 Nov 2008 17:00:23 +0000
Message-ID: <492C2F23.8050105@garzik.org>
Date:	Tue, 25 Nov 2008 12:00:19 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> The forthcoming OCTEON SOC Compact Flash driver needs a few more
> timing values than were available in the ata_timing table.  I add new
> columns for write_hold, read_hold, and read_holdz times.  The values
> were obtained from the Compact Flash specification Rev 4.1.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
>  include/linux/libata.h    |   14 ++++++--
>  2 files changed, 52 insertions(+), 38 deletions(-)

I would be happy to go ahead and apply this...  Alan, any last minute 
objections?
