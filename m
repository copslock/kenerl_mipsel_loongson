Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 21:13:21 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:32722 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S21365986AbZAOVNT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 21:13:19 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id n0FLDXxn029733;
	Thu, 15 Jan 2009 21:13:33 GMT
Date:	Thu, 15 Jan 2009 21:13:33 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash
 interface (v6).
Message-ID: <20090115211333.1440db46@lxorguk.ukuu.org.uk>
In-Reply-To: <1232053053-16232-2-git-send-email-ddaney@caviumnetworks.com>
References: <496FA2E9.9030403@caviumnetworks.com>
	<1232053053-16232-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> +	reg_cfg.s.orbit = 0;	/* Don't combine with previos region */

previous ...


> +static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
> +	case ATAPI_PROT_DMA:
> +		dev_err(ap->dev, "Error, ATAPI not supported\n");
> +		BUG();

Looks as if you should also have a check_atapi_dma function that always
returns non zero (or a mode filter for atapi -> pio)


Looks good to me.
