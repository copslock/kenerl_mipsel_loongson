Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 04:35:39 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51335 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816607Ab3FMCfe0grOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 04:35:34 +0200
Received: by mail-ie0-f170.google.com with SMTP id e11so9352152iej.15
        for <linux-mips@linux-mips.org>; Wed, 12 Jun 2013 19:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:subject:to:x-mailer:message-id:mime-version:content-type
         :x-gm-message-state;
        bh=RH5uQP8rqTGAhUMhnQGVpKmq5pv80sa9hP4McXeqoMk=;
        b=BMUH8sKtfnp4Af4MGVtnk2g3YyXGU1Z0Z/cMVE/nlKlaMce8XqLcqjnEkIHgzm8Wut
         l9O+EQgzGTHkoVGdl3MwxVJ5Daf4iV25bvir74ambD8YGbwAMcHEgKOuFt2+Q0Zz4YI0
         3XVo4ciTfsbXflB4pVev/caYCSf2+y7Hs4IBpbCxvhqAJZdLtmsUciKcPeVpaFpdBrYo
         b/axDVHWNLCDAKYngj7VgAC+RFeDqEkT16aZd67jEREarIc+0yfyfMI+QrjLp8yEHOa8
         lR3DhBlXqi6nRQIckc/HJ4FPPUjJKFc6AzGYEYIyZM91r4uho8Drpq/7E9y15H2XrD9I
         q3dg==
X-Received: by 10.43.133.134 with SMTP id hy6mr8918263icc.57.1371090927931;
        Wed, 12 Jun 2013 19:35:27 -0700 (PDT)
Received: from driftwood (c-50-148-218-118.hsd1.mn.comcast.net. [50.148.218.118])
        by mx.google.com with ESMTPSA id y11sm21505124igy.10.2013.06.12.19.35.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 19:35:27 -0700 (PDT)
Date:   Wed, 12 Jun 2013 21:35:16 -0500
From:   Rob Landley <rob@landley.net>
Subject: Commit f9afbd45b0d0 broke mips r4k.
To:     linux-kernel@vger.kernel.org, sanjayl@kymasys.com,
        kvm@vger.kernel.org, linux-mips@linux-mips.org, ralf@linux-mips.org
X-Mailer: Balsa 2.4.11
Message-Id: <1371090916.2776.104@driftwood>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-DO9XbtZD2xmClfVVzSRk"
X-Gm-Message-State: ALoCoQl/z18ojQDPwNt6ZAURz7cc/E6K0NH4jBED7OLrXii6ZXZtLMMnP1zzIyK/RecsRR8/MD1a
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36845
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

--=-DO9XbtZD2xmClfVVzSRk
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My aboriginal linux project builds tiny linux systems to run under =20
qemu, producing as close to the same system as possible across a bunch =20
of different architectures. The above change broke the mips r4k build =20
I've been running under qemu.

Here's a toolchain and reproduction sequence:

   wget http://landley.net/aboriginal/bin/cross-compiler-mips.tar.bz2
   tar xvjf cross-compiler-mips.tar.bz2
   export PATH=3D$PWD/cross-compiler-mips/bin:$PATH
   make ARCH=3Dmips allnoconfig KCONFIG_ALLCONFIG=3Dminiconfig.mips
   make CROSS_COMPILE=3Dmips- ARCH=3Dmips

(The file miniconfig.mips is attached.)

It ends:

   CC      init/version.o
   LD      init/built-in.o
