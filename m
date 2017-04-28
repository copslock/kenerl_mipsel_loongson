Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 09:39:53 +0200 (CEST)
Received: from mail-it0-x231.google.com ([IPv6:2607:f8b0:4001:c0b::231]:34465
        "EHLO mail-it0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdD1HjrUp1fb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 09:39:47 +0200
Received: by mail-it0-x231.google.com with SMTP id c123so7547232ith.1
        for <linux-mips@linux-mips.org>; Fri, 28 Apr 2017 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=DxsWmKesYJOGRi5MFKGds9FnwxKaq8LAZ+82lr3fSH8=;
        b=z9CxBic47VVv05FZjXGpxQtW39R7cWzy87Ob40kceQK/PafrwUISHohaplTD792MKD
         sGQyDXTdqnCVqPMeSgLm0ZIWxuRz3yzN6LuZ2qp3CQt+b9kWS30/qB4w1zVY8AAh4A3v
         zs+NCE++bmmwds0avdQEzduXm903cZPGg9CVcJbM133OyeeqbRH1K6PIE4HqyardSN/s
         PzB+c9V54z0qu3orjeFPTBpAnXQK0ao6bCBBBPdRjyRRWYiWoO6Xc63GwBwWGmj+t3sg
         xa4APpfPOL7JSt3b9Di3ktyKUal7HZ3NTwgCr1uor2rfKV+e6tQbuc+k8jttsfr9o8vE
         /a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=DxsWmKesYJOGRi5MFKGds9FnwxKaq8LAZ+82lr3fSH8=;
        b=IyyYBpbN2aqD2YGmSQ6/IjUSfNk/ZKl2Onu8/V7mj5GmgPam9d9Ka+E2kKPixt4QCZ
         GN9yQKRUCgovJ7IiOFfZnMliq6ZZVdRL/L21aXJ6FNq2BDEWV4QWZlJBtEw3KagNAzX2
         RgJ1sLF4JHD9BJMv4RSpipI0N/jNtkT7LUQ9Pjy+rINWXJFmfjcKOxCouvhVGtjfhYMe
         GsY5YXNO48eiNxJVbX8T/vRKCtj5i5P+YkaMXMEQ4DGR2IE5CcUAq7wTLxopXIZjitO0
         jsKGsa1o0XabFKZUhV7A6PjA//E9+LTEnpKjQ+5RyIgzUVaGC+IX0/+CnlyHznd3S+sP
         Dlvg==
X-Gm-Message-State: AN3rC/5De7JfHR4rOYH4dtGOMs/R6jNm3VIpjE6FTwutDLpnZiUZqRoi
        4UXHu0HUk3+rVQ==
X-Received: by 10.36.77.211 with SMTP id l202mr8171129itb.74.1493365181294;
        Fri, 28 Apr 2017 00:39:41 -0700 (PDT)
Received: from [192.168.43.158] ([172.56.7.83])
        by smtp.googlemail.com with ESMTPSA id k22sm871168iti.5.2017.04.28.00.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2017 00:39:40 -0700 (PDT)
To:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        ralf@linux-mips.org, paul.burton@imgtec.com
From:   Rob Landley <rob@landley.net>
Subject: Commit 10b6ea0959de broke qemu reboot/exit.
Message-ID: <bb1f5b37-26ca-10ff-c514-33899f21ea24@landley.net>
Date:   Fri, 28 Apr 2017 02:39:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

QEMU fails to reboot with current kernels, instead it hangs eating CPU:

  # exit
  reboot: Restarting system
  Reboot failed -- System halted

I bisected it to "MIPS: Malta: Use syscon-reboot driver to reboot"
commit 10b6ea0959de back in September. To reproduce, build a kernel with:

cat > mini.conf << EOF
# CONFIG_EMBEDDED is not set
CONFIG_EARLY_PRINTK=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_RD_GZIP=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_DEVTMPFS=y

CONFIG_MIPS_MALTA=y
CONFIG_CPU_MIPS32_R2=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_PM=y
CONFIG_PCNET32=y
CONFIG_BLK_DEV_PIIX=y
EOF

make ARCH=mips allnoconfig KCONFIG_ALLCONFIG=mini.conf
make ARCH=mips CROSS_COMPILE=blah-

And then boot qemu with a simple initramfs:

qemu-system-mips -M malta -nographic -no-reboot -kernel vmlinux \
  -append "console=ttyS0 panic=1" -initrd root.cpio.gz

And then try to shut it down. Before that commit it did, after it
doesn't. (I rebuilt qemu from git this morning and that didn't help,
same behavior as last year's build. New kernel doesn't know how to tell
it to shut down, old one did.)

Rob
