Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 01:25:03 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.203]:23105 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226667AbVGMAYs> convert rfc822-to-8bit;
	Wed, 13 Jul 2005 01:24:48 +0100
Received: by wproxy.gmail.com with SMTP id i36so59999wra
        for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 17:25:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qrl4TWR1DRwUTqjh4UxvKhTPrgDSFoTZ8G4RlRYX1PJytB114KQBu6SEkFpNTEQahLEw79mnnO+Z5KUrEtpSZa2gC8N1e6tmw43CCRU7IAeRXh1/iGuBz4EnorYW9TJbhvTosGl6D7laOxdP6yXtX6Uan1HoArhMXDj4ZJoYkt0=
Received: by 10.54.106.13 with SMTP id e13mr136832wrc;
        Tue, 12 Jul 2005 17:25:46 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Tue, 12 Jul 2005 17:25:46 -0700 (PDT)
Message-ID: <ecb4efd105071217254e68b9e2@mail.gmail.com>
Date:	Tue, 12 Jul 2005 20:25:46 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: reboot gets stuck in a TLB exception on Au1550 based board
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

I was wondering if anyone else has a problem with reboot not working
on a Au1550? When I issue a reboot, the kernel prints "** Resetting
Integrated Peripherals", but the system doesn't reboot.

My BDI shows that the PC it is in the exception handling in the early
part of the yamon startup code. After taking the exception, if I say
'go 0xBFC00000', then the Au boots up just fine. The PC ends up at
0xbfc00424 which is an jump to self in the exception handling code in
yamon:

.org 0x400
        /* 0xBFC00400 Catch other exceptions, except EJTAG debug */
        /* Check for interrupt */
        MFC0(   k0, C0_CAUSE )
        and     k0, C0_CAUSE_CODE_MSK
        srl     k0, C0_CAUSE_CODE_SHF
        subu    k0, C0_CAUSE_CODE_INT
        beq     k0, zero, interrupt
        nop
        /* Not an interrupt */
1:
        b       1b             <=- PC ends up here after reboot.
        nop

k0 (reg 26) == 2, which I think is a TLB load or instruction fetch exception.

One difference between the stock db1x00 code and my code is that
arch/mips/au1000/db1x00/board_setup.c:board_reset() does a write to
the BCSR.SYSTEM_CONTROL[SW_RST]. I don't have the FPGA on my hardware,
but it looks like the code is wrong anyway, because the BCSR is at
0xAF000000 on the db1550, not 0xAE000000. If I take my kernel/root
image and run it on the dbau1550 board, reboot works (but in that case
it is running a different version of yamon).

I was wondering if anyone might have a clue what is going on or some
suggestions on what I can do to continue debugging this?

                               Thanks,
                               Clem
