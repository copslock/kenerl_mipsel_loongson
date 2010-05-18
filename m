Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2010 06:42:21 +0200 (CEST)
Received: from kuber.nabble.com ([216.139.236.158]:37755 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491194Ab0EREmN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 May 2010 06:42:13 +0200
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1OEEd7-0005sZ-0p
        for linux-mips@linux-mips.org; Mon, 17 May 2010 21:42:09 -0700
Message-ID: <28591517.post@talk.nabble.com>
Date:   Mon, 17 May 2010 21:42:09 -0700 (PDT)
From:   soumyasr <Soumya.R@kpitcummins.com>
To:     linux-mips@linux-mips.org
Subject: Kernel not booting in QEMU_SYSTEM_MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: Soumya.R@kpitcummins.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Soumya.R@kpitcummins.com
Precedence: bulk
X-list: linux-mips


Hi all,

   I am new to qemu as well as mips..

1)   I Downloaded the qemu latest version from
http://wiki.qemu.org/download/qemu-0.12.3.tar.gz and installed it
succesfully....
After that i downladed mips-test-0.2.tar.gz from
http://wiki.qemu.org/download/mips-test-0.2.tar.gz and followed the below
commands to boot the kernel
and root file system ....

$ tar zxvf mips-test-0.2.tar.gz
$ cd mips-test
$ qemu-system-mips -M mips -kernel vmlinux-2.6.18-3-qemu -initrdinitrd.gz

When I run the above command

Qemu is launching and nothing else happen. I don't have any error, but I
don't have prompt... It seems that nothing is booting.. I tried the same
with ARM
instead if mips it boots the kernel, rfs and got the login prompt.. Since i
am not getting any errors i am able to figure out what's the problem is???


2)  I tried to build our own customized kernel using the buildroot by
executing the command :
    $ makemenuconfig

Here is the buildroot configuration  :
- Target Architecture => MIPSEL
- Target architecture variant =>mips I (generic)
- Target ABI => o32
- Target Option => default configuration
- Build option => default configuration
- Toolchain => Include target utils in cross toolchain  and build gdb server
for the target
- Package selection => default configuration
- Target file system => cpio (gzip compression)
- Kernel => Same version as linux header
- config file => .config
- kernel binary format => zImage

  when i run the command make to build the kernel i get the following error
message,

rm -rf /home/soumya/buildroot/output/build/buildroot-config
mkdir -p /home/soumya/buildroot/output/build
cp -dpRf package/config/buildroot-config
/home/soumya/buildroot/output/build/buildroot-config
/usr/bin/make -j1 -C /home/soumya/buildroot/output/toolchain/uClibc-0.9.31 \
                ARCH="mips" \
                PREFIX= \
                DEVEL_PREFIX=/ \
                RUNTIME_PREFIX=/ \
                HOSTCC="/usr/lib/ccache/gcc" \
                all
make[1]: Entering directory
`/home/soumya/buildroot/output/toolchain/uClibc-0.9.31'
  LD ld-uClibc-0.9.31.so
mipsel-unknown-linux-uclibc-gcc: libgcc.a: No such file or directory
make[1]: *** [lib/ld-uClibc.so] Error 1
make[1]: Leaving directory
`/home/soumya/buildroot/output/toolchain/uClibc-0.9.31'
make: *** [/home/soumya/buildroot/output/toolchain/uClibc-0.9.31/lib/libc.a]
Error 2

          Please anybody can help me out to resolve it if I am doing
anything wrong..

Best Regards,
Soumya


-- 
View this message in context: http://old.nabble.com/Kernel-not-booting-in-QEMU_SYSTEM_MIPS-tp28591517p28591517.html
Sent from the linux-mips main mailing list archive at Nabble.com.
