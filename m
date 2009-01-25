Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 08:20:28 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:54725 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366115AbZAYIU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Jan 2009 08:20:26 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 735338F849D;
	Sun, 25 Jan 2009 09:20:20 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDvjJff10iPd; Sun, 25 Jan 2009 09:20:20 +0100 (CET)
Received: from [10.1.1.26] (ip-77-25-15-184.web.vodafone.de [77.25.15.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id D44038F849C;
	Sun, 25 Jan 2009 09:20:18 +0100 (CET)
Subject: Re: Au1550 with kernel linux-2.6.28.1 (SOLVED)
From:	Frank Neuber <frank.neuber@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1232839224.28527.336.camel@t60p>
References: <1232739600.28527.289.camel@t60p>
	 <20090124085734.5b6b5c66@scarran.roarinelk.net>
	 <1232787448.28527.302.camel@t60p>  <1232839224.28527.336.camel@t60p>
Content-Type: text/plain
Date:	Sun, 25 Jan 2009 09:20:16 +0100
Message-Id: <1232871616.28527.347.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <frank.neuber@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.neuber@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi List,
after a sleepness nigth I got an idea ....
Because I need an uImage I had to build a Image first.

The buildprocess of the kernel call this wrong line
mips_4KCle-objcopy  --remove-section=.reginfo  vmlinux arch/mips/boot/Image
if I add this rule in the Makefile
$(obj)/Image: $(VMLINUX) FORCE
        $(call if_changed,objcopy)
        @echo '  Kernel: $@ is ready'
On older kernelversions this works well!

The rigth one is this:
mips_4KCle-objcopy -O binary -R .note -R .comment -S  vmlinux arch/mips/boot/Image

I typed the last steps by hand for now and it works
gzip -f -9 < arch/mips/boot/Image > arch/mips/boot/zImage
/bin/sh /tmp/linux-2.6.28.1/scripts/mkuboot.sh -A mips -O linux -T kernel -C gzip -a 0x80100000 -e 0x80104690 -n 'Linux-2.6.28.1' -d arch/mips/boot/zImage uImage
(keep in mind the -a 0x80100000 -e 0x80104690 parameters are greped from vmlinux with 
TEXT_ADDR       := $(shell awk '/_text/ { printf "0x%s", $$1 ; exit }' < $(TOPDIR)/System.map)
ENTRY_ADDR      := $(shell awk '/kernel_entry/ { printf "0x%s", $$1 ; exit }' < $(TOPDIR)/System.map)
)

Than I can see my first early printk messages :-) huhuuu

Now I can work on.

BTW: why is uImage not supported by the kernel build system for MIPS?

Regards,
 Frank
  
