Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 07:16:57 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:16859 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225228AbUARHQ4>; Sun, 18 Jan 2004 07:16:56 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with SMTP
          id <200401180716500120028aife>
          (Authid: kumba12345);
          Sun, 18 Jan 2004 07:16:50 +0000
Message-ID: <400A3353.6050903@gentoo.org>
Date: Sun, 18 Jan 2004 02:18:43 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
References: <200401171711.34964@korath> <200401181510.35686@korath> <400A1B5F.6010307@gentoo.org> <200401181646.04740@korath>
In-Reply-To: <200401181646.04740@korath>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Adam Nielsen wrote:

> Thanks for all the info!  Well, I tried building gcc-3.3.2 with your options 
> and that worked (hooray!) but I couldn't find binutils-2.14.90.0.7, the 
> closest I could see was 2.14 so I used that.  It all compiled ok, but now 
> when I go to compile the kernel I get this error:
> 
> cc1: error: invalid option `cpu=r3000'

http://www.kernel.org/pub/linux/devel/binutils/

The 2.14.90.0.X series of binutils is a linux-only release maintained by 
HJ Lu, while the 2.14 version is more or less the official GNU version.

As for the kernel, -mcpu was deprecated in gcc-3.2.x, and totally 
removed in gcc-3.3.x.  You'll want to use the -march option (or 
-mips[1234] as a synonym), although if you use a recent kernel source 
tree off linux-mips anoncvs, selecting the right CPU/Machinetype in 
menuconfig will supply the proper -march/-mipsX commands to the 
compiler.  You'll also want to pass something like this:

make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- <target>

Note: CROSS_COMPILE needs to be set to the CHOST the cross compiler was 
built with, in my cases, I use the extended CHOST form.  The more common 
form is mips[el]-linux (or mips64[el]-linux)

For 2.4, if you want a mips64 kernel, pass ARCH=mips64.  For 2.6, pass 
ARCH=mips and select 64-bit mode in menuconfig (or oldconfig or xconfig)


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
