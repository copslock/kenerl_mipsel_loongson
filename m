Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2005 01:39:13 +0100 (BST)
Received: from NAT.office.mind.be ([62.166.230.82]:10133 "EHLO
	NAT.office.mind.be") by ftp.linux-mips.org with ESMTP
	id S8133378AbVIWAiu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Sep 2005 01:38:50 +0100
Received: (qmail 3919 invoked from network); 23 Sep 2005 00:38:49 -0000
Received: from localhost (HELO codecarver) ([127.0.0.1])
          (envelope-sender <p2@debian.org>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <linux-mips@linux-mips.org>; 23 Sep 2005 00:38:49 -0000
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1EIbWp-0006DY-00
	for <linux-mips@linux-mips.org>; Fri, 23 Sep 2005 02:35:03 +0200
Date:	Fri, 23 Sep 2005 02:35:03 +0200
To:	linux-mips@linux-mips.org
Subject: patch for  2.6.14-rc1 for pcmcia on swarm
Message-ID: <20050923003502.GC16161@codecarver>
Mail-Followup-To: peter.de.schrijver@mind.be, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.6+20040907i
From:	Peter 'p2' De Schrijver <p2@debian.org>
Return-Path: <p2@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--f5QefDQHtn8hx44O
Content-Type: multipart/mixed; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch implements a hacked pcmcia driver for the Sibyte
swarm board. The driver has only been tested with storage cards (eg. CF
cards). It will probably not work with anything else.
The main problem is that the swarm pcmcia hardware only seems to be capable=
 of=20
generating memory accesses on the pcmcia bus. I don't know if this is a=20
hardware limition of the swarm board or just a lack of documentation. I=20
haven't found any documented way of generating a pcmcia i/o access on the=
=20
swarm board.=20

Cheers,

Peter (p2).

--=20
goa is a state of mind

--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sb1-pcmcia
Content-Transfer-Encoding: quoted-printable

diff -urN -x asm -x scripts -x config linux/drivers/ide/legacy/ide-cs.c lin=
ux-my/drivers/ide/legacy/ide-cs.c
--- linux/drivers/ide/legacy/ide-cs.c	2005-09-15 10:54:18.000000000 +0200
+++ linux-my/drivers/ide/legacy/ide-cs.c	2005-09-22 18:06:17.000000000 +0200
@@ -186,10 +186,19 @@
 static int idecs_register(unsigned long io, unsigned long ctl, unsigned lo=
ng irq)
 {
     hw_regs_t hw;
+
+#ifdef CONFIG_PCMCIA_SIBYTE_SB1xxx_SOC
+	extern int sb_pcmcia_ack_intr(struct hwif_s *hwif);
+#endif
+
     memset(&hw, 0, sizeof(hw));
     ide_init_hwif_ports(&hw, io, ctl, NULL);
     hw.irq =3D irq;
     hw.chipset =3D ide_pci;
+
+#ifdef CONFIG_PCMCIA_SIBYTE_SB1xxx_SOC
+    hw.ack_intr=3Dsb_pcmcia_ack_intr;
+#endif
     return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
=20
diff -urN -x asm -x scripts -x config linux/drivers/pcmcia/Kconfig linux-my=
/drivers/pcmcia/Kconfig
--- linux/drivers/pcmcia/Kconfig	2005-09-15 10:54:58.000000000 +0200
+++ linux-my/drivers/pcmcia/Kconfig	2005-09-22 16:50:27.000000000 +0200
@@ -221,6 +221,10 @@
 	tristate "NEC VRC4173 CARDU support"
 	depends on CPU_VR41XX && PCI && PCMCIA
=20
+config PCMCIA_SIBYTE_SB1xxx_SOC
+        tristate "SiByte SB1xxxx PCMCIA support"
+        depends on PCMCIA && SIBYTE_SB1xxx_SOC
+
 config OMAP_CF
 	tristate "OMAP CompactFlash Controller"
 	depends on PCMCIA && ARCH_OMAP16XX
diff -urN -x asm -x scripts -x config linux/drivers/pcmcia/Makefile linux-m=
y/drivers/pcmcia/Makefile
--- linux/drivers/pcmcia/Makefile	2005-09-17 02:38:10.000000000 +0200
+++ linux-my/drivers/pcmcia/Makefile	2005-09-22 16:50:43.000000000 +0200
@@ -35,6 +35,8 @@
 obj-$(CONFIG_PCMCIA_VRC4171)			+=3D vrc4171_card.o
 obj-$(CONFIG_PCMCIA_VRC4173)			+=3D vrc4173_cardu.o
 obj-$(CONFIG_OMAP_CF)				+=3D omap_cf.o
+obj-$(CONFIG_PCMCIA_SIBYTE_SB1xxx_SOC)          +=3D sibyte_generic.o
+
=20
 sa11xx_core-y					+=3D soc_common.o sa11xx_base.o
 pxa2xx_core-y					+=3D soc_common.o pxa2xx_base.o
diff -urN -x asm -x scripts -x config linux/drivers/pcmcia/pcmcia_resource.=
c linux-my/drivers/pcmcia/pcmcia_resource.c
--- linux/drivers/pcmcia/pcmcia_resource.c	2005-09-15 10:54:58.000000000 +0=
200
+++ linux-my/drivers/pcmcia/pcmcia_resource.c	2005-09-22 17:26:24.000000000=
 +0200
@@ -648,6 +648,7 @@
 		c->Copy =3D req->Copy;
 		pcmcia_write_cis_mem(s, 1, (base + CISREG_SCR)>>1, 1, &c->Copy);
 	}
+#ifdef CONFIG_PCMCIA_SIBYTE_SB1xxx_SOC
 	if (req->Present & PRESENT_OPTION) {
 		if (s->functions =3D=3D 1) {
 			c->Option =3D req->ConfigIndex & COR_CONFIG_MASK;
@@ -663,6 +664,7 @@
 		pcmcia_write_cis_mem(s, 1, (base + CISREG_COR)>>1, 1, &c->Option);
 		mdelay(40);
 	}
+#endif
 	if (req->Present & PRESENT_STATUS) {
 		c->Status =3D req->Status;
 		pcmcia_write_cis_mem(s, 1, (base + CISREG_CCSR)>>1, 1, &c->Status);
diff -urN -x asm -x scripts -x config linux/drivers/pcmcia/sibyte_generic.c=
 linux-my/drivers/pcmcia/sibyte_generic.c
--- linux/drivers/pcmcia/sibyte_generic.c	1970-01-01 01:00:00.000000000 +01=
00
+++ linux-my/drivers/pcmcia/sibyte_generic.c	2005-09-22 16:56:24.000000000 =
+0200
@@ -0,0 +1,558 @@
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/cpufreq.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/notifier.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+
+#include <linux/ide.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/ss.h>
+#include <pcmcia/bulkmem.h>
+#include <pcmcia/cistpl.h>
+#include "cs_internal.h"
+
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+
+#include <asm/sibyte/board.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_scd.h>
+#include <asm/sibyte/sb1250_int.h>
+#include <asm/sibyte/sb1250_genbus.h>
+
+#define IO_MAP_SIZE	0x1000
+
+#define CARDPRESENT(s) (((s) & (M_PCMCIA_STATUS_CD1 | \
+			M_PCMCIA_STATUS_CD2)) =3D=3D 0)
+
+#define POWERON(s)	((s) & (M_PCMCIA_STATUS_3VEN | \
+			M_PCMCIA_STATUS_5VEN))
+
+#define SIBYTE_PCMCIA_POLL_PERIOD (2*HZ)
+
+DECLARE_MUTEX(pcmcia_sockets_lock);
+
+struct sibyte_pcmcia_socket {
+	struct pcmcia_socket socket;
+
+	struct device *dev;
+	int irq;
+
+	int status;
+	socket_state_t cs_state;
+
+	unsigned short	spd_io[MAX_IO_WIN];
+	unsigned short	spd_mem[MAX_WIN];
+
+	struct resource	res_skt;
+	struct resource	res_io;
+	struct resource	res_mem;
+
+	void *virt_io;
+	ioaddr_t phys_io;
+	unsigned int phys_mem;
+	unsigned short	speed_io, speed_attr, speed_mem;
+
+	unsigned int irq_state;
+
+	struct timer_list       poll_timer;
+
+};
+
+struct sibyte_pcmcia_socket sibyte_pcmcia_socket[1];
+#define PCMCIA_SOCKET(x) (sibyte_pcmcia_socket+x);
+
+static unsigned int sibyte_pcmcia_skt_state(struct sibyte_pcmcia_socket *s=
kt)
+{
+	u32 stat;
+	unsigned int status=3D0;
+
+	stat=3Dcsr_in32(IOADDR(A_IO_PCMCIA_STATUS));
+=09
+
+	if(CARDPRESENT(status))=20
+		status=3DSS_DETECT;
+	if(!(stat & M_PCMCIA_STATUS_VS1))
+		status|=3DSS_3VCARD;
+	if(!(stat & M_PCMCIA_STATUS_VS2))
+		status|=3DSS_XVCARD;
+	if(stat & M_PCMCIA_STATUS_WP)
+		status|=3DSS_WRPROT;
+	if(stat & M_PCMCIA_STATUS_RDY)
+		status|=3DSS_READY;
+	if(stat & POWERON(status))
+		status|=3DSS_POWERON;
+	if(stat & (M_PCMCIA_STATUS_CDCHG | M_PCMCIA_STATUS_WPCHG |=20
+		   M_PCMCIA_STATUS_RDYCHG))
+		status|=3DSS_STSCHG;
+
+
+	return status;
+}
+
+static DEFINE_SPINLOCK(status_lock);
+
+static void sibyte_check_status(struct sibyte_pcmcia_socket *skt)
+{
+	unsigned int events;
+
+	do {
+		unsigned int status;
+		unsigned long flags;
+
+		status=3Dsibyte_pcmcia_skt_state(skt);
+
+		spin_lock_irqsave(&status_lock, flags);
+		events =3D (status ^ skt->status) & skt->cs_state.csc_mask;
+		skt->status=3Dstatus;
+		spin_unlock_irqrestore(&status_lock, flags);
+
+		if(events)
+			pcmcia_parse_events(&skt->socket, events);
+	} while(events);
+}
+
+
+static void sibyte_pcmcia_poll_event(unsigned long context)
+{
+	struct sibyte_pcmcia_socket *skt=3D
+		(struct sibyte_pcmcia_socket *)context;
+
+	mod_timer(&skt->poll_timer, jiffies + SIBYTE_PCMCIA_POLL_PERIOD);
+
+	sibyte_check_status(skt);
+}
+
+
+static irqreturn_t sibyte_pcmcia_interrupt(int irq, void *context,=20
+					   struct pt_regs *regs)
+{
+	struct sibyte_pcmcia_socket *skt=3D
+		(struct sibyte_pcmcia_socket *)context;
+
+	sibyte_check_status(skt);
+
+	return IRQ_HANDLED;
+}
+	=09
+/* Note that Vpp is never set. There are normally 2 lines to the pcmcia
+ * power controller to control the Vpp level. The SB1250 PCMCIA control re=
gister
+ * however provides only 1 bit to control Vpp. Any information on the exact
+ * behaviour welcome.
+ */
+static int sibyte_pcmcia_config_skt(struct sibyte_pcmcia_socket *skt,=20
+				    socket_state_t *state)
+{
+	u32 config;
+
+	config=3Dcsr_in32(IOADDR(A_IO_PCMCIA_CFG));
+
+	config &=3D ~(M_PCMCIA_CFG_3VEN | M_PCMCIA_CFG_5VEN);
+
+	switch(state->Vcc) {
+		case 33:
+			config|=3DM_PCMCIA_CFG_3VEN;
+			break;
+		case 50:
+			config|=3DM_PCMCIA_CFG_5VEN;
+			break;
+	}
+
+	if(state->csc_mask & SS_DETECT)
+		config&=3D~M_PCMCIA_CFG_CDMASK;
+	else
+		config|=3DM_PCMCIA_CFG_CDMASK;
+
+	config &=3D ~M_PCMCIA_CFG_RESET;
+	if(state->flags & SS_RESET) {
+		config|=3DM_PCMCIA_CFG_RESET;
+	}
+
+	csr_out32(config,IOADDR(A_IO_PCMCIA_CFG));
+
+	return 0;
+}
+
+static int sibyte_pcmcia_sock_init(struct pcmcia_socket *sock)
+{
+	return 0;
+}
+
+
+static int sibyte_pcmcia_get_status(struct pcmcia_socket *sock,=20
+				    unsigned int *status)
+{
+        struct sibyte_pcmcia_socket *skt=3D
+                (struct sibyte_pcmcia_socket *)sock;
+
+	skt->status=3Dsibyte_pcmcia_skt_state(skt);
+	*status=3Dskt->status;
+
+	return 0;
+}
+
+static int sibyte_pcmcia_get_socket(struct pcmcia_socket *sock,=20
+				    socket_state_t *state)
+{
+        struct sibyte_pcmcia_socket *skt=3D
+                (struct sibyte_pcmcia_socket *)sock;
+
+	*state=3Dskt->cs_state;
+
+	return 0;
+}
+
+static int sibyte_pcmcia_set_socket(struct pcmcia_socket *sock,=20
+				    socket_state_t *state)
+{
+        struct sibyte_pcmcia_socket *skt=3D
+                (struct sibyte_pcmcia_socket *)sock;
+
+	return sibyte_pcmcia_config_skt(skt,state);
+}
+
+static int sibyte_pcmcia_set_io_map(struct pcmcia_socket *sock,=20
+			     	    struct pccard_io_map *io)
+{
+        struct sibyte_pcmcia_socket *skt=3D
+                (struct sibyte_pcmcia_socket *)sock;
+	unsigned int speed;
+	u32 config;
+
+	if (io->map >=3D MAX_IO_WIN) {
+		return -1;
+	}
+
+	if (io->flags & MAP_ACTIVE) {
+		speed=3D(io->speed > 0) ? io->speed : 255;
+		skt->spd_io[io->map]=3Dspeed;
+	}
+
+	config=3Dcsr_in32(IOADDR(A_IO_PCMCIA_CFG));
+        config&=3D~M_PCMCIA_CFG_ATTRMEM;
+        csr_out32(config,IOADDR(A_IO_PCMCIA_CFG));
+
+	io->start=3D(ioaddr_t)(u32)skt->virt_io;
+	io->stop=3Dio->start + IO_MAP_SIZE;
+
+	return 0;
+}
+
+static int sibyte_pcmcia_set_mem_map(struct pcmcia_socket *sock,=20
+				     struct pccard_mem_map *io)
+{
+        struct sibyte_pcmcia_socket *skt=3D
+                (struct sibyte_pcmcia_socket *)sock;
+	u32 config;
+	unsigned int speed=3Dio->speed;
+
+	if(io->map >=3D MAX_WIN) {
+		return -1;
+	}
+
+	config=3Dcsr_in32(IOADDR(A_IO_PCMCIA_CFG));
+	if(io->flags & MAP_ATTRIB) {
+		config|=3DM_PCMCIA_CFG_ATTRMEM;
+	}
+	else {
+		config&=3D~M_PCMCIA_CFG_ATTRMEM;
+	}
+	csr_out32(config,IOADDR(A_IO_PCMCIA_CFG));
+
+	skt->spd_mem[io->map]=3Dspeed;
+
+	io->static_start=3Dskt->phys_mem;
+
+	return 0;
+}
+
+/* the following functions are a gross layer violation. the pcmcia layer h=
ooks=20
+ * into the IDE layer to fiddle around with the config register.
+ */
+
+int sb_pcmcia_ack_intr(struct hwif_s *hwif)
+{
+
+	csr_out32(1 << K_GPIO_PC_READY, IOADDR(A_GPIO_CLR_EDGE));
+
+	return 1;
+}
+
+static void sibyte_pcmcia_selectproc(ide_drive_t *drive)
+{
+        u32 config;
+
+	config=3Dcsr_in32(IOADDR(A_IO_PCMCIA_CFG));
+	config&=3D~M_PCMCIA_CFG_ATTRMEM;
+	csr_out32(config,IOADDR(A_IO_PCMCIA_CFG));
+
+}
+
+static int sibyte_pc_prep_ide(void *iobase)
+{
+	int i;
+	ide_hwif_t *hwif =3D NULL;
+
+	/* Stake early claim on an ide_hwif */
+	for (i =3D 0; i < MAX_HWIFS; i++) {
+		if (!ide_hwifs[i].io_ports[IDE_DATA_OFFSET]) {
+			hwif =3D &ide_hwifs[i];=20
+			break;
+		}
+	}
+	if (hwif =3D=3D NULL) {
+		 printk("No space for SiByte onboard PCMCIA driver in ide_hwifs[].  Not =
enabled.\n");
+		 return 1;
+	}
+
+	/*
+	 * Prime the hwif with port values, so when a card is
+	 * detected, the 'io_offset' from the capabilities will lead
+	 * it here
+	 */
+	hwif->hw.io_ports[IDE_DATA_OFFSET]    =3D iobase + (0);
+	hwif->hw.io_ports[IDE_ERROR_OFFSET]   =3D iobase + (1);
+	hwif->hw.io_ports[IDE_NSECTOR_OFFSET] =3D iobase + (2);
+	hwif->hw.io_ports[IDE_SECTOR_OFFSET]  =3D iobase + (3);
+	hwif->hw.io_ports[IDE_LCYL_OFFSET]    =3D iobase + (4);
+	hwif->hw.io_ports[IDE_HCYL_OFFSET]    =3D iobase + (5);
+	hwif->hw.io_ports[IDE_SELECT_OFFSET]  =3D iobase + (6);
+	hwif->hw.io_ports[IDE_STATUS_OFFSET]  =3D iobase + (7);
+	hwif->hw.io_ports[IDE_CONTROL_OFFSET] =3D iobase + (6); /* XXXKW ? */
+	hwif->hw.ack_intr                     =3D sb_pcmcia_ack_intr;
+	hwif->selectproc                      =3D sibyte_pcmcia_selectproc;
+	hwif->hold                            =3D 1;
+	hwif->mmio                            =3D 2;
+
+	printk("SiByte onboard PCMCIA-IDE configured as device %i\n", i);
+
+	return 0;
+}
+
+/* end of hack */
+static struct pccard_operations sibyte_pcmcia_operations =3D {
+        .init                   =3D sibyte_pcmcia_sock_init,
+	.get_status             =3D sibyte_pcmcia_get_status,
+	.get_socket             =3D sibyte_pcmcia_get_socket,
+	.set_socket             =3D sibyte_pcmcia_set_socket,
+	.set_io_map             =3D sibyte_pcmcia_set_io_map,
+	.set_mem_map            =3D sibyte_pcmcia_set_mem_map,
+};
+
+static int sibyte_pcmcia_sock_hw_init(struct sibyte_pcmcia_socket *skt)
+{
+
+	u32 status, config;
+	u32 gpio_ctrl;
+
+	status=3Dcsr_in32(IOADDR(A_IO_PCMCIA_STATUS));
+
+	config =3D M_PCMCIA_CFG_CDMASK | M_PCMCIA_CFG_WPMASK |=20
+		 M_PCMCIA_CFG_RDYMASK;
+
+	csr_out32(config,IOADDR(A_IO_PCMCIA_CFG));
+
+	gpio_ctrl=3Dcsr_in32(IOADDR(A_GPIO_INT_TYPE));
+	gpio_ctrl&=3D~M_GPIO_INTR_TYPEX(K_GPIO_PC_READY);
+	gpio_ctrl|=3DV_GPIO_INTR_TYPEX(K_GPIO_PC_READY,=20
+				     K_GPIO_INTR_EDGE);
+
+	csr_out32(gpio_ctrl, IOADDR(A_GPIO_INT_TYPE));
+	csr_out32(1 << K_GPIO_PC_READY, IOADDR(A_GPIO_CLR_EDGE));
+
+	gpio_ctrl=3Dcsr_in32(IOADDR(A_GPIO_INPUT_INVERT));
+	gpio_ctrl|=3D1 << K_GPIO_PC_READY;
+	csr_out32(gpio_ctrl, IOADDR(A_GPIO_INPUT_INVERT));
+
+	if (request_irq(K_INT_PCMCIA, sibyte_pcmcia_interrupt, 0,=20
+			"pcmcia", skt))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int sibyte_pcmcia_socket_probe(struct device *dev, u32 base, u32 si=
ze)
+{
+	int ret;
+	struct sibyte_pcmcia_socket *skt=3DPCMCIA_SOCKET(0);
+
+	skt->socket.ops=3D&sibyte_pcmcia_operations;
+	skt->socket.resource_ops=3D&pccard_static_ops;
+	skt->socket.owner=3DTHIS_MODULE;
+	skt->socket.dev.dev=3Ddev;
+
+	skt->irq=3DK_INT_PC_READY;
+	skt->dev=3Ddev;
+
+	init_timer(&skt->poll_timer);
+	skt->poll_timer.function=3Dsibyte_pcmcia_poll_event;
+	skt->poll_timer.data=3D(unsigned long)skt;
+	skt->poll_timer.expires=3Djiffies+SIBYTE_PCMCIA_POLL_PERIOD;
+
+	skt->res_skt.start=3Dbase;
+	skt->res_skt.end=3Dbase+size;
+	skt->res_skt.name=3D"PCMCIA socket 0";
+	skt->res_skt.flags=3DIORESOURCE_MEM;
+	ret=3Drequest_resource(&iomem_resource, &skt->res_skt);
+	if(ret)
+		goto out_err_1;
+
+	skt->res_io.name=3D"io";
+	skt->res_io.flags=3DIORESOURCE_MEM | IORESOURCE_BUSY;
+	skt->res_io.start=3Dbase;
+	skt->res_io.end=3Dbase+IO_MAP_SIZE-1;
+	ret=3Drequest_resource(&skt->res_skt, &skt->res_io);
+	if(ret)
+		goto out_err_2;
+=09
+	skt->res_mem.name=3D"memory";
+	skt->res_mem.flags=3DIORESOURCE_MEM;
+	skt->res_mem.start=3Dbase+IO_MAP_SIZE;
+	skt->res_mem.end=3Dbase+size;
+	ret=3Drequest_resource(&skt->res_skt, &skt->res_mem);
+	if(ret)
+		goto out_err_3;
+=09
+	skt->virt_io=3D(void *)(ioremap((phys_t)base, IO_MAP_SIZE) -
+				(u32)mips_io_port_base);
+	skt->phys_mem=3Dbase;
+
+	skt->socket.features=3DSS_CAP_STATIC_MAP|SS_CAP_PCCARD|SS_CAP_PAGE_REGS|
+			     SS_CAP_MEM_ALIGN;
+	skt->socket.irq_mask=3D0;
+	skt->socket.map_size=3Dsize;
+	skt->socket.pci_irq=3Dskt->irq;
+	skt->socket.io_offset=3D(unsigned long)skt->virt_io;
+
+	skt->status=3Dsibyte_pcmcia_skt_state(skt);
+
+	ret=3Dpcmcia_register_socket(&skt->socket);
+	if(ret)
+		goto out_err_4;
+=09
+	ret=3Dsibyte_pcmcia_sock_hw_init(skt);
+	if(ret)
+		goto out_err;
+
+	WARN_ON(skt->socket.sock !=3D 0);
+
+	sibyte_pc_prep_ide(skt->virt_io);
+
+	dev_set_drvdata(dev, skt);
+
+	add_timer(&skt->poll_timer);
+
+	return 0;
+
+out_err:
+	pcmcia_unregister_socket(&skt->socket);
+out_err_4:
+	release_resource(&skt->res_mem);
+out_err_3:
+	release_resource(&skt->res_io);
+out_err_2:
+	release_resource(&skt->res_skt);
+out_err_1:
+	del_timer_sync(&skt->poll_timer);
+	flush_scheduled_work();
+
+	return ret;
+}
+
+
+
+static int sibyte_pcmcia_probe(struct device *dev)
+{
+	u64 cfg;
+	u32 pcmcia_size,pcmcia_base,addr;
+	int ret;
+
+	down(&pcmcia_sockets_lock);
+	cfg=3D__raw_readq(IOADDR(A_SCD_SYSTEM_CFG));
+	if(!(cfg & M_SYS_PCMCIA_ENABLE)) {
+		printk(KERN_INFO "chip not configured for PCMCIA\n");
+		return -ENODEV;
+	}
+
+	addr=3DA_IO_EXT_REG(R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, PCMCIA_CS));
+	pcmcia_size=3D(G_IO_MULT_SIZE(csr_in32(IOADDR(addr))) + 1)<<S_IO_REGSIZE;
+
+	addr=3DA_IO_EXT_REG(R_IO_EXT_REG(R_IO_EXT_START_ADDR, PCMCIA_CS));
+	pcmcia_base=3DG_IO_START_ADDR(csr_in32(IOADDR(addr))) << S_IO_ADDRBASE;=
=09
+
+	ret=3Dsibyte_pcmcia_socket_probe(dev, pcmcia_base, pcmcia_size);
+
+	up(&pcmcia_sockets_lock);
+
+	return ret;
+}
+
+int sibyte_pcmcia_remove(struct device *dev)
+{
+	struct sibyte_pcmcia_socket *skt=3D(struct sibyte_pcmcia_socket *)
+					  dev_get_drvdata(dev);
+        down(&pcmcia_sockets_lock);
+
+	dev_set_drvdata(dev, NULL);
+	del_timer_sync(&skt->poll_timer);
+	pcmcia_unregister_socket(&skt->socket);
+	flush_scheduled_work();
+	sibyte_pcmcia_config_skt(skt,&dead_socket);
+	iounmap(skt->virt_io);
+	skt->virt_io =3D NULL;
+
+	up(&pcmcia_sockets_lock);
+	return 0;
+}
+
+
+static struct device_driver sibyte_pcmcia_driver =3D {
+	.probe 		=3D sibyte_pcmcia_probe,
+	.remove 	=3D sibyte_pcmcia_remove,
+	.name		=3D "sb1xxx-pcmcia",
+	.bus		=3D &platform_bus_type,
+};
+
+static struct platform_device sibyte_pcmcia_device =3D {
+	.name =3D "sb1xxx-pcmcia",
+	.id =3D 0,
+};
+
+static int __init sibyte_pcmcia_init(void)
+{
+	int err;
+
+	err=3Ddriver_register(&sibyte_pcmcia_driver);
+	if(err)
+		return err;
+
+	platform_device_register(&sibyte_pcmcia_device);
+
+	return 0;
+}
+
+static void __exit sibyte_pcmcia_exit(void)
+{
+	driver_unregister(&sibyte_pcmcia_driver);
+	platform_device_unregister(&sibyte_pcmcia_device);
+}
+
+
+EXPORT_SYMBOL(sb_pcmcia_ack_intr);
+
+module_init(sibyte_pcmcia_init);
+module_exit(sibyte_pcmcia_exit);
+
diff -urN -x asm -x scripts -x config linux/include/asm-mips/ide.h linux-my=
/include/asm-mips/ide.h
--- linux/include/asm-mips/ide.h	2004-11-24 19:35:14.000000000 +0100
+++ linux-my/include/asm-mips/ide.h	2005-09-22 17:47:08.000000000 +0200
@@ -10,4 +10,9 @@
=20
 #include <ide.h>
=20
+#ifdef CONFIG_PCMCIA_SIBYTE_SB1xxx_SOC
+#define IDE_ARCH_ACK_INTR
+#define ide_ack_intr(hwif)      ((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr=
(hwif) : 1)
+#endif
+
 #endif /* __ASM_IDE_H */

--fwqqG+mf3f7vyBCB--

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDM022KLKVw/RurbsRAvIPAJ9ROgR/R/5/nh6uUw+t7aCrUlDugwCdGBeg
/av2T3PeAjA2ezunZ9nBWE4=
=SIfv
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
