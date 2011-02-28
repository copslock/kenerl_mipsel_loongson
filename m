Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2011 09:15:30 +0100 (CET)
Received: from mail169.messagelabs.com ([85.158.138.179]:13120 "HELO
        mail169.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491025Ab1B1IPX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Feb 2011 09:15:23 +0100
X-VirusChecked: Checked
X-Env-Sender: nikolaos.korkakakis@sitelsemi.com
X-Msg-Ref: server-13.tower-169.messagelabs.com!1298880921!33425220!1
X-StarScan-Version: 6.2.9; banners=-,-,-
X-Originating-IP: [193.172.215.35]
Received: (qmail 30229 invoked from network); 28 Feb 2011 08:15:21 -0000
Received: from mail1.sitelsemi.com (HELO mail1.sitelsemi.com) (193.172.215.35)
  by server-13.tower-169.messagelabs.com with SMTP; 28 Feb 2011 08:15:21 -0000
Received: from [10.4.0.145] ([10.4.0.145])
          by mail1.sitelsemi.com (Lotus Domino Release 8.5.2)
          with ESMTP id 2011022809152674-20080 ;
          Mon, 28 Feb 2011 09:15:26 +0100 
Message-ID: <4D6B5988.70406@sitelsemi.com>
Date:   Mon, 28 Feb 2011 10:15:04 +0200
From:   Nikolaos Korkakakis <nikolaos.korkakakis@sitelsemi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, korkakak@gmail.com
Subject: Shadow registers optimizations
X-MIMETrack: Itemize by SMTP Server on NLMAIL01/SiTel(Release 8.5.2|August 10, 2010) at
 02/28/2011 09:15:26 AM,
        Serialize by Router on NLMAIL01/SiTel(Release 8.5.2|August 10, 2010) at 02/28/2011
 09:15:27 AM,
        Serialize complete at 02/28/2011 09:15:27 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-Path: <nikolaos.korkakakis@sitelsemi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nikolaos.korkakakis@sitelsemi.com
Precedence: bulk
X-list: linux-mips

Good morning list,

I would like to do some optimizations in the kernel to boost even more 
the performance of the m14kc (and potentially m4 series as well). One of 
the interesting ideas that has the potential in a busy system to provide 
higher performance are the shadow registers for interrupt handling code 
(maybe there are other usages for shadow registers in other areas by I 
leave this aside).

I had a somewhat long talk with Ralf over irc last friday, which started 
from the point that in kernel/traps.c there are two vi handler 
installers. A helper (set_vi_srs_handler) and a wrapper of the helper 
(set_vi_handler)

the helper in case of shadow sets exists it only adds a jump in the vi 
table (the "0x08000000 | (((u32)handler >> 2) & 0x03fffff);" is that 
kind of magic) followed by a nop. that's all. that's ok for a helper but 
it may have a performance impact since on each dump the whole execution 
pipeline is flushed, not to mention the actual loss of the whole 
VECTORSPACING (which is hard set to 0x100 bytes) memory space for just 
8bytes of code.

So I intend to change some things around the traps code.
  - The first is how the VECTORSPACING is defined (no constant 
declaration anymore) it is gonna be a dynamic init based setup that 
would alter the intctl register as it ought to in the first place
  - the second is that in case of shadow register != 0 the handlers (ie 
the plat_irq_dispatch) should be copied there if the VECTORSPACING space 
is sufficient or else use the jump install code

loose ends. Ralf mentioned that the usage of shadow registers is not 
str8 fwd and a careful approach should be taken. those are
  1) arch/mips/kernel/entry.S  _TIF_NEED_RESCHED
  2) asm/irq_regs.h get_irq_regs() [rdpgpr and wrpgpr]
  3) <add yours>

For 1 and 2 the solution seems pretty trivial, but if you have any other 
ideas please elaborate on this so the loose ends are pinpointed and 
attacked.

BR,
N

-- 
Nikolaos Korkakakis
Embedded Software Engineer
Tel:         +30 2610 390 948
OS and Applications Group
SiTel Semiconductor BV
