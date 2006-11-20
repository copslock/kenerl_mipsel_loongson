Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 12:37:51 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:32397 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20038492AbWKTMhr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2006 12:37:47 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 76F485DF94;
	Mon, 20 Nov 2006 13:37:41 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wjRuNv4U2gX6; Mon, 20 Nov 2006 13:37:41 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 041045DF3D; Mon, 20 Nov 2006 13:37:41 +0100 (CET)
Date:	Mon, 20 Nov 2006 13:37:40 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1xmmc.c: does it work?
Message-ID: <20061120123740.GE32045@dusktilldawn.nl>
References: <20061120094053.GA13509@roarinelk.homelinux.net> <20061120104922.GC32045@dusktilldawn.nl> <20061120120148.GA13740@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20061120120148.GA13740@roarinelk.homelinux.net>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--GV0iVqYguTV4Q9ER
Content-Type: multipart/mixed; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Mon, Nov 20, 2006 at 01:01:48PM +0100, Manuel Lauss wrote:
> On Mon, Nov 20, 2006 at 11:49:22AM +0100, Freddy Spierenburg wrote:
> > Are you working with a real MMC card or with an SD-card?
>=20
> SD cards so far. MMC seems broken in a different way.

Broke in a different way? I can positively confirm that I have a
512MB and 1GB MMC-card working with the patch I hereby send to
you.

I've also tried a DaneElec 1GB and Kingston 1GB SD-card and
SanDisk 128MB MicroSD-card. All failed.


> Yes, please. I'd like to give it a spin

Please find it attached.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmc.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7bddcc4..328039d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -22,7 +22,7 @@ #
 # Select the object file format to substitute into the linker script.
 #
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-32bit-tool-prefix	=3D mipsel-linux-
+32bit-tool-prefix	=3D mipsel-linux-gnu-
 64bit-tool-prefix	=3D mips64el-linux-
 32bit-bfd		=3D elf32-tradlittlemips
 64bit-bfd		=3D elf64-tradlittlemips
diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clo=
cks.c
index 3ce6cac..b1f5524 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
@@ -46,6 +46,7 @@ unsigned int get_au1x00_speed(void)
 {
 	return au1x00_clock;
 }
+EXPORT_SYMBOL(get_au1x00_speed);
=20
=20
=20
diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/p=
latform.c
index 48d3f54..65376ef 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -72,6 +72,38 @@ static struct platform_device au1100_lcd
 	.num_resources  =3D ARRAY_SIZE(au1100_lcd_resources),
 	.resource       =3D au1100_lcd_resources,
 };
