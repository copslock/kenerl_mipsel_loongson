Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78Elke08990
	for linux-mips-outgoing; Wed, 8 Aug 2001 07:47:46 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78EleV08972
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 07:47:40 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A64D4125C3; Wed,  8 Aug 2001 07:47:38 -0700 (PDT)
Date: Wed, 8 Aug 2001 07:47:38 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: mark@codesourcery.com, gcc-patches@gcc.gnu.org, linux-mips@oss.sgi.com
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <20010808074738.B26983@lucon.org>
References: <20010807084236.A5550@lucon.org> <997278707.1290.41.camel@ghostwheel.cygnus.com> <20010808071716.A26704@lucon.org> <997280370.1290.43.camel@ghostwheel.cygnus.com> <20010808073509.A26983@lucon.org> <997281490.1290.49.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997281490.1290.49.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Wed, Aug 08, 2001 at 03:38:08PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 03:38:08PM +0100, Eric Christopher wrote:
>  
> > 
> > BTW, let me know if it is ok to check in. Also, I'd like to check it
> > into gcc 3.0.1 if it is approved for the trunk.
> > 
> 
> Quick question:  You said you tested, but I wanted to verify that you
> were able to bootstrap with no regressions?  If so, then it is approved

Well, it is my first try of gcc 3.0/3.1 on Linux/mips. I also have to
disable libgcj since it is not supported. I couldn't find any previous
gcc 3.0/3.1 testsuite results for Linux/mips. In any case, I am
enclosing mine here. It has more failures than it should have since
my hardware/kernel is flaky.

> for the trunk.  Mark will need to approve for the branch.
> 


