Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 18:41:28 +0200 (CEST)
Received: from [209.116.120.7] ([209.116.120.7]:31500 "EHLO
	tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S1122961AbSIMQl1>; Fri, 13 Sep 2002 18:41:27 +0200
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <R6SWSVLL>; Fri, 13 Sep 2002 12:40:48 -0400
Message-ID: <37A3C2F21006D611995100B0D0F9B73CBFE282@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: 'Gareth' <g.c.bransby-99@student.lboro.ac.uk>,
	linux-mips@linux-mips.org
Subject: RE: Cycle counter
Date: Fri, 13 Sep 2002 12:40:41 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <nmckee@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nmckee@telogy.com
Precedence: bulk
X-list: linux-mips

Is this under a OS or a single execution?  Are there interrupts enabled? If
so, disable them for measurements. (Clock interrupt, serial port, etc.).

BTW, most MIPS implementations for OS's and monitors use the count/compare
for their main tick. If you set it to zero you may be stepping on someone's
tick.  A better method might be to read the count register and read it again
at the end and do a difference - that way you preserve other's values.   

Other reasons for a delay: to fetch code (external mem ->cache -> cpu) and
push items onto/off the stack...  Theres probably more that I can't think of
right now...

-----Original Message-----
From: Gareth [mailto:g.c.bransby-99@student.lboro.ac.uk]
Sent: Friday, September 13, 2002 12:28 PM
To: linux-mips@linux-mips.org
Subject: Cycle counter


Hi,

Another question reagarding the mips malta board. I am wanting to be able to
find out how many cycles a certain loop takes to execute. I understand there
is
a cycle counter built into the processor that I want to use for this. I have
a
bit of inline assembly to do the job but the results I am getting are not
consistent so i think there is probably something wrong with my attempt at
the
inline assembly. Here is the code : 

  void al_signal_start(void);
  size_t al_signal_finished(void);
  unsigned int GetcpuCycles(void);

  char str[8];

  int main (void)
  {
      double x;
      al_signal_start();
    
      x = al_signal_finished();
      printf("GetcpuCycles says : %f \n",x);

      return 0;
  }

  size_t al_signal_finished(void)
  {
      return GetcpuCycles();	
  }

  void al_signal_start(void)
  {
	  int zero,temp;
	  __asm__("move $2, $zero");
	  __asm__("nop");
          __asm__("mtc0 $2, $9" :  : "r" (temp));
          __asm__("nop");
          __asm__("nop");
          __asm__("nop");
  }

  unsigned int GetcpuCycles(void)
  {
          int temp;
          __asm__(".set reorder");
          __asm__("mfc0 $2, $9" : : "r" (temp));
          __asm__("nop");
          __asm__("nop");
          __asm__("nop");
          /*__asm__("jr $31" );*/
  }


As you can see, main just starts and stops the counter with no instructions
in
between. I expexcted the cycle count to be zero or close to it because of
the
instructions required to get the count but this is not the case. I am
getting
numbers like 8499. Is there just something wrong with my assembly or is
there
something else I am missing?

Thanks for any help
Gareth
