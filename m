Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2006 00:46:22 +0000 (GMT)
Received: from gateway-1237.mvista.com ([63.81.120.158]:52725 "EHLO
	hermes.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133626AbWBVAqN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Feb 2006 00:46:13 +0000
Received: from [10.0.10.193] (slurryseal.ddns.mvista.com [10.0.10.193])
	by hermes.mvista.com (Postfix) with ESMTP
	id 3C8211AFE5; Tue, 21 Feb 2006 16:53:17 -0800 (PST)
Message-ID: <43FBB6FF.4070203@mvista.com>
Date:	Tue, 21 Feb 2006 16:57:35 -0800
From:	Todd Poynor <tpoynor@mvista.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] PNX8550 NAND flash driver
References: <43A2F819.1040106@ru.mvista.com> <43C69EC2.2070601@mvista.com> <43F1D439.60205@ru.mvista.com>
In-Reply-To: <43F1D439.60205@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tpoynor@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpoynor@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Vladimir -- a couple comments.

> +	PNX8550_XIO_FLASH_CTRL = reg_nand;
> +	barrier();
> +}

barrier() at the end of a function shouldn't be needed, function exit is 
an implicit optimizer flush?


> +	pnx8550_nand_alloc_transfer_buffer();
> +
> +	memcpy(transferBuffer, buf, len);

Something should check for NULL return from kmalloc in both places this 
is called.

> +	/* Scan to find existence of the device */
> +	if (nand_scan(&pnx8550_mtd, 1)) {
> +		printk(KERN_ERR "No NAND devices\n");
> +		return -ENXIO;
> +	}
> +
> +	if (!transferBuffer) {
> +		printk(KERN_ERR
> +		    "Unable to allocate NAND data buffer for PNX8550\n");
> +		return -ENOMEM;
> +	}

Not sure why transferBuffer was expected to be allocated at this point 
(only when first read/write_buf called, scan does read_byte)?


-- 
Todd
