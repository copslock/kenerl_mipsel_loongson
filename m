Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 18:28:52 +0200 (CEST)
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:44679 "EHLO
	fw-cam.cambridge.arm.com") by linux-mips.org with ESMTP
	id <S1122961AbSIMQ2w>; Fri, 13 Sep 2002 18:28:52 +0200
Received: by fw-cam.cambridge.arm.com; id RAA12072; Fri, 13 Sep 2002 17:28:38 +0100 (BST)
Received: from unknown(172.16.9.107) by fw-cam.cambridge.arm.com via smap (V5.5)
	id xma011784; Fri, 13 Sep 02 17:28:17 +0100
Date: Fri, 13 Sep 2002 17:28:24 +0100
From: Gareth <g.c.bransby-99@student.lboro.ac.uk>
To: linux-mips@linux-mips.org
Subject: Cycle counter
Message-Id: <20020913172824.5c7ed0a4.g.c.bransby-99@student.lboro.ac.uk>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <g.c.bransby-99@student.lboro.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: g.c.bransby-99@student.lboro.ac.uk
Precedence: bulk
X-list: linux-mips

Hi,

Another question reagarding the mips malta board. I am wanting to be able to
find out how many cycles a certain loop takes to execute. I understand there is
a cycle counter built into the processor that I want to use for this. I have a
bit of inline assembly to do the job but the results I am getting are not
consistent so i think there is probably something wrong with my attempt at the
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


As you can see, main just starts and stops the counter with no instructions in
between. I expexcted the cycle count to be zero or close to it because of the
instructions required to get the count but this is not the case. I am getting
numbers like 8499. Is there just something wrong with my assembly or is there
something else I am missing?

Thanks for any help
Gareth
