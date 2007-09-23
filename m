Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2007 01:26:54 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.184]:21741 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026269AbXIWA0q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 23 Sep 2007 01:26:46 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1217290fka
        for <linux-mips@linux-mips.org>; Sat, 22 Sep 2007 17:26:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=vHjnTsXEZ8gH2o97s6muLu52FAMtr4yh6I0ZJvY7cK0=;
        b=PFOog45CJQbRZSp6g3s8Y3aarmgju8PB/lynS0DBabYRaAb6JpCnOvtTrCn6rmPqcY7F2zpEaLGmLXp/PpVuAzEBeS2DhZdVHXu/6ohEHFnwI9weZhrg4qVxMJRD31BkpuCDL9bwXyav2v2bwI69cZ1GXBgEq4Xtc+nQLG5kytE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=tOmpHdLknGgWMcITkSG5l8y9Y5OouPjbbEqfMhzy4Sd5EaLuuKoGJz4pdG2kr9mXUrQmI3t+toFTwZBzXvhfD0ZK9vgtMFjvHQYK+9G2mgLAKQZ5NMz0VtG/wqimuQ+xckR3VYsQLkdllm3W2EFUQkybg9v3QMdbOJfwUoTvgzc=
Received: by 10.86.50.8 with SMTP id x8mr3483118fgx.1190507187316;
        Sat, 22 Sep 2007 17:26:27 -0700 (PDT)
Received: from ?192.168.1.2? ( [77.49.224.142])
        by mx.google.com with ESMTPS id 31sm5872703fkt.2007.09.22.17.26.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Sep 2007 17:26:25 -0700 (PDT)
Message-ID: <46F5B2C2.80102@freemail.gr>
Date:	Sun, 23 Sep 2007 03:26:42 +0300
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: gcc compilation errors(c++)
References: <46F5AAA5.9070000@freemail.gr>
In-Reply-To: <46F5AAA5.9070000@freemail.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From:	tasos <tasoss@gmail.com>
Return-Path: <tasoss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tasoss@gmail.com
Precedence: bulk
X-list: linux-mips

tasos wrote:
> Hello people and nice to meet you.
> I need your help please.
> I'm trying to build a new firmware for my router.
> http://broadband.eip.siemens.ch/public/GPL_source/OSS_Component.htm
> I have built binutils and now i have problems with gcc(specifically on 
> c++).
> At some point i get:
>
> checking float.h usability... no
> checking float.h presence... yes
> configure: WARNING: float.h: present but cannot be compiled
> configure: WARNING: float.h: check for missing prerequisite headers?
> configure: WARNING: float.h: proceeding with the preprocessor's result
> configure: WARNING:     ## ------------------------------------ ##
> configure: WARNING:     ## Report this to bug-autoconf@gnu.org. ##
> configure: WARNING:     ## ------------------------------------ ##
> checking for float.h... yes
> checking for endian.h... (cached) no
> checking for inttypes.h... (cached) no
> checking locale.h usability... no
> checking locale.h presence... no
> checking for locale.h... no
> checking for float.h... (cached) yes
> checking for stdint.h... (cached) no
> checking for main in -lm... configure: error: Link tests are not 
> allowed after GCC_NO_EXECUTABLES.
> make: *** [configure-target-libstdc++-v3] Error 1
>
> I'm using:
> binutils-2.15.94.0.2.2 and gcc-3.4.2
>
> bunzip2 -dc ../gcc-3.4.2-300-pr15526.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-600-gcc34-arm-ldm-peephole.patch.bz2 | patch -p1
> bunzip2 -dc  ../gcc-3.4.2-300-pr17541.patch.bz2 | patch -p1
> bunzip2 -dc  ../gcc-3.4.2-300-pr17976.patch.bz2 | patch -p1
> bunzip2 -dc  ../gcc-3.4.2-810-arm-bigendian-uclibc.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-700-pr15068-fix.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-402-mips-pr17770.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-300-libstdc++-pic.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-602-sdk-libstdc++-includes.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-200-uclibc-locale.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-400-mips-delay-slot.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-100-uclibc-conf.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-401-ppc-eabi-typo.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-900-install-info.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-601-gcc34-arm-ldm.patch.bz2 | patch -p1
> bunzip2 -dc ../gcc-3.4.2-800-arm-bigendian.patch.bz2 | patch -p1
>
> bunzip2 -dc 
> ../binutils-2.15.94.0.2.2-400-mips-ELF_MAXPAGESIZE-4K.patch.bz2 | 
> patch -p1
> bunzip2 -dc ../binutils-2.15.94.0.2.2-210-cflags.patch.bz2 | patch -p1
> bunzip2 -dc ../binutils-2.15.94.0.2.2-100-uclibc-conf.patch.bz2 | 
> patch -p1
> bunzip2 -dc 
> ../binutils-2.15.94.0.2.2-320_mips_xgot_multigot_workaround.patch.bz2 
> | patch -p1
> bunzip2 -dc 
> ../binutils-2.15.94.0.2.2-312_check_ldrunpath_length.patch.bz2 | patch 
> -p1
> bunzip2 -dc ../binutils-2.15.94.0.2.2-306_better_file_error.patch.bz2 
> | patch -p1
> bunzip2 -dc 
> ../binutils-2.15.94.0.2.2-702-binutils-skip-comments.patch.bz2 | patch 
> -p1
> bunzip2 -dc ../binutils-2.15.94.0.2.2-301_ld_makefile_patch.patch.bz2 
> | patch -p1
>
>
> ./configure --target=$TARGET --prefix=$PREFIX \
>  --enable-languages=c,c++ --without-headers \
>  --with-gnu-ld --with-gnu-as \
>  --disable-shared --disable-threads
>
> basically i'm using the tutorial at
> http://www.linux-mips.org/wiki/Toolchains
>
> They exist in 
> http://broadband.eip.siemens.ch/public/GPL_source/GPL_source_CL_SL_SLI_series_consumer_release.tar 
>
> so i don't find a reason not to use them.
> Can you please help me?I'm the first time i'm building a kernel for 
> another architecture.
> Thank you in advance!
>
>
Some more info.
This is where i get the error

echo "$as_me:$LINENO: checking for main in -lm" >&5
echo $ECHO_N "checking for main in -lm... $ECHO_C" >&6
if test "${ac_cv_lib_m_main+set}" = set; then
  echo $ECHO_N "(cached) $ECHO_C" >&6
else
  ac_check_lib_save_LIBS=$LIBS
LIBS="-lm  $LIBS"
if test x$gcc_no_link = xyes; then
  { { echo "$as_me:$LINENO: error:  Link tests are not allowed after 
GCC_NO_EXECUTABLES." >&5
echo "$as_me: error:  Link tests are not allowed after 
GCC_NO_EXECUTABLES." >&2;}
   { (exit 1); exit 1; }; }
fi
cat >conftest.$ac_ext <<_ACEOF
#line $LINENO "configure"
/* confdefs.h.  */
_ACEOF
cat confdefs.h >>conftest.$ac_ext
cat >>conftest.$ac_ext <<_ACEOF
/* end confdefs.h.  */


and more specifically *
*if test x$gcc_no_link = xyes; then


Thanks in advance!
