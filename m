Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 23:43:17 +0100 (BST)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:55976 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225290AbTFYWnP>;
	Wed, 25 Jun 2003 23:43:15 +0100
Received: (qmail 27646 invoked by uid 65534); 25 Jun 2003 22:43:11 -0000
Received: from pD9EE6FA9.dip.t-dialin.net (EHLO gmx.de) (217.238.111.169)
  by mail.gmx.net (mp006) with SMTP; 26 Jun 2003 00:43:11 +0200
Message-ID: <3EFA24C9.7010901@gmx.de>
Date: Thu, 26 Jun 2003 00:40:09 +0200
From: Michael Gruetzner <Michael_Gruetzner@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Booting Kernel on RM200
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Michael_Gruetzner@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael_Gruetzner@gmx.de
Precedence: bulk
X-list: linux-mips

Hello,

I've still got some trouble booting the kernel on my RM200. This is what 
i did:
I've downloaded milo and the precompiled kernel image from 
ftp.linux-mips.org. Then I burned milo and vmlinux on a cdr. When I 
start milo on the RM200 everything looks fine but milo doesn't load the 
image from cd. So I copied vmlinux onto a floppy. Now milo is able to 
find the image an it seems to load the kernel. After a few minutes(yes 
it takes that long) milo says: "Booting the kernel..." but nothing 
happens. I also tried a kernel that I've crosscompiled on my box but 
then milo says "Not a mips kernel" (because it was compiled as 
mipsel-linux - what seems to be the right because with ARC firmware the 
RM200 is little endian).
So could you please give me some advice how I can boot a linux kernel on 
such a box.

Thank you very much in advance.

Michael

-- 
printk("CPU[%d]: Sending penguins to jail...",smp_processor_id());
  [... 20 lines ...]
printk("CPU[%d]: Giving pardon to imprisoned penguins\n", 
smp_processor_id());
         2.4.8 arch/sparc64/kernel/smp.c
