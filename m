Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2017 10:35:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26930 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991073AbdGaIfQH3moP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2017 10:35:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E48D6607AF046;
        Mon, 31 Jul 2017 09:35:06 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 31 Jul
 2017 09:35:09 +0100
Subject: =?UTF-8?Q?Re:_rying_to_build_for_my_actiontec_wcb3000n_/_mips-linux?=
 =?UTF-8?Q?-gcc:_error:_unrecognized_argument_in_option_=e2=80=98-march=3d52?=
 =?UTF-8?B?ODHigJk=?=
To:     Colin Williams <colin.williams.seattle@gmail.com>,
        <linux-mips@linux-mips.org>
References: <CAPXXXSAmkdF3XnZGCvkH3AEnp4h4KC3u4ooyhX9GXZXh8zoQNQ@mail.gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <d90545e9-1dd1-b75d-cd33-0fa64314d397@imgtec.com>
Date:   Mon, 31 Jul 2017 10:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPXXXSAmkdF3XnZGCvkH3AEnp4h4KC3u4ooyhX9GXZXh8zoQNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Colin,

On 30.07.2017 06:45, Colin Williams wrote:
> Hi,
> 
> I'm trying to run the do_act_build script for my actiontec wcb3000n
> router. The source tree and scripts I'm using are located here:
> http://opensource.actiontec.com/sourcecode/wcb3000x/wcb3000n-fw-ncs-0.16.4.3-readme
> 
> I'm getting an error from mips-linux-gcc using the following version:
> 
>   mips-linux-gcc -v
> Using built-in specs.
> COLLECT_GCC=mips-linux-gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/mips-linux-gnu/6/lto-wrapper
> Target: mips-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion='Debian
> 6.3.0-18' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs
> --enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
> --prefix=/usr --program-suffix=-6 --enable-shared
> --enable-linker-build-id --libexecdir=/usr/lib
> --without-included-gettext --enable-threads=posix --libdir=/usr/lib
> --enable-nls --with-sysroot=/ --enable-clocale=gnu
> --enable-libstdcxx-debug --enable-libstdcxx-time=yes
> --with-default-libstdcxx-abi=new --enable-gnu-unique-object
> --disable-libitm --disable-libsanitizer --disable-libquadmath
> --enable-plugin --enable-default-pie --with-system-zlib
> --disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo
> --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-mips-cross/jre
> --enable-java-home
> --with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-mips-cross
> --with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-mips-cross
> --with-arch-directory=mips
> --with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libgcj
> --enable-multiarch --enable-multilib --with-arch-32=mips32r2
> --with-fp-32=xx --with-lxc1-sxc1=no --enable-targets=all
> --with-arch-64=mips64r2 --enable-checking=release
> --build=x86_64-linux-gnu --host=x86_64-linux-gnu
> --target=mips-linux-gnu --program-prefix=mips-linux-gnu-
> --includedir=/usr/mips-linux-gnu/include
> Thread model: posix
> gcc version 6.3.0 20170516 (Debian 6.3.0-18)
> 
> mips-linux-gcc: note: valid arguments to ‘-march=’ are: 10000 1004kc
> 1004kf 1004kf1_1 1004kf2_1 10k 12000 12k 14000 14k 16000 16k 2000 20kc
> 24kc 24kec 24kef 24kef1_1 24kef2_1 24kefx 24kex 24kf 24kf1_1 24kf2_1
> 24kfx 24kx 2k 3000 34kc 34kf 34kf1_1 34kf2_1 34kfx 34kn 34kx 3900 3k
> 4000 4100 4111 4120 4130 4300 4400 4600 4650 4700 4k 4kc 4kec 4kem
> 4kep 4km 4kp 4ksc 4ksd 5000 5400 5500 5900 5k 5kc 5kf 6000 6k 7000
> 74kc 74kf 74kf1_1 74kf2_1 74kf3_2 74kfx 74kx 7k 8000 8k 9000 9k
> from-abi i6400 interaptiv loongson2e loongson2f loongson3a m14k m14kc
> m14ke m14kec m4k m5100 m5101 mips1 mips2 mips3 mips32 mips32r2
> mips32r3 mips32r5 mips32r6 mips4 mips64 mips64r2 mips64r3 mips64r5
> mips64r6 native octeon octeon+ octeon2 octeon3 orion p5600 r10000
> r1004kc r1004kf r1004kf1_1 r1004kf2_1 r10k r12000 r12k r14000 r14k
> r16000 r16k r2000 r20kc r24kc r24kec r24kef r24kef1_1 r24kef2_1
> r24kefx r24kex r24kf r24kf1_1 r24kf2_1 r24kfx r24kx r2k r3000 r34kc
> r34kf r34kf1_1 r34kf2_1 r34kfx r34kn r34kx r3900 r3k r4000 r4100 r4111
> r4120 r4130 r4300 r4400 r4600 r4650 r4700 r4k r4kc r4kec r4kem r4kep
> r4km r4kp r4ksc r4ksd r5000 r5400 r5500 r5900 r5k r5kc r5kf r6000 r6k
> r7000 r74kc r74kf r74kf1_1 r74kf2_1 r74kf3_2 r74kfx r74kx r7k r8000
> r8k r9000 r9k rm7000 rm7k rm9000 rm9k sb1 sb1a sr71000 sr71k vr4100
> vr4111 vr4120 vr4130 vr4300 vr5000 vr5400 vr5500 vr5k xlp xlr
> make[2]: *** [Output/head.o] Error 1
> make[1]: *** [all] Error 2
> Makefile:166: recipe for target 'bootcode' failed
> make: *** [bootcode] Error 2
> 
> It looks like it's missing the architecture specified in the build
> script. Why is the architecture missing and is it unavailable? Has it
> been renamed? What should I do to build for my device? Anybody know
> which CPU / architecture the wcb3000n is using?
> 

The source package for your device has a toolchain in the tar file and 
that toolchain should be used. There is probably some error in the 
provided buildsystem that results in it picking up your ubuntu-shipped 
mips toolchain instead of the packaged one.


(the toolchain in WECB-NCS-GPL/rtl819x/toolchain/.../ has support for 
-march=5281 flag.


If you don't want to spend too much time analysing the provided build 
scripts it may be fastest to set up a clean ubuntu environment using 
Docker or a VM and run a build there making sure that you don't have 
anything other than that the instructions mention installed.
Since the instructions in readme suggest they have been tested on Ubuntu 
12.04 (which is very old from today's perspective) I suggest you stick 
to that one as well - as the build might also fail due to eg. newer 
versions of various host tools ... I've seen that happen with various 
custom build systems quite often.

Marcin
