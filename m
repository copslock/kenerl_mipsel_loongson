Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 17:37:57 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:10257 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23819273AbYKURht (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 17:37:49 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DE0DF3EC9; Fri, 21 Nov 2008 09:37:44 -0800 (PST)
Message-ID: <4926F1EB.8090506@ru.mvista.com>
Date:	Fri, 21 Nov 2008 20:37:47 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com>
In-Reply-To: <49261BE5.2010406@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> As part of our efforts to get the Cavium OCTEON processor support
> merged (see: http://marc.info/?l=linux-mips&m=122704699515601), we
> have this CF driver for your consideration.

> Most OCTEON variants have *no* DMA or interrupt support on the CF
> interface so for these, only PIO is supported.  Although if DMA is
> available, we do take advantage of it.

> The register definitions are part of the chip support patch set
> mentioned above, and are not included here.

> At this point I would like to get feedback on the patch and would
> expect that it would merge via the linux-mips tree along with the rest
> of the chip support.

> Thanks,

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> new file mode 100644
> index 0000000..e8712c0
> --- /dev/null
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -0,0 +1,942 @@
[...]
> +/**
> + * Handle an I/O request.
> + *
> + * @cf:         Device to access
> + * @lba_sector: Starting sector
> + * @num_sectors:
> + *                   Number of sectors to transfer
> + * @buffer:     Data buffer
> + * @write:      Is the a write. Default to a read
> + */
> +static unsigned int octeon_cf_data_xfer(struct ata_device *dev,
> +                    unsigned char *buffer,
> +                    unsigned int buflen,
> +                    int rw)
> +{
> +    struct ata_port *ap        = dev->link->ap;
> +    struct octeon_cf_data *ocd    = ap->dev->platform_data;
> +    void __iomem *data_addr        = ap->ioaddr.data_addr;
> +    unsigned int words;
> +    unsigned int count;
> +
> +    /*
> +     * Odd lengths are not supported. We should always be a
> +     * multiple of 512.
> +     */
> +    BUG_ON(buflen & 1);
> +    if (ocd->is16bit) {
> +        words = buflen / 2;
> +        if (rw) {
> +            count = 16;
> +            while (words--) {
> +                iowrite16(*(uint16_t *)buffer, data_addr);
> +                buffer += sizeof(uint16_t);
> +                /*
> +                 * Every 16 writes do a read so the
> +                 * bootbus FIFO doesn't fill up.
> +                 */
> +                if (--count == 0) {
> +                    ioread8(ap->ioaddr.altstatus_addr);
> +                    count = 16;
> +                }
> +            }
> +        } else {
> +            while (words--) {
> +                *(uint16_t *)buffer = ioread16(data_addr);
> +                buffer += sizeof(uint16_t);
> +            }
> +        }
> +    } else {
> +        /* 8-bit */
> +        words = buflen;
> +        if (rw) {
> +            count = 16;
> +            while (words--) {
> +                iowrite8(*buffer, data_addr);

    About the 8-bit mode: you need to issue the Set Features command with 
opcode 1 to enable that mode -- libata currently doesn't do that, so it won't 
work I suppose...

MBR, Sergei
