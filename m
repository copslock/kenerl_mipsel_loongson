Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jul 2017 06:45:39 +0200 (CEST)
Received: from mail-oi0-x22a.google.com ([IPv6:2607:f8b0:4003:c06::22a]:33570
        "EHLO mail-oi0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990889AbdG3EpcqGghu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 30 Jul 2017 06:45:32 +0200
Received: by mail-oi0-x22a.google.com with SMTP id a9so160894147oih.0
        for <linux-mips@linux-mips.org>; Sat, 29 Jul 2017 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IK7XYzf+csD1pszRcxIpd8CB94Gg/OKiLkBcqdQ3MNk=;
        b=VJy1gmPW2QUyoznE26ufLI7lxxm2X2xyg9L3t77ifS3DHFa/MpaYozZ83/Z9qsiuN6
         3UTjH4nXbNxDp2oCyUnWFxw1JeYM4iDh8baCYPQSNZ51IM78byYvPgRpGYDIJGstFgsi
         n7tt2bfWU4PA9MKA0jRvrGeMvDNYLGC1BiJ2tjx671egsFALkd8PVZ1gHW4jRwIQ2kSO
         izHPHLm5QocFLGBy4VOrLiOitCPgoYF2PVnTriN185XeIqrAA+qVh6sBijesMdfGFnkY
         /4TcdyxHZhT6xAtLLxLHH5b/pM9kWUMst1QQ9CqXT/X2IfmSbQ8TY6S3RQyhLL/OqM0y
         ZnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IK7XYzf+csD1pszRcxIpd8CB94Gg/OKiLkBcqdQ3MNk=;
        b=iOAWEmS2kOGFI0xXA7m+b/goMjy73RKXVU9FPJOdVR2GGw0eS9muYCJkB1m9zhkbdM
         TNoHVMl2cbHOuxdQqqVZBwsWgsH01aNOGjHmkSDd9ylWwvxvmj5W7hGQww5jGeQJHOXo
         c3Cl55bvsZxyYT22knBYaZ4X0YJvYBrIK0/1jMzteZhMZKkiHbcNztGR23N5KSs/Gp5A
         c8kQV9h70UMmNlTnDR9ft3tXKReVkGyUGGgFk6N/EJc8sBemgH5txe1gZtZ8nfSBGCxE
         Tv6kgUIakY42OVzqqOgOAFb5Nuhy8Esz04ShjjmDx4/UwqcGTgizbtmXxyiKRkwDCSaq
         /o7Q==
X-Gm-Message-State: AIVw110rdA5vVntaZZlU9DX7Cno5vY6VrCQAee54JV2QEuSQWK0zuB0J
        9HmmK1DEdDbKOvrz/2eueG1pMXhVdpa6
X-Received: by 10.202.75.68 with SMTP id y65mr10737059oia.97.1501389926365;
 Sat, 29 Jul 2017 21:45:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.172.6 with HTTP; Sat, 29 Jul 2017 21:45:26 -0700 (PDT)
From:   Colin Williams <colin.williams.seattle@gmail.com>
Date:   Sat, 29 Jul 2017 21:45:26 -0700
Message-ID: <CAPXXXSAmkdF3XnZGCvkH3AEnp4h4KC3u4ooyhX9GXZXh8zoQNQ@mail.gmail.com>
Subject: =?UTF-8?Q?rying_to_build_for_my_actiontec_wcb3000n_=2F_mips=2Dlinu?=
        =?UTF-8?Q?x=2Dgcc=3A_error=3A_unrecognized_argument_in_option_=E2=80=98=2Dmarch=3D5281?=
        =?UTF-8?Q?=E2=80=99?=
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <colin.williams.seattle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin.williams.seattle@gmail.com
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

Hi,

I'm trying to run the do_act_build script for my actiontec wcb3000n
router. The source tree and scripts I'm using are located here:
http://opensource.actiontec.com/sourcecode/wcb3000x/wcb3000n-fw-ncs-0.16.4.3-readme

I'm getting an error from mips-linux-gcc using the following version:

 mips-linux-gcc -v
Using built-in specs.
COLLECT_GCC=mips-linux-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/mips-linux-gnu/6/lto-wrapper
Target: mips-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian
6.3.0-18' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-6 --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libitm --disable-libsanitizer --disable-libquadmath
--enable-plugin --enable-default-pie --with-system-zlib
--disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-mips-cross/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-mips-cross
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-mips-cross
--with-arch-directory=mips
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libgcj
--enable-multiarch --enable-multilib --with-arch-32=mips32r2
--with-fp-32=xx --with-lxc1-sxc1=no --enable-targets=all
--with-arch-64=mips64r2 --enable-checking=release
--build=x86_64-linux-gnu --host=x86_64-linux-gnu
--target=mips-linux-gnu --program-prefix=mips-linux-gnu-
--includedir=/usr/mips-linux-gnu/include
Thread model: posix
gcc version 6.3.0 20170516 (Debian 6.3.0-18)

mips-linux-gcc: note: valid arguments to ‘-march=’ are: 10000 1004kc
1004kf 1004kf1_1 1004kf2_1 10k 12000 12k 14000 14k 16000 16k 2000 20kc
24kc 24kec 24kef 24kef1_1 24kef2_1 24kefx 24kex 24kf 24kf1_1 24kf2_1
24kfx 24kx 2k 3000 34kc 34kf 34kf1_1 34kf2_1 34kfx 34kn 34kx 3900 3k
4000 4100 4111 4120 4130 4300 4400 4600 4650 4700 4k 4kc 4kec 4kem
4kep 4km 4kp 4ksc 4ksd 5000 5400 5500 5900 5k 5kc 5kf 6000 6k 7000
74kc 74kf 74kf1_1 74kf2_1 74kf3_2 74kfx 74kx 7k 8000 8k 9000 9k
from-abi i6400 interaptiv loongson2e loongson2f loongson3a m14k m14kc
m14ke m14kec m4k m5100 m5101 mips1 mips2 mips3 mips32 mips32r2
mips32r3 mips32r5 mips32r6 mips4 mips64 mips64r2 mips64r3 mips64r5
mips64r6 native octeon octeon+ octeon2 octeon3 orion p5600 r10000
r1004kc r1004kf r1004kf1_1 r1004kf2_1 r10k r12000 r12k r14000 r14k
r16000 r16k r2000 r20kc r24kc r24kec r24kef r24kef1_1 r24kef2_1
r24kefx r24kex r24kf r24kf1_1 r24kf2_1 r24kfx r24kx r2k r3000 r34kc
r34kf r34kf1_1 r34kf2_1 r34kfx r34kn r34kx r3900 r3k r4000 r4100 r4111
r4120 r4130 r4300 r4400 r4600 r4650 r4700 r4k r4kc r4kec r4kem r4kep
r4km r4kp r4ksc r4ksd r5000 r5400 r5500 r5900 r5k r5kc r5kf r6000 r6k
r7000 r74kc r74kf r74kf1_1 r74kf2_1 r74kf3_2 r74kfx r74kx r7k r8000
r8k r9000 r9k rm7000 rm7k rm9000 rm9k sb1 sb1a sr71000 sr71k vr4100
vr4111 vr4120 vr4130 vr4300 vr5000 vr5400 vr5500 vr5k xlp xlr
make[2]: *** [Output/head.o] Error 1
make[1]: *** [all] Error 2
Makefile:166: recipe for target 'bootcode' failed
make: *** [bootcode] Error 2

It looks like it's missing the architecture specified in the build
script. Why is the architecture missing and is it unavailable? Has it
been renamed? What should I do to build for my device? Anybody know
which CPU / architecture the wcb3000n is using?
