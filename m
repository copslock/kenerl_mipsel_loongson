Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 12:53:26 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:64827 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021464AbZDILxS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 12:53:18 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EB98D3EC9; Thu,  9 Apr 2009 04:53:13 -0700 (PDT)
Message-ID: <49DDE1D4.9080601@ru.mvista.com>
Date:	Thu, 09 Apr 2009 15:53:56 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	yanhua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 13/14] lemote: fixup for FUJITSU disk
References: <49DD83CA.9000704@lemote.com>
In-Reply-To: <49DD83CA.9000704@lemote.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

yanhua wrote:

   The patch description wouldn't hurt, i.e. why this fixup is needed...

> diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
> index 77267c8..51b888f 100644
> --- a/drivers/ide/amd74xx.c
> +++ b/drivers/ide/amd74xx.c

   The IDE patches should be posted to linux-ide mail list.

> @@ -23,6 +23,11 @@
> 
> #define DRV_NAME "amd74xx"
> 
> +static const char *am74xx_quirk_drives[] = {
> + "FUJITSU MHZ2160BH G2",
> + NULL
> +};
> +
> enum {
> AMD_IDE_CONFIG = 0x41,
> AMD_CABLE_DETECT = 0x42,
> @@ -112,6 +117,20 @@ static void amd_set_pio_mode(ide_drive_t *drive,
> const u8 pio)
> amd_set_drive(drive, XFER_PIO_0 + pio);

   Your patches are seriously whitespace-damaged, i.e. all tabs seem to be
collapsed to a single space. You'll have to find a way to avoid that...

> }
> 
> +static void amd_quirkproc(ide_drive_t *drive, const u8 pio)

   Have you tried to compile this? The quirkproc() method only has one parameter.

> +{
> + const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> +
> + for (list = am74xx_quirk_drives; *list != NULL; list++)
> + if (strstr(m, *list) != NULL) {
> + drive->quirk_list = 2;
> + return;
> + }
> +
> + drive->quirk_list = 0;
> +
> +}
> +
> static void amd7409_cable_detect(struct pci_dev *dev)
> {
> /* no host side cable detection */
> @@ -194,6 +213,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t
> *hwif)
> static const struct ide_port_ops amd_port_ops = {
> .set_pio_mode = amd_set_pio_mode,
> .set_dma_mode = amd_set_drive,
> + .quirkproc = amd_quirkproc,
> .cable_detect = amd_cable_detect,
> };
> 

MBR, Sergei
