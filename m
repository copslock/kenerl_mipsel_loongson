Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 10:37:46 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.207]:17210 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225271AbVCCKha>;
	Thu, 3 Mar 2005 10:37:30 +0000
Received: by wproxy.gmail.com with SMTP id 37so380370wra
        for <linux-mips@linux-mips.org>; Thu, 03 Mar 2005 02:37:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=sZxwz3zFfe9CWtjKdwvAbX4IB1X9pUrstvq9+J15l6lgApidQ/Z/ZiyhmbfZb8QXH29s9BUtld60uv0gJyl1uNyfDDOt3nD6sZ1yKNUHyTEuClbAtBGr4oJNWFaCpK0mRRN6FxDjEMG817Xv3sZLe69PXvETB3zr6TMWx4fm1A4=
Received: by 10.54.65.4 with SMTP id n4mr22347wra;
        Thu, 03 Mar 2005 02:37:24 -0800 (PST)
Received: by 10.54.25.31 with HTTP; Thu, 3 Mar 2005 02:37:22 -0800 (PST)
Message-ID: <ace3f33d050303023754d9217f@mail.gmail.com>
Date:	Thu, 3 Mar 2005 16:07:22 +0530
From:	srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
Reply-To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
To:	linux-mips@linux-mips.org
Subject: HOWTO load and run the kernel image using redboot?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <srinivas.vutukuri@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srinivas.vutukuri@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
          I have compiled the mips kernel image, and got vmlinux. And
how can load image into the ram run using redboot, my board is running
with the redboot.
I followed the steps, after i got the vmlinux

1. mips-linux-objcopy -O binary -g vmlinux vmlinux.bin
2. gzip vmlinux.bin
3. mips-linux-objdump -f vmlinux | grep start
    shows the entry point, which is say ENTRY
4. mips-linux-nm vmlinux | grep _ftext
    which is say MEMADDR.
5. Load the image into memory
    At a RedBoot prompt, type:
    load -r -b %{FREEMEMLO} vmlinux.bin.gz
6. Copy the compressed image from memory to flash
    fis create -e ENTRY -r MEMADDR vmlinux.bin.gz
and  once i do  go/exec, garbage is showing at the Redboot> prompt...

Can help the way of loading the kernel image using redboot and boot it.

Best Regards,
srinivas.
