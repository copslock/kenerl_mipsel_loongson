Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 18:47:11 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:44504 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225223AbTCMSrK>;
	Thu, 13 Mar 2003 18:47:10 +0000
Received: (qmail 18445 invoked by uid 6180); 13 Mar 2003 18:47:04 -0000
Date: Thu, 13 Mar 2003 10:47:04 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: arch/mips/au1000/common/irq.c
Message-ID: <20030313104704.V20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Pete:

I've got a question concerning irq.c. In intc0_req0_irqdispatch() (linux_2_4
branch) on lines 545 thru 552, the code reads:

      for (i=0; i<32; i++) {
          if ((intc0_req0 & (1<<i))) {
              intc0_req0 &= ~(1<<i);
              do_IRQ(irq, regs);
              break;
          }
          irq++;
      }

My question is: why do we increment i and irq independently?
Why doesn't the code read:

      for (i=0; i<32; i++) {
          if ((intc0_req0 & (1<<i))) {
              intc0_req0 &= ~(1<<i);
              do_IRQ(i, regs);
              break;
          }
      }

Thanks for your help!

-Jeff





-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
