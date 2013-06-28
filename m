Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 09:06:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55169 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6820509Ab3F1HGAJ94GB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 09:06:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5S75tsU031839;
        Fri, 28 Jun 2013 09:05:55 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5S75r0B031817;
        Fri, 28 Jun 2013 09:05:53 +0200
Date:   Fri, 28 Jun 2013 09:05:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V10 12/13] MIPS: Loongson 3: Add CPU hotplug support
Message-ID: <20130628070553.GI10727@linux-mips.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
 <1366030028-5084-13-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366030028-5084-13-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, Apr 15, 2013 at 08:47:07PM +0800, Huacai Chen wrote:

> +/* To shutdown a core in Loongson 3, the target core should go to CKSEG1 and
> + * flush all L1 entries at first. Then, another core (usually Core 0) can
> + * safely disable the clock of the target core. loongson3_play_dead() is
> + * called via CKSEG1 (uncached and unmmaped) */
> +void loongson3_play_dead(int *state_addr)
> +{
> +	__asm__ __volatile__(
> +		"      .set push                         \n"
> +		"      .set noreorder                    \n"
> +		"      li $t0, 0x80000000                \n" /* KSEG0 */
> +		"      li $t1, 512                       \n" /* num of L1 entries */
> +		"flush_loop:                             \n" /* flush L1 */

Please don't use normale in inline assembler.  This might result in build
errors.  it's horrible to read but number local labels like:

1:	subu	$t0, $t0, 1
	bnez	$t0, 1b

are safe.  "1b" means the label 1 backwards from the users but you can
also use 1f to branch forward:

	bnez	$t0, 1f
	...
1:	jr	$ra

> +		"      cache 0, 0($t0)                   \n" /* ICache */
> +		"      cache 0, 1($t0)                   \n"
> +		"      cache 0, 2($t0)                   \n"
> +		"      cache 0, 3($t0)                   \n"
> +		"      cache 1, 0($t0)                   \n" /* DCache */
> +		"      cache 1, 1($t0)                   \n"
> +		"      cache 1, 2($t0)                   \n"
> +		"      cache 1, 3($t0)                   \n"
> +		"      addiu $t0, $t0, 0x20              \n"
> +		"      bnez  $t1, flush_loop             \n"
> +		"      addiu $t1, $t1, -1                \n"
> +		"      li    $t0, 0x7                    \n" /* *state_addr = CPU_DEAD; */
> +		"      sw    $t0, 0($a0)                 \n"
> +		"      sync                              \n"
> +		"      cache 21, 0($a0)                  \n" /* flush entry of *state_addr */
> +		"      .set pop                          \n");
> +
> +	__asm__ __volatile__(
> +		"      .set push                         \n"
> +		"      .set noreorder                    \n"
> +		"      .set mips64                       \n"
> +		"      mfc0  $t2, $15, 1                 \n"
> +		"      andi  $t2, 0x3ff                  \n"
> +		"      .set mips3                        \n"
> +		"      dli   $t0, 0x900000003ff01000     \n"

I'm wondering about the .set mips3 here.  It's redundant following a
.set mips64.  But I'm wondering, are you doing this on a 32 bit kernel?
On 32 bit this is only safe as long as interrupts are off.  If an interrupt
is taken registers will be corrupted.

If yes, this is only safe on as long as interrupts are disabled.

> +		"      andi  $t3, $t2, 0x3               \n"
> +		"      sll   $t3, 8                      \n"  /* get cpu id */
> +		"      or    $t0, $t0, $t3               \n"
> +		"      andi  $t1, $t2, 0xc               \n"
> +		"      dsll  $t1, 42                     \n"  /* get node id */
> +		"      or    $t0, $t0, $t1               \n"
> +		"wait_for_init:                          \n"
> +		"      li    $a0, 0x100                  \n"
> +		"idle_loop:                              \n"
> +		"      bnez  $a0, idle_loop              \n"
> +		"      addiu $a0, -1                     \n"
> +		"      lw    $v0, 0x20($t0)              \n"  /* get PC via mailbox */
> +		"      nop                               \n"

Useless nop - only R2000/R3000 has load delay slots.

> +		"      beqz  $v0, wait_for_init          \n"
> +		"      nop                               \n"

Ditto.

> +		"      ld    $sp, 0x28($t0)              \n"  /* get SP via mailbox */
> +		"      nop                               \n"

Ditto.

> +		"      ld    $gp, 0x30($t0)              \n"  /* get GP via mailbox */
> +		"      nop                               \n"

Ditto.

> +		"      ld    $a1, 0x38($t0)              \n"
> +		"      nop                               \n"

Ditto.

> +		"      jr  $v0                           \n"  /* jump to initial PC */
> +		"      nop                               \n"
> +		"      .set pop                          \n");
> +}

Much of this inline assembler code can be replaced with C.  Even direct
register manipulation is possible in C:

	register unsigned long sp __asm__("$29");

	sp = ptr->mailbox;

But you probably want to leave that part in assembler, so you get something
like:

	__asm__ __volatile__(
	"	move	$sp, %[sp]			\n"
	"	move	$gp, %[gp]			\n"
	"	move	$a1, %[a1]			\n"
	"	jr	%[dst]				\n"
	: /* No outputs */
	: [sp]  "r" (mailbox->sp),
	  [gp]  "r" (mailbox->gp),
	  [a1]  "r" (mailbox->a1),
	  [dst] "r" (mailbox->whatever));

	unreachable();

No more weird hardcoded offsets, safe, easier to read.

  Ralf
