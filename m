Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3THaXwJ002432
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Apr 2002 10:36:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3THaXUD002431
	for linux-mips-outgoing; Mon, 29 Apr 2002 10:36:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3THaMwJ002428
	for <linux-mips@oss.sgi.com>; Mon, 29 Apr 2002 10:36:22 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA01549;
	Mon, 29 Apr 2002 10:35:29 -0700
Message-ID: <3CCD847A.8050905@mvista.com>
Date: Mon, 29 Apr 2002 10:35:54 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: reiserfs
References: <E171Yfh-0000gA-00@the-village.bc.nu> <1019937954.1260.22.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------060504060505070508050507"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------060504060505070508050507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pete Popov wrote:

> On Sat, 2002-04-27 at 13:19, Alan Cox wrote:
> 
>>>Has anyone been able to run reiserfs on big endian systems?
>>>
>>Should work on newer 2.4 kernels
>>
> 
> Yes, it does. I sent an email yesterday explaining what the problem
> was.  The 2.95.3 toolchain is miscompiling the cpu_to_le16 and
> le16_to_cpu functions. The problem appears to be fixed in 2.96 and 3.x
> so reiserfs is looking good for both, LE and BE mips systems.
> 


Here is the test case that reveals the toolchain problem.  Brave souls are 
welcome to look into it.

Apparently the bug only happens on be tools with 2.95.x.

Jun



--------------060504060505070508050507
Content-Type: text/plain;
 name="gcc-2.95-le16-to-cpu.bug.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-2.95-le16-to-cpu.bug.c"

#if 0

compile instructions:

/opt/hardhat/devkit/mips/fp_be/bin/mips_fp_be-gcc -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -g -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe    -c -o try.o try.c

#endif

typedef	unsigned short __u16;
typedef	unsigned __u32;

#define ___swab16_new(x) \
({ \
        __u32 __x = (x); \
        __x = ((__u32)( \
                ((__u32)(__x) << 8) | \
                (((__u32)(__x) & (__u16)0xff00U) >> 8) )); \
        (__u16)(__x & 0xffff); \
})

#define ___swab16(x) \
({ \
        __u16 __x = (x); \
        ((__u16)( \
                (((__u16)(__x) & (__u16)0x00ffU) << 8) | \
                (((__u16)(__x) & (__u16)0xff00U) >> 8) )); \
})

#  define __swab16(x) \
(__builtin_constant_p((__u16)(x)) ? \
  ___swab16((x)) : \
   __fswab16((x)))

#ifndef __arch__swab16
#  define __arch__swab16(x) ({ __u16 __tmp = (x) ; ___swab16(__tmp); })
#endif

static __inline__ __const__ __u16 __fswab16(__u16 x)
{
	        return __arch__swab16(x);
}

#define __le16_to_cpu(x) __swab16((x))
#define le16_to_cpu __le16_to_cpu

extern __u16 x;
extern __u16 y;

void foo_old(void)
{
	if (le16_to_cpu(x) > y) 
		y = x;
}

--------------060504060505070508050507--