arch/mips/built-in.o: In function `local_r4k_flush_cache_page':
c-r4k.c:(.text+0xe278): undefined reference to `kvm_local_flush_tlb_all'
c-r4k.c:(.text+0xe278): relocation truncated to fit: R_MIPS_26 against =20
`kvm_local_flush_tlb_all'
arch/mips/built-in.o: In function `local_flush_tlb_range':
(.text+0xe938): undefined reference to `kvm_local_flush_tlb_all'
arch/mips/built-in.o: In function `local_flush_tlb_range':
(.text+0xe938): relocation truncated to fit: R_MIPS_26 against =20
`kvm_local_flush_tlb_all'
arch/mips/built-in.o: In function `local_flush_tlb_mm':
(.text+0xed38): undefined reference to `kvm_local_flush_tlb_all'
arch/mips/built-in.o: In function `local_flush_tlb_mm':
(.text+0xed38): relocation truncated to fit: R_MIPS_26 against =20
`kvm_local_flush_tlb_all'
kernel/built-in.o: In function `__schedule':
core.c:(.sched.text+0x16a0): undefined reference to =20
`kvm_local_flush_tlb_all'
core.c:(.sched.text+0x16a0): relocation truncated to fit: R_MIPS_26 =20
against `kvm_local_flush_tlb_all'
mm/built-in.o: In function `use_mm':
(.text+0x182c8): undefined reference to `kvm_local_flush_tlb_all'
mm/built-in.o: In function `use_mm':
(.text+0x182c8): relocation truncated to fit: R_MIPS_26 against =20
`kvm_local_flush_tlb_all'
fs/built-in.o:(.text+0x7b50): more undefined references to =20
`kvm_local_flush_tlb_all' follow
fs/built-in.o: In function `flush_old_exec':
(.text+0x7b50): relocation truncated to fit: R_MIPS_26 against =20
`kvm_local_flush_tlb_all'

Revert the above commit and it builds to the end.

Rob=

--=-DO9XbtZD2xmClfVVzSRk
Content-Type: text/plain; charset=us-ascii; name=miniconfig.mips
Content-Disposition: attachment; filename=miniconfig.mips
Content-Transfer-Encoding: quoted-printable

CONFIG_EXPERIMENTAL=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_PCI=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
CONFIG_MAGIC_SYSRQ=3Dy

CONFIG_BLK_DEV=3Dy
CONFIG_BLK_DEV_LOOP=3Dy

CONFIG_IDE=3Dy
CONFIG_IDE_GD=3Dy
CONFIG_IDE_GD_ATA=3Dy
CONFIG_BLK_DEV_IDECD=3Dy

CONFIG_SCSI=3Dy
CONFIG_BLK_DEV_SD=3Dy
CONFIG_BLK_DEV_SR=3Dy
CONFIG_SCSI_LOWLEVEL=3Dy

CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy

CONFIG_NETDEVICES=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_NET_PCI=3Dy
CONFIG_8139CP=3Dy

CONFIG_HW_RANDOM=3Dy

CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_DEV=3Dy

CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_USE_FOR_EXT23=3Dy
CONFIG_TMPFS=3Dy
CONFIG_MISC_FILESYSTEMS=3Dy
CONFIG_SQUASHFS=3Dy
CONFIG_SQUASHFS_ZLIB=3Dy
CONFIG_DEVTMPFS=3Dy

CONFIG_VIRTUALIZATION=3Dy
CONFIG_VIRTIO_PCI=3Dy
CONFIG_VIRTIO_NET=3Dy
CONFIG_NET_9P=3Dy
CONFIG_NET_9P_VIRTIO=3Dy
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_9P_FS=3Dy
CONFIG_9P_FS_POSIX_ACL=3Dy

# More random (inexplicable) guard symbols added in 3.2.  TODO: write
# miniconfig expander that automatically sets guard symbols when setting a
# dependent symbol.

CONFIG_ETHERNET=3Dy
CONFIG_NET_VENDOR_INTEL=3Dy
CONFIG_NET_VENDOR_REALTEK=3Dy
CONFIG_NET_VENDOR_AMD=3Dy
CONFIG_NET_VENDOR_NATSEMI=3Dy
CONFIG_NET_VENDOR_8390=3Dy

CONFIG_MIPS_MALTA=3Dy
CONFIG_CPU_MIPS32_R2=3Dy
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
#CONFIG_PM=3Dy
CONFIG_PCNET32=3Dy
CONFIG_BLK_DEV_PIIX=3Dy

=

--=-DO9XbtZD2xmClfVVzSRk--
