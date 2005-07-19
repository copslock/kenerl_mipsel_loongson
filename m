Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 20:51:46 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:7294
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226907AbVGSTvZ>; Tue, 19 Jul 2005 20:51:25 +0100
Received: (qmail 40249 invoked from network); 19 Jul 2005 19:53:09 -0000
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 19 Jul 2005 19:53:09 -0000
Subject: Re: bal instruction in gcc 3.x
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Kishore K <hellokishore@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <f07e6e05071910194bab9b16@mail.gmail.com>
References: <f07e6e05071909301c212ab4@mail.gmail.com>
	 <20050719164427.GB8758@linux-mips.org>
	 <f07e6e05071910194bab9b16@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-0sqhL2MLABQ9jtjNc0JA"
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 19 Jul 2005 12:53:06 -0700
Message-Id: <1121802786.7285.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--=-0sqhL2MLABQ9jtjNc0JA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Try the attached patch instead.

Pete

On Tue, 2005-07-19 at 22:49 +0530, Kishore K wrote:
> On 7/19/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, Jul 19, 2005 at 10:00:20PM +0530, Kishore K wrote:
> > 
> > > We are facing a problem when U-boot is compiled with gcc 3.x
> > >
> > > U-boot  uses the following instruction in one of the files.
> > >
> > > bal jump_to_symbol
> > >
> > > This code gets compiled without any problem with gcc2. However, if I
> > > compile the code
> > > with gcc3, it exits with the error "Cannot branch to unknown symbol".
> > >
> > > What should we do to circumvent this problem ?
> > >
> > > I replaced
> > >
> > > bal jump_to_symbol
> > >
> > > by
> > >
> > > la t9, jump_to_symbol
> > > jalr t9
> > >
> > > Then code gets compiled properly without any problem. Please let me
> > > know, whether this
> > > is correct way of fixing the problem. I am newbie to MIPS assembly
> > > language. Why this
> > > change is required with gcc 3.x compiler ?
> > 
> > FIrst of all, gcc doesn't care at all about your assembler code, that's
> > the assembler which you must have changed along with that.
> > 
> > There used to be no relocation type to represent a branch to an external
> > symbol in an ELF file which is why gas is throwing an error message, so
> > gas is throwing an error message.  Latest gas fixed that shortcoming.
> > I think there was a bug in somewhat older gas which resulted in such
> > invalid code actually being accepted even though it shouldn't have been.
> > 
> >   Ralf
> 
> Thank you very much for the reply.
> 
> First of all code got compiled only after removing the option
> -mips-allow-branch-to-undefined from Makefile. If this option is
> included, compilation fails saying that option is invalid. I am using
> binutils-2.14.90.06.
> Same problem is observed even with binutils 2.15.94.0.2.2. 
> 
> Do you mean to say that no change is required in the code snippet 
> 
> bal jump_to_symbol
> 
> and code should get compiled with the latest assembler without any
> problem. Please clearify.
> 
> TIA,
> --kishore
> 

--=-0sqhL2MLABQ9jtjNc0JA
Content-Disposition: attachment; filename=mips_jalr.diff
Content-Type: text/x-patch; name=mips_jalr.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

--- start.S	2004-02-06 17:27:17.000000000 -0800
+++ start.S~jalr	2005-01-29 16:13:18.000000000 -0800
@@ -234,21 +234,35 @@
 	li	t0, CONF_CM_UNCACHED
 	mtc0	t0, CP0_CONFIG
 
+	/* Initialize GOT pointer.
+	 */
+	bal	1f
+	nop
+	.word	_GLOBAL_OFFSET_TABLE_ - 1f + 4
+1:
+	move	gp, ra
+	lw	t1, 0(ra)
+	add	gp, t1
+
+
 #ifdef CONFIG_INCA_IP
 	/* Disable INCA-IP Watchdog.
 	 */
-	bal	disable_incaip_wdt
+	la	t9, disable_incaip_wdt
+	jalr	t9
 	nop
 #endif
 
 	/* Initialize any external memory.
 	 */
-	bal	memsetup
+	la	t9, memsetup
+	jalr	t9
 	nop
 
 	/* Initialize caches...
 	 */
-	bal	mips_cache_reset
+	la	t9, mips_cache_reset
+	jalr	t9
 	nop
 
 	/* ... and enable them.
@@ -260,21 +274,13 @@
 	/* Set up temporary stack.
 	 */
 	li	a0, CFG_INIT_SP_OFFSET
-	bal	mips_cache_lock
+	la	t9, mips_cache_lock
+	jalr	t9
 	nop
 
 	li	t0, CFG_SDRAM_BASE + CFG_INIT_SP_OFFSET
 	la	sp, 0(t0)
 
-	/* Initialize GOT pointer.
-	 */
-	bal	1f
-	nop
-	.word	_GLOBAL_OFFSET_TABLE_ - 1f + 4
-1:
-	move	gp, ra
-	lw	t1, 0(ra)
-	add	gp, t1
 	la	t9, board_init_f
 	j	t9
 	nop

--=-0sqhL2MLABQ9jtjNc0JA--
