Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 11:45:19 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:4392 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20035959AbYGMKpR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 11:45:17 +0100
Received: by mo.po.2iij.net (mo32) id m6DAj6pO001256; Sun, 13 Jul 2008 19:45:06 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox301) id m6DAj2lS016081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 Jul 2008 19:45:02 +0900
Date:	Sun, 13 Jul 2008 19:45:03 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] mips_machtype define as one group
Message-Id: <20080713194503.23e4e1a1.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080712143225.GA9053@alpha.franken.de>
References: <20080711225717.cbf55ccc.yoichi_yuasa@tripeaks.co.jp>
	<20080711143235.GA9016@alpha.franken.de>
	<20080712174741.c4dd3149.yoichi_yuasa@tripeaks.co.jp>
	<20080712143225.GA9053@alpha.franken.de>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Sat, 12 Jul 2008 16:32:25 +0200
tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:

> On Sat, Jul 12, 2008 at 05:47:41PM +0900, Yoichi Yuasa wrote:
> > On Fri, 11 Jul 2008 16:32:35 +0200
> > tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:
> > 
> > > On Fri, Jul 11, 2008 at 10:57:17PM +0900, Yoichi Yuasa wrote:
> > > > mips_machtype define as one group.
> > > 
> > > wouldn't it make more sense to kill that completly ?
> > 
> > mips_machtype is still used in some places.
> > Should we check first whether it can be removed?
> 
> I don't know Ralf's opinion about the removal, but if he agrees, we
> should just look for the remaining usage cases and see, if it could
> be resolved in a differnt way.
> 
> Here is my first look at all the various MACH_XXX:
> 
> > #define  MACH_ACER_PICA_61      0     /* Acer PICA-61 (PICA1) */
> > #define  MACH_MIPS_MAGNUM_4000  1     /* Mips Magnum 4000 "RC4030" */
> > #define  MACH_OLIVETTI_M700     2     /* Olivetti M700-10 (-15 ??) */
> 
> all three are in arch/mips/fw/arc/identify.c, but only MACH_MIPS_MAGNUM_4000
> is used in arch/mips/jazz/setup.c. But the usage in arch/mips/jazz/setup.c
> is not quite correct and I'd like to remove it there.
> 
> > #define  MACH_DSUNKNOWN         0
> > #define  MACH_DS23100           1     /* DECstation 2100 or 3100 */
> > #define  MACH_DS5100            2     /* DECsystem 5100 */
> > #define  MACH_DS5000_200        3     /* DECstation 5000/200 */
> > #define  MACH_DS5000_1XX        4     /* DECstation 5000/120, 125, 133, 150*/
> > #define  MACH_DS5000_XX         5     /* DECstation 5000/20, 25, 33, 50 */
> > #define  MACH_DS5000_2X0        6     /* DECstation 5000/240, 260 */
> > #define  MACH_DS5400            7     /* DECsystem 5400 */
> > #define  MACH_DS5500            8     /* DECsystem 5500 */
> > #define  MACH_DS5800            9     /* DECsystem 5800 */
> > #define  MACH_DS5900            10    /* DECsystem 5900 */
> 
> that's the only poweruser. I'd rename mips_machtype to dec_machtype and
> just use it for decstation as it is today.
> 
> > #define  MACH_SNI_RM200_PCI     0     /* RM200/RM300/RM400 PCI series */
> 
> only in arch/mips/fw/arc/identify
> 
> > #define  MACH_SGI_IP22          0     /* Indy, Indigo2, Challenge S */
> > #define  MACH_SGI_IP27          1     /* Origin 200, Origin 2000, Onyx 2 */
> > #define  MACH_SGI_IP28          2     /* Indigo2 Impact */
> > #define  MACH_SGI_IP32          3     /* O2 */
> > #define  MACH_SGI_IP30          4     /* Octane, Octane2 */
> 
> all SGI defines are only in arch/mips/fw/arc/identify
> 
> > #define  MACH_PALLAS            0
> > #define  MACH_TOPAS             1
> > #define  MACH_JMR               2
> > #define  MACH_TOSHIBA_JMR3927   3     /* JMR-TX3927 CPU/IO board */
> 
> these 4 are unused
> 
> > #define  MACH_TOSHIBA_RBTX4927  4
> > #define  MACH_TOSHIBA_RBTX4937  5
> > #define  MACH_TOSHIBA_RBTX4938  6
> 
> there is only one usage for that, so moving the code for setting of
> mips_machtype from toshiba_rbtx4927_prom.c to toshiba_rbtx4927_setup.c
> will make that defines obsolete.
> 
> > #define  MACH_LASAT_100         0     /* Masquerade II/SP100/SP50/SP25 */
> > #define  MACH_LASAT_200         1     /* Masquerade PRO/SP200 */
> 
> these are used, but could easily replaced by checking for CPU type
> (see lasat/prom.c how LASAT_100/LASAT_200 get selected).
> 
> > #define  MACH_NEC_MARKEINS      0     /* NEC EMMA2RH Mark-eins */
> 
> unused
> 
> > #define MACH_MSP4200_EVAL       0     /* PMC-Sierra MSP4200 Evaluation */
> > #define MACH_MSP4200_GW         1     /* PMC-Sierra MSP4200 Gateway demo */
> > #define MACH_MSP4200_FPGA       2     /* PMC-Sierra MSP4200 Emulation */
> > #define MACH_MSP7120_EVAL       3     /* PMC-Sierra MSP7120 Evaluation */
> > #define MACH_MSP7120_GW         4     /* PMC-Sierra MSP7120 Residential GW */
> > #define MACH_MSP7120_FPGA       5     /* PMC-Sierra MSP7120 Emulation */
> > #define MACH_MSP_OTHER        255     /* PMC-Sierra unknown board type */
> 
> this looks a little messy. The _EVAL and _GW defines are more a kernel
> config option than a real machine type and all they are good for is
> selecting whether there is a second serial port and which speed the
> speed kgdb should use. I'd remove that all and just set a flag, whether
> there is a second uart. I'd remove the kgbd usage, but if it's really
> needed adding another flag/variabne would do the trick.
> 
> Anything I missed ?

I totally agree with you.
I'm making a patch for MACH_TOSHIBA_* .

Yoichi
