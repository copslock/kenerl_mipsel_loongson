Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2004 17:12:33 +0000 (GMT)
Received: from apollo.ext.eurgw.xerox.com ([IPv6:::ffff:13.16.138.21]:22193
	"EHLO apollo.eurgw.xerox.com") by linux-mips.org with ESMTP
	id <S8225315AbUCDRMb>; Thu, 4 Mar 2004 17:12:31 +0000
Received: from eurodns2.eur.xerox.com (eurodns2.eur.xerox.com [13.202.66.10])
	by apollo.eurgw.xerox.com (8.12.9-20030917/8.12.9) with ESMTP id i24HCOIj017833
	for <linux-mips@linux-mips.org>; Thu, 4 Mar 2004 17:12:24 GMT
Received: from eurdubmg03.eur.xerox.com (eurdubmg03.eur.xerox.com [13.202.66.60])
	by eurodns2.eur.xerox.com (8.12.9/8.12.9) with ESMTP id i24HCN0a004328
	for <linux-mips@linux-mips.org>; Thu, 4 Mar 2004 17:12:23 GMT
Received: from eurgbrbh02.emeacinops.xerox.com (unverified) by eurdubmg03.eur.xerox.com
 (Content Technologies SMTPRS 4.2.10) with ESMTP id <T68234546ee0dca423cc24@eurdubmg03.eur.xerox.com>;
 Thu, 4 Mar 2004 17:12:21 +0000
Received: from gbrwgcbh01.wgc.gbr.xerox.com ([13.200.2.175]) by eurgbrbh02.emeacinops.xerox.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id GC30CRSV; Thu, 4 Mar 2004 17:10:51 -0000
Received: by gbrwgcbh01.wgc.gbr.xerox.com with Internet Mail Service (5.5.2657.72)
	id <FW23JX5C>; Thu, 4 Mar 2004 17:12:47 -0000
Message-ID: <8EAC52A94CD8D411A01000805FBB37760615AF9F@gbrwgcms02.wgc.gbr.xerox.com>
From: "Hamilton, Ian" <Ian.Hamilton@gbr.xerox.com>
To: "'gcc-help@gcc.gnu.org'" <gcc-help@gcc.gnu.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Problems with MIPS cross compiler/linker
Date: Thu, 4 Mar 2004 17:12:46 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Ian.Hamilton@gbr.xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@gbr.xerox.com
Precedence: bulk
X-list: linux-mips

Hello.

I'm having problems getting an embedded MIPS application to link.

The error messages I'm getting during the final link are as follows:

Linking...
	/home/ihamilto/crosstools/mipsel-elf/bin/mipsel-elf-ld -EL -T
