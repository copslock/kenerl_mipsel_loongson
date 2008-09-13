Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2008 22:48:19 +0100 (BST)
Received: from homer.mvista.com ([63.81.120.155]:14929 "EHLO
	imap.sh.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28784647AbYIMVsQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 13 Sep 2008 22:48:16 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5AAA33EFF; Sat, 13 Sep 2008 14:48:11 -0700 (PDT)
Message-ID: <48CC3516.9080404@ru.mvista.com>
Date:	Sun, 14 Sep 2008 01:48:06 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
>
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..ba9776d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,762 @@
>   
[...]
> +static void tx4939ide_hwif_init(ide_hwif_t *hwif)
> +{
>   
[...]
> +
> +#ifdef __BIG_ENDIAN
> +	/* This setting does not affect PRD fetch */
> +	/* ByteSwap=1, Endian=00 */
> +	TX4939IDE_writew(0xc911, base, Add_Ctl);
> +#else
> +	TX4939IDE_writew(0xc901, base, Add_Ctl);
> +#endif
>   

   Aren't these the default register values? Is there a sense in writing 
them?

> +#ifdef __BIG_ENDIAN
> +/* custom iops (independent from SWAP_IO_SPACE) */
> +static u8 mm_inb(unsigned long port)
> +{
> +	return (u8)readb((void __iomem *)port);
> +}
> +static void mm_outb(u8 value, unsigned long port)
> +{
> +	writeb(value, (void __iomem *)port);
> +}
> +static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
> +
> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
> +		HIHI = 0xFF;
> +
> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
> +		u16 data = (tf->hob_data << 8) | tf->data;
> +
> +		__raw_writew(data, (void __iomem *)io_ports->data_addr);
>   

   This doesn't look consistent (aside from the TX4939IDE_REG8/16 issue) 
-- mm_outsw_swap() calls cpu_to_le16() before writing 16-bit data but 
this code doesn't. So, either one of those should be wrong...

> +static void mm_tf_read(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +
> +	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
> +		u16 data;
> +
> +		data = __raw_readw((void __iomem *)io_ports->data_addr);
> +		tf->data = data & 0xff;
> +		tf->hob_data = (data >> 8) & 0xff;
>   

    Same here...

> +static void mm_insw_swap(unsigned long port, void *addr, u32 count)
> +{
> +	unsigned short *ptr = addr;
> +	unsigned long size = count * 2;
> +	port &= ~1;
> +	while (count--)
> +		*ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
> +	__ide_flush_dcache_range((unsigned long)addr, size);
> +}
> +static void mm_outsw_swap(unsigned long port, void *addr, u32 count)
> +{
> +	unsigned short *ptr = addr;
> +	unsigned long size = count * 2;
> +	port &= ~1;
> +	while (count--) {
> +		__raw_writew(cpu_to_le16(*ptr), (void __iomem *)port);
> +		ptr++;
> +	}
> +	__ide_flush_dcache_range((unsigned long)addr, size);
> +}
>   

    Hum... but is it really correct to convert from/to LE order above? 
I'm prett sure that data is expected in LE order -- look ar 
ide_fix_driveid() for example...

MBR, Sergei
