Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 01:20:17 +0200 (CEST)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:44900
        "EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6901708AbaHQGIYawbCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Aug 2014 08:08:24 +0200
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
        by qmta09.westchester.pa.mail.comcast.net with comcast
        id fhCi1o0011ap0As59hCieM; Sun, 17 Aug 2014 05:12:42 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta22.westchester.pa.mail.comcast.net with comcast
        id fhCi1o00F0JZ7Re3ihCiZA; Sun, 17 Aug 2014 05:12:42 +0000
Message-ID: <53F039B3.9010503@gentoo.org>
Date:   Sun, 17 Aug 2014 01:12:19 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: IP28 boot error under 3.16
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1408252362;
        bh=K981uhDededgUjvcoVZ80eDGa0OFRvS4ZuQudkhUbsI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=WMTsB1i45S/uWLRlXNkCyry8LgKUCcCpqXc5G4/ELUuBVGssPl10oIIMki9Qk08UK
         6l5zmfazHpCtlZ90i/hn528ll8pyMi+dixWRStE/cisk68jghXWdSSxuIgwMyBzSK9
         jHcHFN3TVb4QNZB1mItn4NCdAMNK9pc9En2qJA2lPsk7sDEj+6u4sMe7ZUpCxNoqRO
         zlkiz7RiVcb5eWkDAqU/jMpKWojafpDkn+5AzPAL7F2BqGtdQ0q77CxkbfDPT9yHNs
         XnZxSHHx6SM3KgE1NqxlMN1P47pjcp14nYQOGoDefgJbNLimCVP/XNPOdmKrQHJ64a
         l1Ve2gi7/UfHA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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


Has anyone tried booting IP28 lately?

I tried a cut of 3.16 from git (~08/05/14) and I get the following crash at
the ARCS console:

Exception: <vector=normal>
Status register: 0x34004882<CU1,CU0,FR,IM7,IM4,IPL=???,KX,MODE=KERNEL>
Cause register: 0x10<CE=0,EXC=RADE>
Exception PC: 0xa800000020654004, Exception RA: 0xa800000020654c9c
Read address error exception, bad address: 0xdfbdd600
Local I/O interrupt register 2: 0x0xc8<EISA,SLOT0,SLOT1>
  Saved user regs in hex (&gpda9000000020f01dc8, & regs 0x9000000020f01fc9):
  arg: dfbe0000 ffffffffa8000000 ffffffffa8000000 40000 20690000 20690000
20690000 9
  tmp: 9 38 0 ffffffff9fc60670
  sve: a8000000204f1330 ffffffff9fc572d0 ffffffff9fc572d3
  t8 206e0000 t9 206e0000 at 34004880 v0 dfbd9800 v1 a800000020654fe0 k1
ffffffffbad11bad
  gp a80000002060c000 fp 740b sp a80000002060fdc0 ra a800000020654c9c

PANIC: Unexpected exception

Going by the Exception PC and the RA, I figured out which line looks to be
causing this:

    (gdb) l *(sgihpc_init+0x78)
    0xa800000020654004 is in sgihpc_init (arch/mips/sgi-ip22/ip22-hpc.c:41).
    36              hpc3c1 = (struct hpc3_regs *)
    37                       ioremap(HPC3_CHIP1_BASE, sizeof(struct hpc3_regs));
    38              /* IOC lives in PBUS PIO channel 6 */
    39              sgioc = (struct sgioc_regs *)hpc3c0->pbus_extregs[6];
    40
--> 41              hpc3c0->pbus_piocfg[6][0] |= HPC3_PIOCFG_DS16;
    42              if (ip22_is_fullhouse()) {
    43                      /* Full House comes with INT2 which lives in
PBUS PIO
    44                       * channel 4 */
    45                      sgint = (struct sgint_regs
*)hpc3c0->pbus_extregs[4];

To me, it looks like a pointer isn't getting converted to 64bit address
space correctly (0xdfbdd600 -> ???).  I haven't played with this IP28
machine for a few years, so I forget what the best approach to fixing this is.

Thoughts?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