H.J.
-----
FAIL: 21_strings/append.cc execution test
FAIL: 21_strings/ctor_copy_dtor.cc execution test
FAIL: 21_strings/element_access.cc execution test
FAIL: 21_strings/insert.cc execution test
FAIL: 21_strings/substr.cc execution test
FAIL: 22_locale/ctor_copy_dtor.cc execution test
FAIL: 23_containers/bitset_members.cc execution test
FAIL: 23_containers/vector_element_access.cc execution test
FAIL: 27_io/filebuf.cc execution test
FAIL: 27_io/filebuf_members.cc execution test
FAIL: 27_io/ifstream_members.cc execution test
FAIL: 27_io/ios_members.cc execution test
FAIL: 27_io/istream_extractor_other.cc execution test
FAIL: 27_io/istream_seeks.cc execution test
FAIL: 27_io/istream_unformatted.cc execution test
FAIL: 27_io/ostream_inserter_other.cc execution test
FAIL: gcc.c-torture/compile/20001226-1.c,  -O0  
FAIL: gcc.c-torture/compile/20001226-1.c,  -O2  
FAIL: gcc.c-torture/compile/20001226-1.c,  -O3 -fomit-frame-pointer  
FAIL: gcc.c-torture/compile/20001226-1.c,  -O3 -g  
FAIL: gcc.c-torture/compile/20001226-1.c,  -Os  
FAIL: gcc.c-torture/compile/920501-12.c,  -O1  
FAIL: gcc.c-torture/compile/920501-12.c,  -O2  
FAIL: gcc.c-torture/compile/920501-12.c,  -O3 -fomit-frame-pointer  
FAIL: gcc.c-torture/compile/920501-12.c,  -O3 -g  
FAIL: gcc.c-torture/compile/920501-12.c,  -Os  
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O0 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O1 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O2 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O3 -fomit-frame-pointer 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O3 -fomit-frame-pointer -funroll-loops 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O3 -fomit-frame-pointer -funroll-all-loops -finline-functions 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -O3 -g 
FAIL: gcc.c-torture/execute/20010122-1.c execution,  -Os 
FAIL: gcc.c-torture/execute/921208-2.c compilation,  -O3 -fomit-frame-pointer 
FAIL: gcc.c-torture/execute/921208-2.c compilation,  -O3 -fomit-frame-pointer -funroll-loops 
FAIL: gcc.c-torture/execute/921208-2.c compilation,  -O3 -fomit-frame-pointer -funroll-all-loops -finline-functions 
FAIL: gcc.c-torture/execute/921208-2.c compilation,  -O3 -g 
FAIL: gcc.c-torture/execute/930106-1.c compilation,  -O3 -fomit-frame-pointer 
FAIL: gcc.c-torture/execute/930106-1.c compilation,  -O3 -g 
FAIL: gcc.dg/cpp/assert_trad1.c (test for excess errors)
FAIL: gcc.dg/cpp/assert_trad2.c (test for excess errors)
FAIL: gcc.dg/cpp/assert_trad3.c (test for excess errors)
FAIL: gcc.dg/cpp/defined_trad.c (test for excess errors)
FAIL: gcc.dg/cpp/hash2.c (test for excess errors)
FAIL: gcc.dg/cpp/tr-define.c (test for excess errors)
FAIL: gcc.dg/cpp/tr-direct.c (test for excess errors)
FAIL: gcc.dg/cpp/tr-paste.c (test for excess errors)
FAIL: gcc.dg/cpp/tr-str.c (test for excess errors)
FAIL: gcc.dg/cpp/ucs.c  (test for warnings, line 24)
FAIL: gcc.dg/cpp/ucs.c (test for excess errors)
FAIL: gcc.dg/asm-fs-1.c scan-assembler-not \*_bar
FAIL: gcc.dg/asm-fs-1.c scan-assembler-not \*_baz
FAIL: gcc.dg/ext-glob.c (test for excess errors)
FAIL: gcc.dg/special/gcsec-1.c (test for excess errors)
FAIL: g++.abi/cxa_vec.C  Execution test
FAIL: g++.abi/vbase1.C (test for excess errors)
FAIL: g++.eh/fntry1.C  Execution test
FAIL: g++.eh/new2.C  Execution test
FAIL: g++.eh/spec2.C  Execution test
FAIL: g++.eh/spec3.C  Execution test
FAIL: g++.jason/groff1.C (test for excess errors)
FAIL: g++.jason/ref12.C (test for excess errors)
FAIL: g++.mike/dyncast2.C  Execution test
FAIL: g++.mike/eh10.C (test for excess errors)
FAIL: g++.mike/eh16.C  Execution test
FAIL: g++.mike/eh17.C  Execution test
FAIL: g++.mike/eh23.C  Execution test
FAIL: g++.mike/eh33.C  Execution test
FAIL: g++.mike/eh39.C  Execution test
FAIL: g++.mike/eh40.C  Execution test
FAIL: g++.mike/eh41.C  Execution test
FAIL: g++.mike/eh50.C  Execution test
FAIL: g++.mike/eh51.C  Execution test
FAIL: g++.mike/thunk3.C (test for excess errors)
FAIL: g++.ns/template4.C (test for excess errors)
FAIL: g++.other/crash18.C caused compiler crash
FAIL: g++.other/enum5.C (test for excess errors)
FAIL: g++.other/incomplete.C incomplete (test for errors, line 14)
FAIL: g++.other/incomplete.C incomplete (test for errors, line 15)
FAIL: g++.other/incomplete.C incomplete (test for errors, line 16)
FAIL: g++.robertl/eh990323-1.C  Execution test
FAIL: g++.robertl/eh990323-5.C  Execution test
FAIL: g77.f-torture/compile/19990826-3.f,  -O0  
FAIL: g77.f-torture/execute/20010430.f execution,  -O2 
FAIL: g77.f-torture/execute/20010430.f execution,  -O3 -fomit-frame-pointer 
FAIL: g77.f-torture/execute/20010430.f execution,  -O3 -fomit-frame-pointer -funroll-loops 
FAIL: g77.f-torture/execute/20010430.f execution,  -O3 -fomit-frame-pointer -funroll-all-loops -finline-functions 
FAIL: g77.f-torture/execute/20010430.f execution,  -O3 -g 
FAIL: g77.f-torture/execute/intrinsic-vax-cd.f compilation,  -O0 
FAIL: g77.f-torture/execute/intrinsic-vax-cd.f compilation,  -O1 
FAIL: g77.f-torture/execute/intrinsic-vax-cd.f compilation,  -O2 
FAIL: g77.f-torture/execute/intrinsic-vax-cd.f compilation,  -O3 -fomit-frame-pointer 
FAIL: g77.f-torture/execute/intrinsic-vax-cd.f compilation,  -O3 -g 
FAIL: g77.f-torture/execute/intrinsic-vax-cd.f compilation,  -Os 
FAIL: g77.f-torture/execute/intrinsic77.f compilation,  -O0 
FAIL: g77.f-torture/execute/intrinsic77.f compilation,  -O1 
FAIL: g77.f-torture/execute/intrinsic77.f compilation,  -O2 
FAIL: g77.f-torture/execute/intrinsic77.f compilation,  -O3 -fomit-frame-pointer 
FAIL: g77.f-torture/execute/intrinsic77.f compilation,  -O3 -g 
FAIL: g77.f-torture/execute/intrinsic77.f compilation,  -Os 
FAIL: objc/execute/IMP.m compilation,  -O 
FAIL: objc/execute/_cmd.m compilation,  -O 
FAIL: objc/execute/accessing_ivars.m compilation,  -O 
FAIL: objc/execute/bf-1.m compilation,  -O 
FAIL: objc/execute/bf-10.m compilation,  -O 
FAIL: objc/execute/bf-11.m compilation,  -O 
FAIL: objc/execute/bf-12.m compilation,  -O 
FAIL: objc/execute/bf-13.m compilation,  -O 
FAIL: objc/execute/bf-14.m compilation,  -O 
FAIL: objc/execute/bf-15.m compilation,  -O 
FAIL: objc/execute/bf-16.m compilation,  -O 
FAIL: objc/execute/bf-17.m compilation,  -O 
FAIL: objc/execute/bf-18.m compilation,  -O 
FAIL: objc/execute/bf-19.m compilation,  -O 
FAIL: objc/execute/bf-2.m compilation,  -O 
FAIL: objc/execute/bf-20.m compilation,  -O 
FAIL: objc/execute/bf-3.m compilation,  -O 
FAIL: objc/execute/bf-4.m compilation,  -O 
FAIL: objc/execute/bf-5.m compilation,  -O 
FAIL: objc/execute/bf-6.m compilation,  -O 
FAIL: objc/execute/bf-7.m compilation,  -O 
FAIL: objc/execute/bf-8.m compilation,  -O 
FAIL: objc/execute/bf-9.m compilation,  -O 
FAIL: objc/execute/bycopy-1.m compilation,  -O 
FAIL: objc/execute/bycopy-2.m compilation,  -O 
FAIL: objc/execute/bycopy-3.m compilation,  -O 
FAIL: objc/execute/class-1.m compilation,  -O 
FAIL: objc/execute/class-10.m compilation,  -O 
FAIL: objc/execute/class-11.m compilation,  -O 
FAIL: objc/execute/class-12.m compilation,  -O 
FAIL: objc/execute/class-13.m compilation,  -O 
FAIL: objc/execute/class-14.m compilation,  -O 
FAIL: objc/execute/class-2.m compilation,  -O 
FAIL: objc/execute/class-3.m compilation,  -O 
FAIL: objc/execute/class-4.m compilation,  -O 
FAIL: objc/execute/class-5.m compilation,  -O 
FAIL: objc/execute/class-6.m compilation,  -O 
FAIL: objc/execute/class-7.m compilation,  -O 
FAIL: objc/execute/class-8.m compilation,  -O 
FAIL: objc/execute/class-9.m compilation,  -O 
FAIL: objc/execute/compatibility_alias.m compilation,  -O 
FAIL: objc/execute/encode-1.m compilation,  -O 
FAIL: objc/execute/fdecl.m compilation,  -O 
FAIL: objc/execute/formal_protocol-1.m compilation,  -O 
FAIL: objc/execute/formal_protocol-2.m compilation,  -O 
FAIL: objc/execute/formal_protocol-3.m compilation,  -O 
FAIL: objc/execute/formal_protocol-4.m compilation,  -O 
FAIL: objc/execute/formal_protocol-5.m compilation,  -O 
FAIL: objc/execute/formal_protocol-6.m compilation,  -O 
FAIL: objc/execute/formal_protocol-7.m compilation,  -O 
FAIL: objc/execute/initialize.m compilation,  -O 
FAIL: objc/execute/load-2.m compilation,  -O 
FAIL: objc/execute/load-3.m compilation,  -O 
FAIL: objc/execute/load.m compilation,  -O 
FAIL: objc/execute/many_args_method.m compilation,  -O 
FAIL: objc/execute/nested-2.m compilation,  -O 
FAIL: objc/execute/nested-3.m compilation,  -O 
FAIL: objc/execute/no_clash.m compilation,  -O 
FAIL: objc/execute/np-1.m compilation,  -O 
FAIL: objc/execute/np-2.m compilation,  -O 
FAIL: objc/execute/object_is_class.m compilation,  -O 
FAIL: objc/execute/object_is_meta_class.m compilation,  -O 
FAIL: objc/execute/paste.m compilation,  -O 
FAIL: objc/execute/private.m compilation,  -O 
FAIL: objc/execute/protocol.m compilation,  -O 
FAIL: objc/execute/redefining_self.m compilation,  -O 
FAIL: objc/execute/root_methods.m compilation,  -O 
FAIL: objc/execute/selector-1.m compilation,  -O 
FAIL: objc/execute/static-1.m compilation,  -O 
FAIL: objc/execute/static-2.m compilation,  -O 
FAIL: objc/execute/string1.m compilation,  -O 
FAIL: objc/execute/string2.m compilation,  -O 
FAIL: objc/execute/string3.m compilation,  -O 
FAIL: objc/execute/string4.m compilation,  -O 
FAIL: objc/execute/va_method.m compilation,  -O 
FAIL: objc.dg/class-1.m (test for excess errors)
FAIL: objc.dg/class-2.m (test for excess errors)
FAIL: objc.dg/const-str-1.m (test for excess errors)
FAIL: objc.dg/local-decl-1.m (test for excess errors)
FAIL: objc.dg/method-1.m (test for excess errors)
FAIL: objc.dg/proto-hier-1.m (test for excess errors)
