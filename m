Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 21:56:29 +0100 (CET)
Received: from roasted.cubic.org ([193.108.181.130]:3041 "EHLO
	roasted.cubic.org") by lappi.linux-mips.net with ESMTP
	id S1102490AbYCZU4Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Mar 2008 21:56:25 +0100
Received: from localhost ([127.0.0.1] helo=mail.cubic.org)
	by roasted.cubic.org with esmtp (Exim 3.36 #1)
	id 1JeccW-0007Pd-00
	for linux-mips@linux-mips.org; Wed, 26 Mar 2008 21:53:16 +0100
Received: from 85.177.213.130
        (SquirrelMail authenticated user michael)
        by mail.cubic.org with HTTP;
        Wed, 26 Mar 2008 21:53:16 +0100 (CET)
Message-ID: <48312.85.177.213.130.1206564796.squirrel@mail.cubic.org>
Date:	Wed, 26 Mar 2008 21:53:16 +0100 (CET)
Subject: Re: MTD Partitions Permissions at Run Time.
From:	michael@cubic.org
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Hi.

> Ours is a embedded product with pre-defined flash partitions say "Boot"
> , "Kernel" , "Rootfs" & "ProductData".
> The kernel which is in the box (linux 2.6.14)has Boot partition as "RO"
> (Read Only). We have a requirement in the field that the boot code
> should be upgraded also.
> Is there any possibility of changing the partition permissions at
> run-time? If so how ?
> Our solution was to create a Kernel image Boot as RW, upgrade the kernel
> & reboot. Later change the Boot code.

It is. For the MeshCube, for each mtd partition we have added a proc entry
called /proc/sys/mtd/<mtdnum>/rw, with a value of 0 meanung read only and a
value of 1 meaning read-write. We used it to be able to disable the write
protection of the bootloader partition before an update of the bootloader.

I have attached the patch as an indication, of how it could be done. This patch
will not work with a 2.6 kernel anymore. It has been for the 2.4.27 kernel, that
has been used for the MeshCube.

It must be adopted to the 2.6 kernel and the /proc/sys stuff could be done in a
better way than we did it using the sysctl support.
You may take a look at some drivers like drivers/parport/procfs.c how it is done
for the parallel port.
The function register_sysctl_table is the key to it.

Regards,
Michael
