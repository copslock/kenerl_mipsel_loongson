Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2003 10:44:00 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:11212
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225347AbTHUJn6>; Thu, 21 Aug 2003 10:43:58 +0100
Received: (qmail 6464 invoked from network); 21 Aug 2003 09:35:30 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.187)
  by mail.ict.ac.cn with SMTP; 21 Aug 2003 09:35:30 -0000
Message-ID: <3F449440.4010403@ict.ac.cn>
Date: Thu, 21 Aug 2003 17:43:28 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: =?gb18030?Q?=22=D6=EC=B7=EF=5C=5C=28zhufeng=5C=5C=29=22?= 
	<zhufeng@koretide.com.cn>
CC: linux-mips@linux-mips.org
Subject: Re: gdbserver and gdb debugging stub for mips
References: <MGEELAPMEFMLFBMDBLKLMENDCEAA.zhufeng@koretide.com.cn>
In-Reply-To: <MGEELAPMEFMLFBMDBLKLMENDCEAA.zhufeng@koretide.com.cn>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



���(zhufeng) wrote:

>I wanto access 0x40000000 on mips, I did the following,but still exception
>happed:
>
>     page MASK is set to 4k
>
>    uint asid = 0;
>    ulong reg_entryhi = 0x40000000 | asid;
>
>    ulong reg_entrylo0;
>    ulong phyadd0  = 0x20000000 >> 12;
>    ulong pfn0 = phyadd0 << 6;
>    uint tlb_C = 2 << 3;     //cache coherence bit
>    uint tlb_D = 0 << 2;        //dirty bit
>  
>
You want to write then you should set this bit, D means "writable",not 
really dirty

>    uint tlb_V = 1 << 1;        // valid bit
>    uint tlb_G = 1;             //global bit
>
>    reg_entrylo0 = pfn0|tlb_C|tlb_D|tlb_V|tlb_G;
>	set_entryhi(reg_entryhi);
>	set_entrylo0(reg_entrylo0);
>	set_entrylo1(0|tlb_G);
>	tlb_write_indexed();
>
>    *((unsigned long *)0x40000000) = 0x44;  //still trap into exception
>
>what's the problem? thanks
>
>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org
>[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Fuxin Zhang
>Sent: 2003��8��18�� 13:20
>To: ���(zhufeng)
>Cc: linux-mips@linux-mips.org
>Subject: Re: gdbserver and gdb debugging stub for mips
>
>
>An answer cited from elsewhere:
>-----
>    <snip>
>
>    Rosimildo> /ecos/work/install/lib/libtarget.a(net_tcpip_ip_id.o): In
>function
>    Rosimildo> `ip_initid':
>    Rosimildo>
>/ecos/ecos-1.3.1/packages/net/tcpip/v1_0b1/src/sys/netinet/ip_id.c:231:
>    Rosimildo> relocaton truncated to fit: R_MIPS_GPREL16 time
>
>    Rosimildo> I am wondering if this seems familiar to anyone doing
>    Rosimildo> MIPS stuff.
>
>I think I know what the problem is, but I cannot be 100% sure.
>
>The MIPS architecture allows for a certain amount of global data to be
>accessed more quickly than others, using different instructions. The
>compiler exploits this facility by putting small global variables into
>sections .sdata and .sbss, rather than the normal sections .data and
>.bss. Of course the compiler has no idea how many modules are going to
>end up in the final executable. Hence at link-time it is possible that
>there is now too much data in these sections, and you will get a
>"relocation truncated" message. For most applications you will not hit
>the limit, in fact I am somewhat surprised that any ordinary eCos
>application would cause the problem to arise.
>
>The correct solution would be for the linker to handle this situation
>and decide which global variables should remain in the special region
>and which ones should be moved elsewhere. In theory it could use
>information such as the number of accesses to a particular global, or
>maybe even profiling feedback, to decide which variables are most
>worthwhile keeping in the special region. Unfortunately this would
>require the linker changing the instructions used to access the
>variables that are moved to the ordinary .data and .bss sections,
>which is a non-trivial operation. Also, having the linker change
>instructions would mess up other things such as the compiler's
>attempts at instruction scheduling.
>
>On occasion we have had requests to fix the toolchain so that it does
>the right thing (for some definition of the right thing), but the work
>is sufficiently involved that so far nobody has been willing to fund
>it.
>
>There is a workaround. The mips toolchain accepts an argument -G<num>,
>with a default value of 8. This means that any global variable <= 8
>bytes will end up in .sdata or .sbss. If you compile all the code with
>a different value, e.g. -G4, then less data ends up in the special
>sections so you will not hit the overflow condition. There is a
>performance penalty, of course. I suggest experimenting with -G
>values, and looking at the relevant gcc documentation as well since
>things may have changed since the last time I looked at this. It might
>also be worthwhile searching through the gcc mailing list archives at
>http://gcc.gnu.org/ml/gcc/
>
>Bart Veer // eCos net maintainer
>
>
>
>���(zhufeng) wrote:
>
>  
>
>>when I build my mips program using gcc with -O0 , it is ok, while
>>    
>>
>using -o2, there come the following questions.
>  
>
>>lingking,,,
>>
>>relocation truncated to fit: R_MIPS_GPREL16  __global_ctor_start
>>relocation truncated to fit: R_MIPS_GPREL16 __global_ctor_end
>>relocation truncated to fit: R_MIPS_GPREL16 _recycle_start
>>
>>and so on.
>>
>>Has anybody encounter such questions?
>>
>>
>>
>>-----Original Message-----
>>From: wd@denx.de [mailto:wd@denx.de]
>>Sent: 2003�????�� 23:08
>>To: Öì·ï
>>Cc: Wilson Chan; linux-mips@linux-mips.org
>>Subject: Re: gdbserver and gdb debugging stub for mips
>>
>>
>>In message <MGEELAPMEFMLFBMDBLKLIEKICEAA.zhufeng@koretide.com.cn> you
>>    
>>
>wrote:
>  
>
>>    
>>
>>>what do you mean by "MIPS is NOT MIPS"? Does it mean there are too many
>>>      
>>>
>mips boards?
>  
>
>>>      
>>>
>>big endian, little endian, 32 bit, 64 bit, ...
>>
>>It means that there are several  different  configurations,  and  you
>>must use tools to match your configuration.
>>
>>Best regards,
>>
>>Wolfgang Denk
>>
>>
>>
>>    
>>
>
>
>
>  
>
