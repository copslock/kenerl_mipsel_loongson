Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 17:04:45 +0100 (BST)
Received: from ftpbox.mot.com ([IPv6:::ffff:129.188.136.101]:43947 "EHLO
	ftpbox.mot.com") by linux-mips.org with ESMTP id <S8225794AbUDWQEo>;
	Fri, 23 Apr 2004 17:04:44 +0100
Received: from il06exr06.mot.com (il06exr06.mot.com [129.188.137.136])
	by ftpbox.mot.com (Motorola/Ftpbox) with ESMTP id i3NG4gXU028857
	for <linux-mips@linux-mips.org>; Fri, 23 Apr 2004 09:04:42 -0700 (MST)
Received: from ca25exm01.GI.COM (ca25exm01.w1.bcs.mot.com [168.84.84.121])
	by il06exr06.mot.com (Motorola/il06exr06) with ESMTP id i3NG4BXP019479
	for <linux-mips@linux-mips.org>; Fri, 23 Apr 2004 11:04:41 -0500
Received: by ca25exm01 with Internet Mail Service (5.5.2657.2)
	id <F55XWC98>; Fri, 23 Apr 2004 09:04:10 -0700
Message-ID: <D5A7E45D575DD61180130002A5DB377C04E48C99@ca25exm01>
From: Stephens Tim-MGI1634 <Tim.Stephens@motorola.com>
To: linux-mips@linux-mips.org
Subject: Why does serial.c not allow you to share the serial console port 
	 interrupt?
Date: Fri, 23 Apr 2004 09:04:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.2)
Content-Type: text/plain
Return-Path: <Tim.Stephens@motorola.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Tim.Stephens@motorola.com
Precedence: bulk
X-list: linux-mips

Hello,

I'm trying to understand why the serial.c driver does not allow the sharing of the serial console interrupt.  There are several places on the net the mention you cannot share the console interrupt, however there is no explaination why.  I assume it has something to do with OOPS reporting.  Please advise.

I'm trying to enable the second serial port on a MIPS based embedded system.  Both serial ports (16550 type) are attached to the same MIPS interrupt.  The console is attached to ttyS0, which shares the MIPS interrupt with ttyS1.

The code in question is:

#ifdef CONFIG_SERIAL_CONSOLE
    /*
     *    The interrupt of the serial console port
     *    can't be shared.
     */
    if (sercons.flags & CON_CONSDEV) {
        for(i = 0; i < NR_PORTS; i++)
            if (i != sercons.index &&
                rs_table[i].irq == rs_table[sercons.index].irq)
                rs_table[i].irq = 0;
    }
#endif

If I change the #ifdef to #if 0 both the console and ttyS1 seem to work ok.

Thanks,
Tim
