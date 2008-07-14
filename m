Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 12:27:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43445 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28577441AbYGNL12 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 12:27:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EBRXJV026499;
	Mon, 14 Jul 2008 12:27:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EBRWNO026498;
	Mon, 14 Jul 2008 12:27:32 +0100
Date:	Mon, 14 Jul 2008 12:27:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] mips_machtype define as one group
Message-ID: <20080714112732.GD10379@linux-mips.org>
References: <20080711225717.cbf55ccc.yoichi_yuasa@tripeaks.co.jp> <20080711143235.GA9016@alpha.franken.de> <20080712174741.c4dd3149.yoichi_yuasa@tripeaks.co.jp> <20080712143225.GA9053@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080712143225.GA9053@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 12, 2008 at 04:32:25PM +0200, Thomas Bogendoerfer wrote:

> > mips_machtype is still used in some places.
> > Should we check first whether it can be removed?
> 
> I don't know Ralf's opinion about the removal, but if he agrees, we
> should just look for the remaining usage cases and see, if it could
> be resolved in a differnt way.

I was also planning to get rid of it. A while ago I already removed
mips_machgroup.  This was easy with no real user remaining.  Removing
mips_machtype turned out to be slightly trickier since there are actual
users remaining.


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

Yep.

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

That or a platform-private variable.

> > #define  MACH_NEC_MARKEINS      0     /* NEC EMMA2RH Mark-eins */
> 
> unused

I guess people blindly following Jun's old porting howto ...

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

When I looked at it last time I found that some of the mips_machtype uses
might be replaced with platform devices.

  Ralf
