Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 00:42:03 +0000 (GMT)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:16847 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8224950AbVCKAlq>; Fri, 11 Mar 2005 00:41:46 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005031100413901400pqdfpe>; Fri, 11 Mar 2005 00:41:40 +0000
Message-ID: <4230E940.2000202@gentoo.org>
Date:	Thu, 10 Mar 2005 19:41:36 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ed Martini <martini@c2micro.com>, linux-mips@linux-mips.org,
	Steve Stone <stone@c2micro.com>
Subject: Re: initrd problem
References: <4230DB4C.7090103@c2micro.com>
In-Reply-To: <4230DB4C.7090103@c2micro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ed Martini wrote:
> Background:
> 
> I'm trying to get 2.6.11 to run on a MIPS Malta board with Yamon.  The 
> kernel that comes with the board is 2.4.18 with an embedded ramdisk that 
> runs some scripts to install RPMS via NFS or CD-ROM.  The kernel is 
> converted to s-records via objcopy(1), and loaded into memory via tftp.  
> I want to do something similar with 2.6.latest.
> 
> Problem:
> 
> On or about Nov 21 of last year, the CONFIG_EMBEDDED_RAMDISK disappeared.
> 
> http://www.linux-mips.org/archives/linux-mips/2004-11/msg00135.html
> 
> In it's place it is suggested to use the tools in arch/mips/boot, so I 
> tried it.  I can cross-compile the kernel, and I get an ELF vmlinux.  I 
> can convert it to ecoff with elf2ecoff, and attach an initrd image with 
> addinitrd.  The problem begins here.  I end up with an ecoff format 
> kernel which is not recognized by objcopy(1), and therefore no s-records.
> 
> It seems there is a program called gensrec that would do the job, but 
> google doesn't want to tell me where to get it.  Some IRIX binary perhaps?
> 
> Solution?
> 
> Should I put CONFIG_EMBEDDED_RAMDISK and its ilk back into my kernel, or 
> write an ELF version of addinitrd?  Other ideas?
> 
> Thanks in advance.

The future is purportedly in the feature known as initramfs.  See the file 
Documentation/early-userpace/README for more details on how that is supposed 
to work.

That said, I tried initramfs a few times, but either due to lack of 
understanding, or broken support code in 2.6.10, I couldn't get it to properly 
load an initrd bundled in, so I forward-ported a patch I wrote that originally 
fixed CONFIG_EMBEDDED_RAMDISK to work with any ABI to 2.6.10, and it worked 
rather well.  I'm sticking with this method until I find more/better docs on 
how to use initramfs properly.

If you're interested, the patch I use can be found here:
http://dev.gentoo.org/~kumba/mips/misc/misc-2.6.10-add-ramdisk-back.patch [2.6.10]
http://dev.gentoo.org/~kumba/mips/misc/misc-2.6.11-add-ramdisk-back.patch [2.6.11]


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