/vob/generic_runtime/Templates/macbeth.cmd
/vob/generic_runtime/Target/MacbethCode/obj.suimacbethmips/crt0.o
/vob/generic_runtime/lib/libsuimacbethmipsMacbeth_lib40_07_00.a
/vob/generic_runtime/lib/libsuimacbethmipsTest_lib40_07_00.a
/vob/generic_runtime/lib/libsuimacbethmipsCommon_lib40_07_00.a
/vob/generic_runtime/lib/libsuimacbethmipsTest_lib40_07_00.a
/vob/generic_runtime/lib/libsuimacbethmipsMacbeth_lib40_07_00.a
/vob/generic_runtime/lib/libsuimacbethmipsCommon_lib40_07_00.a
/vob/generic_runtime/lib/libsuimacbethmipsMacbeth_lib40_07_00.a
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libc.a
/home/ihamilto/crosstools/mipsel-elf/lib/gcc-lib/mipsel-elf/3.3.2/libgcc.a
-Map
/vob/generic_runtime/Target/MacbethCode/obj.suimacbethmips/generic_runtime.m
ap  -o
/vob/generic_runtime/Target/MacbethCode/obj.suimacbethmips/generic_runtime
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a(streambuf-in
st.o)(.gnu.linkonce.t._ZNSt15basic_streambufIcSt11char_traitsIcEE15_M_pback_
createEv+0x30): In function `int std::__copy_streambufs<char,
std::char_traits<char> >(std::basic_ios<char, std::char_traits<char> >&,
std::basic_streambuf<char, std::char_traits<char> >*,
std::basic_streambuf<char, std::char_traits<char> >*)':
/home/ihamilto/crossbuild/build-gcc/mipsel-elf/libstdc++-v3/include/bits/str
eambuf.tcc:165: relocation truncated to fit: R_MIPS_GPREL16
std::basic_streambuf<char, std::char_traits<char> >::_S_pback_size
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a(streambuf-in
st.o)(.gnu.linkonce.t._ZNSt15basic_streambufIcSt11char_traitsIcEE15_M_pback_
createEv+0x4c): In function `int std::__copy_streambufs<char,
std::char_traits<char> >(std::basic_ios<char, std::char_traits<char> >&,
std::basic_streambuf<char, std::char_traits<char> >*,
std::basic_streambuf<char, std::char_traits<char> >*)':
/home/ihamilto/crossbuild/build-gcc/mipsel-elf/libstdc++-v3/include/bits/stl
_algobase.h:153: relocation truncated to fit: R_MIPS_GPREL16
std::basic_streambuf<char, std::char_traits<char> >::_S_pback_size
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a(fstream-inst
.o)(.gnu.linkonce.t._ZNSt13basic_filebufIcSt11char_traitsIcEE9pbackfailEi+0x
e8):/home/ihamilto/crossbuild/build-gcc/mipsel-elf/libstdc++-v3/include/fstr
eam:770: relocation truncated to fit: R_MIPS_GPREL16
std::basic_streambuf<char, std::char_traits<char> >::_S_pback_size
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a(fstream-inst
.o)(.gnu.linkonce.t._ZNSt13basic_filebufIcSt11char_traitsIcEE9pbackfailEi+0x
100):/home/ihamilto/crossbuild/build-gcc/mipsel-elf/libstdc++-v3/include/bit
s/basic_ios.h:255: relocation truncated to fit: R_MIPS_GPREL16
std::basic_streambuf<char, std::char_traits<char> >::_S_pback_size
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a(fstream-inst
.o)(.gnu.linkonce.t._ZNSt13basic_filebufIcSt11char_traitsIcEE9pbackfailEi+0x
228):/home/ihamilto/crossbuild/build-gcc/mipsel-elf/libstdc++-v3/include/bit
s/fstream.tcc:466: relocation truncated to fit: R_MIPS_GPREL16
std::basic_streambuf<char, std::char_traits<char> >::_S_pback_size
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/libstdc++.a(fstream-inst
.o)(.gnu.linkonce.t._ZNSt13basic_filebufIcSt11char_traitsIcEE9pbackfailEi+0x
240):/home/ihamilto/crossbuild/build-gcc/mipsel-elf/libstdc++-v3/include/bit
s/fstream.tcc:467: relocation truncated to fit: R_MIPS_GPREL16
std::basic_streambuf<char, std::char_traits<char> >::_S_pback_size
*** Error code 1



I've investigated the object files supplying the symbol causing the problem,
and have made the following discoveries:



The (mangled) symbol causing the link problem is:

_ZNSt15basic_streambufIcSt11char_traitsIcEE13_S_pback_sizeE



In the streambuf-inst.o file (part of linstdc++), the symbol appears in the
symbol
table like this:

00000000  w    O
.gnu.linkonce.s._ZNSt15basic_streambufIcSt11char_traitsIcEE13_S_pback_sizeE
00000004 _ZNSt15basic_streambufIcSt11char_traitsIcEE13_S_pback_sizeE



In the DebugMsgTest.o file (part of the application), the symbol appears in
the symbol
table like this:

00000000  w    O
.gnu.linkonce.r._ZNSt15basic_streambufIcSt11char_traitsIcEE13_S_pback_sizeE
00000004 _ZNSt15basic_streambufIcSt11char_traitsIcEE13_S_pback_sizeE



The same symbol is appearing in two diffeent linkonce sections. If I am
reading the
section names correctly, the section generated by streambuf-inst.cc is
trying to
place the symbol in the read-only section of the memory map, while the
section
generated by DebugMsgTes.cc is trying to place the symbol in the small data
(GP
referenced) section of the memory map.


