Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2003 10:17:12 +0100 (BST)
Received: from p508B611E.dip.t-dialin.net ([IPv6:::ffff:80.139.97.30]:32972
	"EHLO p508B611E.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225347AbTHUJRK>; Thu, 21 Aug 2003 10:17:10 +0100
Received: from [IPv6:::ffff:210.22.155.234] ([IPv6:::ffff:210.22.155.234]:37054
	"EHLO mail.koretide.com.cn") by linux-mips.net with ESMTP
	id <S869160AbTHUJRD>; Thu, 21 Aug 2003 11:17:03 +0200
Received: from zhufeng ([192.168.1.12])
	(authenticated)
	by mail.koretide.com.cn (8.11.6/8.11.6) with ESMTP id h7L9Csc29003;
	Thu, 21 Aug 2003 17:12:54 +0800
From: =?gb2312?B?1uy371woemh1ZmVuZ1wp?= <zhufeng@koretide.com.cn>
To: "Fuxin Zhang" <fxzhang@ict.ac.cn>
Cc: <linux-mips@linux-mips.org>
Subject: RE: gdbserver and gdb debugging stub for mips
Date: Thu, 21 Aug 2003 17:14:56 +0800
Message-ID: <MGEELAPMEFMLFBMDBLKLMENDCEAA.zhufeng@koretide.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-reply-to: <3F4061FC.4080806@ict.ac.cn>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <zhufeng@koretide.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhufeng@koretide.com.cn
Precedence: bulk
X-list: linux-mips

I wanto access 0x40000000 on mips, I did the following,but still exception
happed:

     page MASK is set to 4k

    uint asid = 0;
    ulong reg_entryhi = 0x40000000 | asid;

    ulong reg_entrylo0;
    ulong phyadd0  = 0x20000000 >> 12;
    ulong pfn0 = phyadd0 << 6;
    uint tlb_C = 2 << 3;     //cache coherence bit
    uint tlb_D = 0 << 2;        //dirty bit
    uint tlb_V = 1 << 1;        // valid bit
    uint tlb_G = 1;             //global bit

    reg_entrylo0 = pfn0|tlb_C|tlb_D|tlb_V|tlb_G;
	set_entryhi(reg_entryhi);
	set_entrylo0(reg_entrylo0);
	set_entrylo1(0|tlb_G);
	tlb_write_indexed();

    *((unsigned long *)0x40000000) = 0x44;  //still trap into exception

what's the problem? thanks

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Fuxin Zhang
Sent: 2003Äê8ÔÂ18ÈÕ 13:20
To: Öì·ï(zhufeng)
Cc: linux-mips@linux-mips.org
Subject: Re: gdbserver and gdb debugging stub for mips


An answer cited from elsewhere:
-----
    <snip>

    Rosimildo> /ecos/work/install/lib/libtarget.a(net_tcpip_ip_id.o): In
function
    Rosimildo> `ip_initid':
    Rosimildo>
/ecos/ecos-1.3.1/packages/net/tcpip/v1_0b1/src/sys/netinet/ip_id.c:231:
    Rosimildo> relocaton truncated to fit: R_MIPS_GPREL16 time

    Rosimildo> I am wondering if this seems familiar to anyone doing
    Rosimildo> MIPS stuff.

I think I know what the problem is, but I cannot be 100% sure.

The MIPS architecture allows for a certain amount of global data to be
accessed more quickly than others, using different instructions. The
compiler exploits this facility by putting small global variables into
sections .sdata and .sbss, rather than the normal sections .data and
.bss. Of course the compiler has no idea how many modules are going to
end up in the final executable. Hence at link-time it is possible that
there is now too much data in these sections, and you will get a
"relocation truncated" message. For most applications you will not hit
the limit, in fact I am somewhat surprised that any ordinary eCos
application would cause the problem to arise.

The correct solution would be for the linker to handle this situation
and decide which global variables should remain in the special region
and which ones should be moved elsewhere. In theory it could use
information such as the number of accesses to a particular global, or
maybe even profiling feedback, to decide which variables are most
worthwhile keeping in the special region. Unfortunately this would
require the linker changing the instructions used to access the
variables that are moved to the ordinary .data and .bss sections,
which is a non-trivial operation. Also, having the linker change
instructions would mess up other things such as the compiler's
attempts at instruction scheduling.

On occasion we have had requests to fix the toolchain so that it does
the right thing (for some definition of the right thing), but the work
is sufficiently involved that so far nobody has been willing to fund
it.

There is a workaround. The mips toolchain accepts an argument -G<num>,
with a default value of 8. This means that any global variable <= 8
bytes will end up in .sdata or .sbss. If you compile all the code with
a different value, e.g. -G4, then less data ends up in the special
sections so you will not hit the overflow condition. There is a
performance penalty, of course. I suggest experimenting with -G
values, and looking at the relevant gcc documentation as well since
things may have changed since the last time I looked at this. It might
also be worthwhile searching through the gcc mailing list archives at
http://gcc.gnu.org/ml/gcc/

Bart Veer // eCos net maintainer



Öì·ï(zhufeng) wrote:

>when I build my mips program using gcc with -O0 , it is ok, while
using -o2, there come the following questions.
>lingking,,,
>
>relocation truncated to fit: R_MIPS_GPREL16  __global_ctor_start
>relocation truncated to fit: R_MIPS_GPREL16 __global_ctor_end
>relocation truncated to fit: R_MIPS_GPREL16 _recycle_start
>
>and so on.
>
>Has anybody encounter such questions?
>
>
>
>-----Original Message-----
>From: wd@denx.de [mailto:wd@denx.de]
>Sent: 2003å¹??—¥ 23:08
>To: Ã–Ã¬Â·Ã¯
>Cc: Wilson Chan; linux-mips@linux-mips.org
>Subject: Re: gdbserver and gdb debugging stub for mips
>
>
>In message <MGEELAPMEFMLFBMDBLKLIEKICEAA.zhufeng@koretide.com.cn> you
wrote:
>
>
>> what do you mean by "MIPS is NOT MIPS"? Does it mean there are too many
mips boards?
>>
>>
>
>big endian, little endian, 32 bit, 64 bit, ...
>
>It means that there are several  different  configurations,  and  you
>must use tools to match your configuration.
>
>Best regards,
>
>Wolfgang Denk
>
>
>