+
+static struct resource au1xxx_mmc_resources[] =3D {
+	[0] =3D {
+		.start          =3D SD0_PHYS_ADDR,
+		.end            =3D SD0_PHYS_ADDR + 0x40,
+		.flags          =3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.start		=3D SD1_PHYS_ADDR,
+		.end 		=3D SD1_PHYS_ADDR + 0x40,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	[2] =3D {
+		.start          =3D AU1100_SD_INT,
+		.end            =3D AU1100_SD_INT,
+		.flags          =3D IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1xxx_mmc_dmamask =3D  ~(u32)0;
+
+static struct platform_device au1xxx_mmc_device =3D {
+	.name =3D "au1xxx-mmc",
+	.id =3D 0,
+	.dev =3D {
+		.dma_mask               =3D &au1xxx_mmc_dmamask,
+		.coherent_dma_mask      =3D 0xffffffff,
+	},
+	.num_resources  =3D ARRAY_SIZE(au1xxx_mmc_resources),
+	.resource       =3D au1xxx_mmc_resources,
+};
+
 #endif
=20
 #ifdef CONFIG_SOC_AU1200
@@ -276,6 +308,7 @@ static struct platform_device *au1xxx_pl
 	&au1x00_pcmcia_device,
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
+	&au1xxx_mmc_device,
 #endif
 #ifdef CONFIG_SOC_AU1200
 #if 0	/* fixme */
diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 8d84b04..be21e7c 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -47,6 +47,7 @@ #include <linux/mmc/protocol.h>
 #include <asm/io.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1xxx_gpio.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/scatterlist.h>
=20
@@ -55,8 +56,13 @@ #include "au1xmmc.h"
=20
 #define DRIVER_NAME "au1xxx-mmc"
=20
+/* Set this for Dare processor board adjustments */
+//#define MMC_DARE_PROCESSOR_BOARD
+/* DMA isn't implemented yet: */
+//#define MMC_DARE_DMA_IMPLEMENTED
+
 /* Set this to enable special debugging macros */
-/* #define MMC_DEBUG */
+#define MMC_DEBUG
=20
 #ifdef MMC_DEBUG
 #define DEBUG(fmt, idx, args...) printk("au1xx(%d): DEBUG: " fmt, idx, ##a=
rgs)
@@ -66,17 +72,9 @@ #endif
=20
 const struct {
 	u32 iobase;
-	u32 tx_devid, rx_devid;
-	u16 bcsrpwr;
-	u16 bcsrstatus;
 	u16 wpstatus;
 } au1xmmc_card_table[] =3D {
-	{ SD0_BASE, DSCR_CMD0_SDMS_TX0, DSCR_CMD0_SDMS_RX0,
-	  BCSR_BOARD_SD0PWR, BCSR_INT_SD0INSERT, BCSR_STATUS_SD0WP },
-#ifndef CONFIG_MIPS_DB1200
-	{ SD1_BASE, DSCR_CMD0_SDMS_TX1, DSCR_CMD0_SDMS_RX1,
-	  BCSR_BOARD_DS1PWR, BCSR_INT_SD1INSERT, BCSR_STATUS_SD1WP }
-#endif
+	{ SD0_BASE, BCSR_BOARD_SD0_WP },
 };
=20
 #define AU1XMMC_CONTROLLER_COUNT \
@@ -84,7 +82,11 @@ #define AU1XMMC_CONTROLLER_COUNT \
=20
 /* This array stores pointers for the hosts (used by the IRQ handler) */
 struct au1xmmc_host *au1xmmc_hosts[AU1XMMC_CONTROLLER_COUNT];
+#ifdef MMC_DARE_DMA_IMPLEMENTED
 static int dma =3D 1;
+#else
+static int dma =3D 0; /* DMA isn't implemented yet in this driver */
+#endif
=20
 #ifdef MODULE
 MODULE_PARM(dma, "i");
@@ -139,25 +141,33 @@ static inline void SEND_STOP(struct au1x
=20
 static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
 {
-
-	u32 val =3D au1xmmc_card_table[host->id].bcsrpwr;
-
-	bcsr->board &=3D ~val;
-	if (state) bcsr->board |=3D val;
-
-	au_sync_delay(1);
+#ifdef MMC_DARE_PROCESSOR_BOARD
+	state =3D 1; /* Force gpio high for card detection */
+	au1xxx_gpio_write(19, state ? 1 : 0);
+#else /* db1100 board */
+	mmc_power(host->id, state);
+#endif
 }
=20
 static inline int au1xmmc_card_inserted(struct au1xmmc_host *host)
 {
-	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
-		? 1 : 0;
+	int res =3D 0;
+	/* Note: card inserted checks at read-only switch,
+	 * if a card is set to read-only, it won't be recognized */
+#ifdef MMC_DARE_PROCESSOR_BOARD
+	/* Note: removing power (gpio19 low), makes it look like
+	 * the card has been removed */
+	res =3D au1xxx_gpio_read(19);
+#else /* db1100 board */
+	mmc_card_inserted(host->id, &res);
+#endif
+	return res;
 }
=20
 static inline int au1xmmc_card_readonly(struct au1xmmc_host *host)
 {
-	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus)
-		? 1 : 0;
+	/* Not implemented */
+	return 0;
 }
=20
 static void au1xmmc_finish_request(struct au1xmmc_host *host)
@@ -177,8 +187,6 @@ static void au1xmmc_finish_request(struc
=20
 	host->status =3D HOST_S_IDLE;
=20
-	bcsr->disk_leds |=3D (1 << 8);
-
 	mmc_request_done(host->mmc, mrq);
 }
=20
@@ -531,6 +539,7 @@ static void au1xmmc_cmd_complete(struct=20
=20
 	host->status =3D HOST_S_DATA;
=20
+	#ifdef MMC_DARE_DMA_IMPLEMENTED
 	if (host->flags & HOST_F_DMA) {
 		u32 channel =3D DMA_CHANNEL(host);
=20
@@ -545,6 +554,7 @@ static void au1xmmc_cmd_complete(struct=20
=20
 		au1xxx_dbdma_start(channel);
 	}
+	#endif
 }
=20
 static void au1xmmc_set_clock(struct au1xmmc_host *host, int rate)
@@ -599,6 +609,7 @@ au1xmmc_prepare_data(struct au1xmmc_host
=20
 	au_writel((1 << data->blksz_bits) - 1, HOST_BLKSIZE(host));
=20
+	#ifdef MMC_DARE_DMA_IMPLEMENTED
 	if (host->flags & HOST_F_DMA) {
 		int i;
 		u32 channel =3D DMA_CHANNEL(host);
@@ -616,12 +627,14 @@ au1xmmc_prepare_data(struct au1xmmc_host
 				flags =3D DDMA_FLAGS_IE;
=20
     			if (host->flags & HOST_F_XMIT){
+				ret =3D 0;
       				ret =3D au1xxx_dbdma_put_source_flags(channel,
 					(void *) (page_address(sg->page) +
 						  sg->offset),
 					len, flags);
 			}
     			else {
+				ret =3D 0;
       				ret =3D au1xxx_dbdma_put_dest_flags(channel,
 					(void *) (page_address(sg->page) +
 						  sg->offset),
@@ -634,7 +647,9 @@ au1xmmc_prepare_data(struct au1xmmc_host
 			datalen -=3D len;
 		}
 	}
-	else {
+	else
+	#endif
+	{
 		host->pio.index =3D 0;
 		host->pio.offset =3D 0;
 		host->pio.len =3D datalen;
@@ -648,9 +663,11 @@ au1xmmc_prepare_data(struct au1xmmc_host
=20
 	return MMC_ERR_NONE;
=20
+#ifdef MMC_DARE_DMA_IMPLEMENTED
  dataerr:
 	dma_unmap_sg(mmc_dev(host->mmc),data->sg,data->sg_len,host->dma.dir);
 	return MMC_ERR_TIMEOUT;
+#endif
 }
=20
 /* static void au1xmmc_request
@@ -669,8 +686,6 @@ static void au1xmmc_request(struct mmc_h
 	host->mrq =3D mrq;
 	host->status =3D HOST_S_CMD;
=20
-	bcsr->disk_leds &=3D ~(1 << 8);
-
 	if (mrq->data) {
 		FLUSH_FIFO(host);
 		ret =3D au1xmmc_prepare_data(host, mrq->data);
@@ -737,6 +752,7 @@ static void au1xmmc_set_ios(struct mmc_h
 	}
 }
=20
+#ifdef MMC_DARE_DMA_IMPLEMENTED
 static void au1xmmc_dma_callback(int irq, void *dev_id, struct pt_regs *re=
gs)
 {
 	struct au1xmmc_host *host =3D (struct au1xmmc_host *) dev_id;
@@ -751,6 +767,7 @@ static void au1xmmc_dma_callback(int irq
=20
 	tasklet_schedule(&host->data_task);
 }
+#endif
=20
 #define STATUS_TIMEOUT (SD_STATUS_RAT | SD_STATUS_DT)
 #define STATUS_DATA_IN  (SD_STATUS_NE)
@@ -845,14 +862,16 @@ static void au1xmmc_poll_event(unsigned=20
 	mod_timer(&host->timer, jiffies + AU1XMMC_DETECT_TIMEOUT);
 }
=20
+#ifdef MMC_DARE_DMA_IMPLEMENTED
 static dbdev_tab_t au1xmmc_mem_dbdev =3D
 {
 	DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 8, 0x00000000, 0, 0
 };
+#endif
=20
 static void au1xmmc_init_dma(struct au1xmmc_host *host)
 {
-
+#ifdef MMC_DARE_DMA_IMPLEMENTED
 	u32 rxchan, txchan;
=20
 	int txid =3D au1xmmc_card_table[host->id].tx_devid;
@@ -879,6 +898,7 @@ static void au1xmmc_init_dma(struct au1x
=20
 	host->tx_chan =3D txchan;
 	host->rx_chan =3D rxchan;
+#endif
 }
=20
 struct mmc_host_ops au1xmmc_ops =3D {
@@ -985,8 +1005,10 @@ static int __devexit au1xmmc_remove(stru
=20
 		mmc_remove_host(host->mmc);
=20
+		#ifdef MMC_DARE_DMA_IMPLEMENTED
 		au1xxx_dbdma_chan_free(host->tx_chan);
 		au1xxx_dbdma_chan_free(host->rx_chan);
+		#endif
=20
 		au_writel(0x0, HOST_ENABLE(host));
 		au_sync();
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
diff --git a/include/asm-mips/mach-au1x00/au1xxx.h b/include/asm-mips/mach-=
au1x00/au1xxx.h
diff --git a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-=
db1x00/db1x00.h
index 7b28b23..5912361 100644
--- a/include/asm-mips/mach-db1x00/db1x00.h
+++ b/include/asm-mips/mach-db1x00/db1x00.h
@@ -177,6 +177,24 @@ #define mmc_power_on(_n_) \
 		} \
 	} while (0)
=20
+/*
+ * Remove power from card slot(s).
+ */
+#define mmc_power(_n_, state) \
+	do { \
+		BCSR * const bcsr =3D (BCSR *)0xAE000000; \
+		unsigned long mmc_pwr, board_specific; \
+		if ((_n_)) { \
+			mmc_pwr =3D BCSR_BOARD_SD1_PWR; \
+		} else { \
+			mmc_pwr =3D BCSR_BOARD_SD0_PWR; \
+		} \
+		board_specific =3D au_readl((unsigned long)(&bcsr->specific)); \
+		board_specific &=3D ~mmc_pwr; \
+		board_specific |=3D (state ? mmc_pwr : 0); \
+		au_writel(board_specific, (int)(&bcsr->specific)); \
+		au_sync(); \
+	} while (0)
=20
 /* NAND defines */
 /* Timing values as described in databook, * ns value stripped of
diff --git a/include/asm-mips/mach-pb1x00/pb1100.h b/include/asm-mips/mach-=
pb1x00/pb1100.h

--idY8LE8SD6/8DnRI--

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFYaGUbxf9XXlB0eERAkKTAKCzIzAEuqJD33vurntcFsua7t4UewCeOvGn
E1qxC8zg5wjKHTejlUhlKDk=
=K4U1
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
