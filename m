Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 17:02:01 +0000 (GMT)
Received: from [85.8.13.51] ([85.8.13.51]:31681 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S8133583AbWAFRBo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2006 17:01:44 +0000
Received: from [10.8.0.5] (apollo.drzeus.cx [::ffff:10.8.0.5])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Fri, 06 Jan 2006 18:04:24 +0100
  id 00062716.43BEA318.00007826
Message-ID: <43BEA317.8010203@drzeus.cx>
Date:	Fri, 06 Jan 2006 18:04:23 +0100
From:	Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	linux-mips@linux-mips.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH]  Force MMC/SD to 512 byte block sizes
References: <20060106164406.GA15617@cosmic.amd.com>
In-Reply-To: <20060106164406.GA15617@cosmic.amd.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

Jordan Crouse wrote:
> This patch is not specific to the AU1200 SD driver, but thats what
> we used to debug and verify this, so thats why it is applied against
> the linux-mips tree.   Pierre, I'm sending this to you too, because I thought
> you may be interested.

Much appreciated. :)

> 
> Large SD cards (>=2GB) report a physical block size greater then 512 bytes
> (2GB reports 1024, and 4GB reports 2048).  However, a sample of different 
> brands of USB attached SD readers have shown that the logical block size 
> is still forced to 512 bytes.
> 
> The original mmc_block code was setting the block size to whatever the
> card was reporting, thereby causing much pain and suffering when using
> a card initialized elsewhere (bad partition tables, invalid FAT tables, etc).
> 
> This patch forces the block size to be 512 bytes, and adjusts the 
> capacity accordingly.   With this you should be able to happily use very
> large cards interchangeably between platforms.  At least, it has worked for
> us.
> 
> 
> @@ -373,7 +383,7 @@ mmc_blk_set_blksize(struct mmc_blk_data 
>  
>  	mmc_card_claim_host(card);
>  	cmd.opcode = MMC_SET_BLOCKLEN;
> -	cmd.arg = 1 << card->csd.read_blkbits;
> +	cmd.arg = 1 << ((card->csd.read_blkbits > 9) ? 9 : card->csd.read_blkbits);
>  	cmd.flags = MMC_RSP_R1;
>  	err = mmc_wait_for_cmd(card->host, &cmd, 5);
>  	mmc_card_release_host(card);

This will not work. Some cards do not accept block sizes larger than the
one they've specified.

This issue has been discussed on the arm kernel ml and Russell has begun
producing patches to resolve the issue.

To solve the issue you're seeing we should lie to the block layer, not
the card. Which will cause problems when the block layer issues request
that cannot be mapped to a integer number of card blocks.

The issue is more complex than your patch suggests and I do not know
enough about the block layer to propose a way out.

Rgds
Pierre
