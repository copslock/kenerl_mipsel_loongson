Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2004 15:49:42 +0100 (BST)
Received: from imfep04.dion.ne.jp ([IPv6:::ffff:210.174.120.150]:49611 "EHLO
	imfep04.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224948AbUHaOth>; Tue, 31 Aug 2004 15:49:37 +0100
Received: from mb.neweb.ne.jp ([218.222.88.128]) by imfep04.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with ESMTP
          id <20040831144932.CWRR32431.imfep04.dion.ne.jp@mb.neweb.ne.jp>
          for <linux-mips@linux-mips.org>; Tue, 31 Aug 2004 23:49:32 +0900
Date: Tue, 31 Aug 2004 23:49:31 +0900
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Reset of USB
From: ichinoh@mb.neweb.ne.jp
To: linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
Message-Id: <F7800BBC-FB5C-11D8-85DA-000A956B2316@mb.neweb.ne.jp>
X-Mailer: Apple Mail (2.553)
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hello ,

I invoked the Linux kernel on ALCHEMY DBAU1100 by U-BOOT.

The processing which resets USB-OHCI of the head of a kernel is not 
completed. (refer to *)

Au1100 does not indicate "reset is completed."
Is this phenomenon experienced?

In addition,
this phenomenon is not encountered when starting a kernel by YAMON.


*:
arch/mips/au1000/common/setup.c

#ifdef CONFIG_USB_OHCI
	// enable host controller and wait for reset done
	au_writel(0x08, USB_HOST_CONFIG);
	udelay(1000);
	au_writel(0x0E, USB_HOST_CONFIG);
	udelay(1000);
	au_readl(USB_HOST_CONFIG); // throw away first read
	while (!(au_readl(USB_HOST_CONFIG) & 0x10))
		au_readl(USB_HOST_CONFIG);
#endif

Best regards,
Nyauyama
