Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 20:19:53 +0000 (GMT)
Received: from dsl081-242-215.sfo1.dsl.speakeasy.net ([IPv6:::ffff:64.81.242.215]:43219
	"HELO rave.localdomain") by linux-mips.org with SMTP
	id <S8225535AbUA1UTw>; Wed, 28 Jan 2004 20:19:52 +0000
Received: (qmail 12942 invoked by uid 500); 28 Jan 2004 20:18:53 -0000
To: linux-mips@linux-mips.org
Subject: Systematic jiffie slip in arch/mips/kernel/timer.c:timer_interrupt
From: David Wuertele <dave-gnus@bfnet.com>
Date: Wed, 28 Jan 2004 12:18:53 -0800
Message-ID: <m3ad47zv0y.fsf@bfnet.com>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <dave-gnus@bfnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave-gnus@bfnet.com
Precedence: bulk
X-list: linux-mips

arch/mips/kernel/timer.c:timer_interrupt() says the following:

  void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
          if (mips_cpu.options & MIPS_CPU_COUNTER) {
                  unsigned int count;

                  /*
                   * The cycle counter is only 32 bit which is good for about
                   * a minute at current count rates of upto 150MHz or so.
                   */
                  count = read_32bit_cp0_register(CP0_COUNT);
                  timerhi += (count < timerlo);   /* Wrap around */
                  timerlo = count;

                  /*
                   * set up for next timer interrupt - no harm if the machine
                   * is using another timer interrupt source.
                   * Note that writing to COMPARE register clears the interrupt
                   */
                  write_32bit_cp0_register (CP0_COMPARE,
                                            count + cycles_per_jiffy);
          }
  <snip>...

This can't be right: it sets the cycle counter to go off
cycles_per_jiffy cycles after the timer_interrupt finally gains the
CPU.  Let's say that the latency between the interrupt being raised
and timer_interrupt() getting called is LATENCY.  Then the period with
which this interrupt is raised will actually be cycles_per_jiffy +
LATENCY, which is a longer period than one jiffy!  So the jiffy
counter will always run slow.  On my MIPS system I measured the
average latency of this routine being called, and it averaged around
500 cycles!  (Note: we have a very active PIO device that runs with
interrupts turned off part of the time)

It seems to me that the jiffy counter could be made to keep better
average time in one (or both) of two ways:

1) Accumulate latencies as "fractional jiffies", and increment the
   jiffie counter accordingly, like so:

  void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs) {
     static unsigned int expect_interrupt_at, frac_jiffy_accumulator;
     if (mips_cpu.options & MIPS_CPU_COUNTER) {
	unsigned int count, lateby;
        count = read_32bit_cp0_register(CP0_COUNT);
	timerhi += (count < timerlo);   /* Wrap around */
	timerlo = count;

        /* Find out how much we're LATE BY */
	if (count < expect_interrupt_at)
	  lateby = (unsigned int) ((u64) 0x100000000 - (u64) expect_interrupt_at + (u64) count);
	else
	  lateby = count - expect_interrupt_at;
	frac_jiffy_accumulator += lateby;
	while (frac_jiffy_accumulator > cycles_per_jiffy) {
          /* We've accumulated at least a jiffie of lateness.  Catch up. */
	  (*(unsigned long *)&jiffies)++;
	  frac_jiffy_accumulator -= cycles_per_jiffy;
	}

	expect_interrupt_at = count + cycles_per_jiffy;
	write_32bit_cp0_register (CP0_COMPARE, expect_interrupt_at);
     }

2) Set the clock to actually go off sooner, in order to better
   approximate a cycle timer:

  void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs) {
     static unsigned int expect_interrupt_at;
     if (mips_cpu.options & MIPS_CPU_COUNTER) {
	unsigned int count;
        count = read_32bit_cp0_register(CP0_COUNT);
	timerhi += (count < timerlo);   /* Wrap around */
	timerlo = count;

 	expect_interrupt_at += cycles_per_jiffy;
        /* Add some logic here for dealing with latencies that are
           greater than a whole jiffy */
	write_32bit_cp0_register (CP0_COMPARE, expect_interrupt_at);
     }

I think option (1) above is better, because it doesn't actually change
the interrupt frequency compared to the status quo, whereas option (2)
actualy makes the timer interrupt more regular at the expense of more
interrupts and more overhead.

Comments anyone?
Dave