The declaration of this symbol is in std_streambuf.h:

  template<typename _CharT, typename _Traits>
    class basic_streambuf 
    {
...
    protected:
...
      static const size_t   	_S_pback_size = 1; 



The definition of this symbol is in streambuf.tcc:

namespace std 
{
  template<typename _CharT, typename _Traits>
    const size_t
    basic_streambuf<_CharT, _Traits>::_S_pback_size;


The streambuf-inst.cc file is compiled like this:

/home/ihamilto/crossbuild/build-gcc/gcc/xgcc -shared-libgcc
-B/home/ihamilto/crossbuild/build-gcc/gcc/ -nostdinc++
-L/home/ihamilto/crossbuild/build-gcc/mipsel-elf/soft-float/libstdc++-v3/src
-L/home/ihamilto/crossbuild/build-gcc/mipsel-elf/soft-float/libstdc++-v3/src
/.libs -nostdinc
-B/home/ihamilto/crossbuild/build-gcc/mipsel-elf/soft-float/newlib/ -isystem
/home/ihamilto/crossbuild/build-gcc/mipsel-elf/soft-float/newlib/targ-includ
e -isystem /home/ihamilto/crossbuild/gcc-3.3.2/newlib/libc/include
-B/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/bin/
-B/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/lib/ -isystem
/home/ihamilto/crosstools/mipsel-elf/mipsel-elf/include -msoft-float
-nostdinc++
-I/home/ihamilto/crossbuild/build-gcc/mipsel-elf/soft-float/libstdc++-v3/inc
lude/mipsel-elf
-I/home/ihamilto/crossbuild/build-gcc/mipsel-elf/soft-float/libstdc++-v3/inc
lude -I../../../../../gcc-3.3.2/libstdc++-v3/libsupc++
-I../../../../../gcc-3.3.2/libstdc++-v3/libmath -g -O2 -msoft-float
-fno-implicit-templates -Wall -Wno-format -W -Wwrite-strings
-fdiagnostics-show-location=once -c
../../../../../gcc-3.3.2/libstdc++-v3/src/streambuf-inst.cc -o
streambuf-inst.o



The DebugMsgTest.cc file is compiled like this:

Compiling DebugMsg.cc...
	/home/ihamilto/crosstools/mipsel-elf/bin/mipsel-elf-g++ -c -mips2 -G
0 -O0 -EL -DEL -Wa,-G0,-non_shared -I. -fno-exceptions -D_REENTRANT
-DNO_NAMESPACES -DNEW_STL -DTARGET_sui -DHARDWARE_macbeth -DPROCESSOR_mips
-g -Wall -W -Wno-format -Wno-reorder -Wno-deprecated -fno-exceptions
-I/vob/generic_runtime -I/vob/generic_runtime/Common
-I/vob/generic_runtime/Common/DebugMsg -I/vob/generic_runtime/Common/Toolkit
-I/vob/generic_runtime/Common/defs -I/vob/generic_runtime/Common/Drivers
-I/vob/generic_runtime/Common/network
-I/vob/generic_runtime/Common/Nonordered -I/vob/generic_runtime/Common/Pci
-I/vob/generic_runtime/Common/Registers -I/vob/generic_runtime/Common/rpc
-I/vob/generic_runtime/Common/Rtasks -I/vob/generic_runtime/Common/RuntimeIF
-I/vob/generic_runtime/Common/Tasks -I/vob/generic_runtime/Common/Tftp
-I/vob/generic_runtime/Common/Utils
-I/vob/generic_runtime/Target/MacbethCode/DebugMsg
-I/vob/generic_runtime/Target/MacbethCode/Drivers
-I/vob/generic_runtime/Target/MacbethCode/network
-I/vob/generic_runtime/Target/MacbethCode/Nonordered
-I/vob/generic_runtime/Target/MacbethCode/Tasks
-I/vob/generic_runtime/Target/MacbethCode/Utils
-I/vob/generic_runtime/Target/MacbethCode  -o obj.suimacbethmips/DebugMsg.o
DebugMsg/DebugMsg.cc


Can anyone give me some help to get this application to link?

Thanks for reading this far!

Regards,
Ian Hamilton
