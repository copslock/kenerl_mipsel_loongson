Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 11:25:56 +0100 (BST)
Received: from web53509.mail.yahoo.com ([206.190.37.70]:7800 "HELO
	web53509.mail.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133503AbWC1KZk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 11:25:40 +0100
Received: (qmail 25989 invoked by uid 60001); 28 Mar 2006 10:35:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pabLsVQJTI865QrmFnvA0w34CTs9U0cm5eXHWhPnOfFp4mT7mi6z7rI8/oWTx9Gk9MERDCJaF1h/U6dGFaIQwThXnpZJHh2OFqIX7/kZGROewoDe6Q25jp7BBPESalW0KWomOqUs7L6Hf3jK4hhYglum5PcM/pqbNa9YG3eHoZU=  ;
Message-ID: <20060328103557.25987.qmail@web53509.mail.yahoo.com>
Received: from [203.145.155.11] by web53509.mail.yahoo.com via HTTP; Tue, 28 Mar 2006 02:35:57 PST
Date:	Tue, 28 Mar 2006 02:35:57 -0800 (PST)
From:	Krishna <dhunjukrishna@yahoo.com>
Reply-To: dhunjukrishna@gmail.com
Subject: building cross compiler for compiling kernel 2.6.14 for BCM1480
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060324224005.GA4145@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1406943364-1143542157=:21489"
Content-Transfer-Encoding: 8bit
Return-Path: <dhunjukrishna@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhunjukrishna@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1406943364-1143542157=:21489
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  I went to the site (http://www.linux-mips.org/wiki/Toolchains > Pre-built/Build Kits ).. Downloaded the following tools 
  -binutils-2.16.1
  -gcc-4.1.0
  -gdb-6.4
  And followed the installation instruction as described there. First installed binutils successfully. But got follwing error while doing make -j2 in the process of installing gcc-4.1.c:
  
checking for --enable-version-specific-runtime-libs... no
checking whether to enable maintainer-specific portions of Makefiles... no
checking for mipsel-unknown-linux-gnu-gcc... 
  /home/ssf/bdcom/tools-cross-toolchains/build-gcc-bootstrap/./gcc/xgcc 
  -B/home/ssf/bdcom/tools-cross-toolchains/build-gcc-bootstrap/./gcc/ 
  -B/home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/bin/ 
  -B/home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/lib/ -isystem 
  /home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/include -isystem 
  /home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/sys-include
checking for C compiler default output file name... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether byte ordering is bigendian... no
checking for a BSD-compatible install... /usr/bin/install -c
checking for sys/file.h... no
checking for sys/param.h... no
checking for limits.h... yes
checking for stdlib.h... no
checking for malloc.h... no
checking for string.h... no
checking for unistd.h... no
checking for strings.h... no
checking for sys/time.h... no
checking for time.h... no
checking for sys/resource.h... no
checking for sys/stat.h... no
checking for sys/mman.h... no
checking for fcntl.h... no
checking for alloca.h... no
checking for sys/pstat.h... no
checking for sys/sysmp.h... no
checking for sys/sysinfo.h... no
checking for machine/hal_sysinfo.h... no
checking for sys/table.h... no
checking for sys/sysctl.h... no
checking for sys/systemcfg.h... no
checking for stdint.h... no
checking for stdio_ext.h... no
checking for sys/wait.h that is POSIX.1 compatible... no
checking whether time.h and sys/time.h may both be included... no
checking whether errno must be declared... yes
checking for egrep... grep -E
checking for ANSI C header files... no
checking for sys/types.h... no
checking for sys/stat.h... (cached) no
checking for stdlib.h... (cached) no
checking for string.h... (cached) no
checking for memory.h... no
checking for strings.h... (cached) no
checking for inttypes.h... no
checking for stdint.h... (cached) no
checking for unistd.h... (cached) no
checking for int... no
checking size of int... 0
checking for uintptr_t... no
checking for a 64-bit type... unsigned long long
checking for pid_t... no
checking for library containing strerror... make[1]: Leaving directory 
  `/home/ssf/bdcom/tools-cross-toolchains/build-gcc-b
configure:error: C compiler cannot create executables
See 'config.log' for more details.
make[1]: *** [configure-target-libmudflap] Error 1
make[1]: *** Waiting for unfinished jobs....
configure: error: Link tests are not allowed after GCC_NO_EXECUTABLES.
make[1]: *** [configure-target-libiberty] Error 1
make: *** [all] Error 2
  Here is the config.log file:
  configure:600: checking host system type
configure:621: checking target system type
configure:639: checking build system type
configure:694: checking for a BSD compatible install
configure:747: checking whether ln works
configure:771: checking whether ln -s works
configure:1825: checking for gcc
configure:1938: checking whether the C compiler (gcc  ) works
configure:1954: gcc -o conftest    conftest.c  1>&5
configure:1980: checking whether the C compiler (gcc  ) is a cross-compiler
configure:1985: checking whether we are using GNU C
configure:2013: checking whether gcc accepts -g
configure:2080: checking for gnatbind
configure:2145: checking whether compiler driver understands Ada
configure:2177: checking how to compare bootstrapped objects
configure:2275: checking for correct version of gmp.h
configure:2288: gcc -c -g -O2   conftest.c 1>&5
configure:2301: checking for MPFR
configure:2314: gcc -o conftest -g -O2    conftest.c  -lmpfr -lgmp 1>&5
configure:3313: checking for bison
configure:3353: checking for bison
configure:3392: checking for gm4
configure:3431: checking for flex
configure:3471: checking for flex
configure:3510: checking for makeinfo
configure:3563: checking for expect
configure:3604: checking for runtest
configure:3652: checking for i686-pc-linux-gnu-ar
configure:3727: checking for i686-pc-linux-gnu-as
configure:3802: checking for i686-pc-linux-gnu-dlltool
configure:3833: checking for dlltool
configure:3877: checking for i686-pc-linux-gnu-ld
configure:3952: checking for i686-pc-linux-gnu-lipo
configure:3983: checking for lipo
configure:4027: checking for i686-pc-linux-gnu-nm
configure:4102: checking for i686-pc-linux-gnu-ranlib
configure:4172: checking for i686-pc-linux-gnu-strip
configure:4242: checking for i686-pc-linux-gnu-windres
configure:4273: checking for windres
configure:4317: checking for i686-pc-linux-gnu-objcopy
configure:4392: checking for i686-pc-linux-gnu-objdump
configure:4474: checking for mipsel-unknown-linux-gnu-ar
configure:4549: checking for mipsel-unknown-linux-gnu-as
configure:4624: checking for mipsel-unknown-linux-gnu-cc
configure:4624: checking for mipsel-unknown-linux-gnu-gcc
configure:4699: checking for mipsel-unknown-linux-gnu-c++
configure:4699: checking for mipsel-unknown-linux-gnu-g++
configure:4699: checking for mipsel-unknown-linux-gnu-cxx
configure:4699: checking for mipsel-unknown-linux-gnu-gxx
configure:4774: checking for mipsel-unknown-linux-gnu-dlltool
configure:4849: checking for mipsel-unknown-linux-gnu-gcc
configure:4919: checking for mipsel-unknown-linux-gnu-gcj
configure:4994: checking for mipsel-unknown-linux-gnu-gfortran
configure:5069: checking for mipsel-unknown-linux-gnu-ld
configure:5144: checking for mipsel-unknown-linux-gnu-lipo
configure:5219: checking for mipsel-unknown-linux-gnu-nm
configure:5294: checking for mipsel-unknown-linux-gnu-objdump
configure:5369: checking for mipsel-unknown-linux-gnu-ranlib
configure:5439: checking for mipsel-unknown-linux-gnu-strip
configure:5514: checking for mipsel-unknown-linux-gnu-windres
configure:5588: checking where to find the target ar
configure:5613: checking where to find the target as
configure:5638: checking where to find the target cc
configure:5663: checking where to find the target c++
configure:5691: checking where to find the target c++ for libstdc++
configure:5719: checking where to find the target dlltool
configure:5744: checking where to find the target gcc
configure:5769: checking where to find the target gcj
configure:5797: checking where to find the target gfortran
configure:5825: checking where to find the target ld
configure:5850: checking where to find the target lipo
configure:5865: checking where to find the target nm
configure:5890: checking where to find the target objdump
configure:5915: checking where to find the target ranlib
configure:5940: checking where to find the target strip
configure:5965: checking where to find the target windres
configure:6018: checking whether to enable maintainer-specific portions of Makefiles
configure:6065: checking if symbolic links between directories work
  
Then i searched through the net for the procedure and found one 
like this:
   ../configure   --with-system-zlib --libexecdir=/usr/lib
--prefix=/usr/local/gcc-4.0.2 --enable-shared --with-arch=sb1
--with-tune=sb1 --without-included-gettext --enable-nls
--program-suffix=-4.0.2 --enable-__cxa_atexit
--enable-libstdcxx-allocator=mt --with-target=mips64-linux
  I tried with this also but did not work. Again big list of errors. Then searched for more and it seems that i need to have glibc. So i downleded glibc-2.16.1 also.
Now don't know where to start. Let me make u clear that I am new to this. Getting hard to figure out problems. can anyone please tell me the 
  exact procedure or let me know where i can find the correct reference for the tools needed doing all the stuffs from making a cross compiler for sb1 (BCM1480) and then cross compiling kernel 2.6.14.
   
   
  Thanks and Regards,
  Krishna
  

There is a lot of information in the wiki http://www.linux-mips.org/ and
I would like to encourage people to contribute to it. Editing a wiki
page _once_ is more productive than answering the same question again
and again ... In particular I also want to encourage the mere mortals
to contribute to the wikis.

Ralf



			
---------------------------------
Yahoo! Messenger with Voice. PC-to-Phone calls for ridiculously low rates.
--0-1406943364-1143542157=:21489
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <div>I went to the site (<A href="http://www.linux-mips.org/wiki/Toolchains">http://www.linux-mips.org/wiki/Toolchains</A> &gt; Pre-built/Build Kits ).. Downloaded the following tools </div>  <div>-binutils-2.16.1</div>  <div>-gcc-4.1.0</div>  <div>-gdb-6.4</div>  <div>And followed the installation instruction as described there. First installed binutils successfully. But got follwing error while doing make -j2 in the process of installing gcc-4.1.c:</div>  <div><BR>checking for --enable-version-specific-runtime-libs... no<BR>checking whether to enable maintainer-specific portions of Makefiles... no<BR>checking for mipsel-unknown-linux-gnu-gcc... </div>  <div>/home/ssf/bdcom/tools-cross-toolchains/build-gcc-bootstrap/./gcc/xgcc </div>  <div>-B/home/ssf/bdcom/tools-cross-toolchains/build-gcc-bootstrap/./gcc/ </div> 
 <div>-B/home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/bin/ </div>  <div>-B/home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/lib/ -isystem </div>  <div>/home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/include -isystem </div>  <div>/home/ssf/bdcom/cross-compilers/mips-linux/mipsel-unknown-linux-gnu/sys-include<BR>checking for C compiler default output file name... yes<BR>checking for an ANSI C-conforming const... yes<BR>checking for inline... inline<BR>checking whether byte ordering is bigendian... no<BR>checking for a BSD-compatible install... /usr/bin/install -c<BR>checking for sys/file.h... no<BR>checking for sys/param.h... no<BR>checking for limits.h... yes<BR>checking for stdlib.h... no<BR>checking for malloc.h... no<BR>checking for string.h... no<BR>checking for unistd.h... no<BR>checking for strings.h... no<BR>checking for sys/time.h... no<BR>checking for time.h... no<BR>checking for sys/resource.h... no<BR>checking for
 sys/stat.h... no<BR>checking for sys/mman.h... no<BR>checking for fcntl.h... no<BR>checking for alloca.h... no<BR>checking for sys/pstat.h... no<BR>checking for sys/sysmp.h... no<BR>checking for sys/sysinfo.h... no<BR>checking for machine/hal_sysinfo.h... no<BR>checking for sys/table.h... no<BR>checking for sys/sysctl.h... no<BR>checking for sys/systemcfg.h... no<BR>checking for stdint.h... no<BR>checking for stdio_ext.h... no<BR>checking for sys/wait.h that is POSIX.1 compatible... no<BR>checking whether time.h and sys/time.h may both be included... no<BR>checking whether errno must be declared... yes<BR>checking for egrep... grep -E<BR>checking for ANSI C header files... no<BR>checking for sys/types.h... no<BR>checking for sys/stat.h... (cached) no<BR>checking for stdlib.h... (cached) no<BR>checking for string.h... (cached) no<BR>checking for memory.h... no<BR>checking for strings.h... (cached) no<BR>checking for inttypes.h... no<BR>checking for stdint.h... (cached) no<BR>checking
 for unistd.h... (cached) no<BR>checking for int... no<BR>checking size of int... 0<BR>checking for uintptr_t... no<BR>checking for a 64-bit type... unsigned long long<BR>checking for pid_t... no<BR>checking for library containing strerror... make[1]: Leaving directory </div>  <div>`/home/ssf/bdcom/tools-cross-toolchains/build-gcc-b<BR>configure:error: C compiler cannot create executables<BR>See 'config.log' for more details.<BR>make[1]: *** [configure-target-libmudflap] Error 1<BR>make[1]: *** Waiting for unfinished jobs....<BR>configure: error: Link tests are not allowed after GCC_NO_EXECUTABLES.<BR>make[1]: *** [configure-target-libiberty] Error 1<BR>make: *** [all] Error 2</div>  <div>Here is the config.log file:</div>  <div>configure:600: checking host system type<BR>configure:621: checking target system type<BR>configure:639: checking build system type<BR>configure:694: checking for a BSD compatible install<BR>configure:747: checking whether ln works<BR>configure:771: checking
 whether ln -s works<BR>configure:1825: checking for gcc<BR>configure:1938: checking whether the C compiler (gcc&nbsp; ) works<BR>configure:1954: gcc -o conftest&nbsp;&nbsp;&nbsp; conftest.c&nbsp; 1&gt;&amp;5<BR>configure:1980: checking whether the C compiler (gcc&nbsp; ) is a cross-compiler<BR>configure:1985: checking whether we are using GNU C<BR>configure:2013: checking whether gcc accepts -g<BR>configure:2080: checking for gnatbind<BR>configure:2145: checking whether compiler driver understands Ada<BR>configure:2177: checking how to compare bootstrapped objects<BR>configure:2275: checking for correct version of gmp.h<BR>configure:2288: gcc -c -g -O2&nbsp;&nbsp; conftest.c 1&gt;&amp;5<BR>configure:2301: checking for MPFR<BR>configure:2314: gcc -o conftest -g -O2&nbsp;&nbsp;&nbsp; conftest.c&nbsp; -lmpfr -lgmp 1&gt;&amp;5<BR>configure:3313: checking for bison<BR>configure:3353: checking for bison<BR>configure:3392: checking for gm4<BR>configure:3431: checking for
 flex<BR>configure:3471: checking for flex<BR>configure:3510: checking for makeinfo<BR>configure:3563: checking for expect<BR>configure:3604: checking for runtest<BR>configure:3652: checking for i686-pc-linux-gnu-ar<BR>configure:3727: checking for i686-pc-linux-gnu-as<BR>configure:3802: checking for i686-pc-linux-gnu-dlltool<BR>configure:3833: checking for dlltool<BR>configure:3877: checking for i686-pc-linux-gnu-ld<BR>configure:3952: checking for i686-pc-linux-gnu-lipo<BR>configure:3983: checking for lipo<BR>configure:4027: checking for i686-pc-linux-gnu-nm<BR>configure:4102: checking for i686-pc-linux-gnu-ranlib<BR>configure:4172: checking for i686-pc-linux-gnu-strip<BR>configure:4242: checking for i686-pc-linux-gnu-windres<BR>configure:4273: checking for windres<BR>configure:4317: checking for i686-pc-linux-gnu-objcopy<BR>configure:4392: checking for i686-pc-linux-gnu-objdump<BR>configure:4474: checking for mipsel-unknown-linux-gnu-ar<BR>configure:4549: checking for
 mipsel-unknown-linux-gnu-as<BR>configure:4624: checking for mipsel-unknown-linux-gnu-cc<BR>configure:4624: checking for mipsel-unknown-linux-gnu-gcc<BR>configure:4699: checking for mipsel-unknown-linux-gnu-c++<BR>configure:4699: checking for mipsel-unknown-linux-gnu-g++<BR>configure:4699: checking for mipsel-unknown-linux-gnu-cxx<BR>configure:4699: checking for mipsel-unknown-linux-gnu-gxx<BR>configure:4774: checking for mipsel-unknown-linux-gnu-dlltool<BR>configure:4849: checking for mipsel-unknown-linux-gnu-gcc<BR>configure:4919: checking for mipsel-unknown-linux-gnu-gcj<BR>configure:4994: checking for mipsel-unknown-linux-gnu-gfortran<BR>configure:5069: checking for mipsel-unknown-linux-gnu-ld<BR>configure:5144: checking for mipsel-unknown-linux-gnu-lipo<BR>configure:5219: checking for mipsel-unknown-linux-gnu-nm<BR>configure:5294: checking for mipsel-unknown-linux-gnu-objdump<BR>configure:5369: checking for mipsel-unknown-linux-gnu-ranlib<BR>configure:5439: checking for
 mipsel-unknown-linux-gnu-strip<BR>configure:5514: checking for mipsel-unknown-linux-gnu-windres<BR>configure:5588: checking where to find the target ar<BR>configure:5613: checking where to find the target as<BR>configure:5638: checking where to find the target cc<BR>configure:5663: checking where to find the target c++<BR>configure:5691: checking where to find the target c++ for libstdc++<BR>configure:5719: checking where to find the target dlltool<BR>configure:5744: checking where to find the target gcc<BR>configure:5769: checking where to find the target gcj<BR>configure:5797: checking where to find the target gfortran<BR>configure:5825: checking where to find the target ld<BR>configure:5850: checking where to find the target lipo<BR>configure:5865: checking where to find the target nm<BR>configure:5890: checking where to find the target objdump<BR>configure:5915: checking where to find the target ranlib<BR>configure:5940: checking where to find the target strip<BR>configure:5965:
 checking where to find the target windres<BR>configure:6018: checking whether to enable maintainer-specific portions of Makefiles<BR>configure:6065: checking if symbolic links between directories work</div>  <div><BR>Then i searched through the net for the procedure and found one <BR>like this:</div>  <div>&nbsp;../configure&nbsp;&nbsp; --with-system-zlib --libexecdir=/usr/lib<BR>--prefix=/usr/local/gcc-4.0.2 --enable-shared --with-arch=sb1<BR>--with-tune=sb1 --without-included-gettext --enable-nls<BR>--program-suffix=-4.0.2 --enable-__cxa_atexit<BR>--enable-libstdcxx-allocator=mt --with-target=mips64-linux</div>  <div>I tried with this also but did not work. Again big list of errors.&nbsp;Then searched for more and it seems that i need to have glibc. So&nbsp;i downleded glibc-2.16.1 also.<BR>Now don't know where to start. Let me make u clear that I am new to this. Getting hard to figure out problems. can anyone please tell me the </div>  <div>exact procedure or let me know where i
 can find the correct reference for the tools needed doing all the stuffs from making a cross compiler for sb1 (BCM1480) and then cross compiling kernel 2.6.14.</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Thanks and Regards,</div>  <div>Krishna</div>  <div><BR><BR>There is a lot of information in the wiki http://www.linux-mips.org/ and<BR>I would like to encourage people to contribute to it. Editing a wiki<BR>page _once_ is more productive than answering the same question again<BR>and again ... In particular I also want to encourage the mere mortals<BR>to contribute to the wikis.<BR><BR>Ralf<BR></div></BLOCKQUOTE><BR><p>
	
		<hr size=1><a href="http://us.rd.yahoo.com/mail_us/taglines/postman3/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com">Yahoo! Messenger with Voice.</a> PC-to-Phone calls for ridiculously low rates.
--0-1406943364-1143542157=:21489--
