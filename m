Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2008 15:32:35 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:52949 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28574940AbYGLOcc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2008 15:32:32 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KHg9H-0005gi-00; Sat, 12 Jul 2008 16:32:31 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9BF72C2EC0; Sat, 12 Jul 2008 16:32:25 +0200 (CEST)
Date:	Sat, 12 Jul 2008 16:32:25 +0200
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] mips_machtype define as one group
Message-ID: <20080712143225.GA9053@alpha.franken.de>
References: <20080711225717.cbf55ccc.yoichi_yuasa@tripeaks.co.jp> <20080711143235.GA9016@alpha.franken.de> <20080712174741.c4dd3149.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080712174741.c4dd3149.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Jul 12, 2008 at 05:47:41PM +0900, Yoichi Yuasa wrote:
> On Fri, 11 Jul 2008 16:32:35 +0200
> tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:
> 
> > On Fri, Jul 11, 2008 at 10:57:17PM +0900, Yoichi Yuasa wrote:
> > > mips_machtype define as one group.
> > 
> > wouldn't it make more sense to kill that completly ?
> 
> mips_machtype is still used in some places.
> Should we check first whether it can be removed?

I don't know Ralf's opinion about the removal, but if he agrees, we
should just look for the remaining usage cases and see, if it could
be resolved in a differnt way.

Here is my first look at all the various MACH_XXX:

> #define  MACH_ACER_PICA_61      0     /* Acer PICA-61 (PICA1) */
> #define  MACH_MIPS_MAGNUM_4000  1     /* Mips Magnum 4000 "RC4030" */
> #define  MACH_OLIVETTI_M700     2     /* Olivetti M700-10 (-15 ??) */

all three are in arch/mips/fw/arc/identify.c, but only MACH_MIPS_MAGNUM_4000
is used in arch/mips/jazz/setup.c. But the usage in arch/mips/jazz/setup.c
is not quite correct and I'd like to remove it there.

> #define  MACH_DSUNKNOWN         0
> #define  MACH_DS23100           1     /* DECstation 2100 or 3100 */
> #define  MACH_DS5100            2     /* DECsystem 5100 */
> #define  MACH_DS5000_200        3     /* DECstation 5000/200 */
> #define  MACH_DS5000_1XX        4     /* DECstation 5000/120, 125, 133, 150*/
> #define  MACH_DS5000_XX         5     /* DECstation 5000/20, 25, 33, 50 */
> #define  MACH_DS5000_2X0        6     /* DECstation 5000/240, 260 */
> #define  MACH_DS5400            7     /* DECsystem 5400 */
> #define  MACH_DS5500            8     /* DECsystem 5500 */
> #define  MACH_DS5800            9     /* DECsystem 5800 */
> #define  MACH_DS5900            10    /* DECsystem 5900 */

that's the only poweruser. I'd rename mips_machtype to dec_machtype and
just use it for decstation as it is today.

> #define  MACH_SNI_RM200_PCI     0     /* RM200/RM300/RM400 PCI series */

only in arch/mips/fw/arc/identify

> #define  MACH_SGI_IP22          0     /* Indy, Indigo2, Challenge S */
> #define  MACH_SGI_IP27          1     /* Origin 200, Origin 2000, Onyx 2 */
> #define  MACH_SGI_IP28          2     /* Indigo2 Impact */
> #define  MACH_SGI_IP32          3     /* O2 */
> #define  MACH_SGI_IP30          4     /* Octane, Octane2 */

all SGI defines are only in arch/mips/fw/arc/identify

> #define  MACH_PALLAS            0
> #define  MACH_TOPAS             1
> #define  MACH_JMR               2
> #define  MACH_TOSHIBA_JMR3927   3     /* JMR-TX3927 CPU/IO board */

these 4 are unused

> #define  MACH_TOSHIBA_RBTX4927  4
> #define  MACH_TOSHIBA_RBTX4937  5
> #define  MACH_TOSHIBA_RBTX4938  6

there is only one usage for that, so moving the code for setting of
mips_machtype from toshiba_rbtx4927_prom.c to toshiba_rbtx4927_setup.c
will make that defines obsolete.

> #define  MACH_LASAT_100         0     /* Masquerade II/SP100/SP50/SP25 */
> #define  MACH_LASAT_200         1     /* Masquerade PRO/SP200 */

these are used, but could easily replaced by checking for CPU type
(see lasat/prom.c how LASAT_100/LASAT_200 get selected).

> #define  MACH_NEC_MARKEINS      0     /* NEC EMMA2RH Mark-eins */

unused

> #define MACH_MSP4200_EVAL       0     /* PMC-Sierra MSP4200 Evaluation */
> #define MACH_MSP4200_GW         1     /* PMC-Sierra MSP4200 Gateway demo */
> #define MACH_MSP4200_FPGA       2     /* PMC-Sierra MSP4200 Emulation */
> #define MACH_MSP7120_EVAL       3     /* PMC-Sierra MSP7120 Evaluation */
> #define MACH_MSP7120_GW         4     /* PMC-Sierra MSP7120 Residential GW */
> #define MACH_MSP7120_FPGA       5     /* PMC-Sierra MSP7120 Emulation */
> #define MACH_MSP_OTHER        255     /* PMC-Sierra unknown board type */

this looks a little messy. The _EVAL and _GW defines are more a kernel
config option than a real machine type and all they are good for is
selecting whether there is a second serial port and which speed the
speed kgdb should use. I'd remove that all and just set a flag, whether
there is a second uart. I'd remove the kgbd usage, but if it's really
needed adding another flag/variabne would do the trick.

Anything I missed ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
