Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 08:11:21 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:52131 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225228AbUARILU>; Sun, 18 Jan 2004 08:11:20 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc13) with SMTP
          id <2004011808111401600gc9t7e>
          (Authid: kumba12345);
          Sun, 18 Jan 2004 08:11:14 +0000
Message-ID: <400A4014.2070703@gentoo.org>
Date: Sun, 18 Jan 2004 03:13:08 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
References: <200401171711.34964@korath> <200401181646.04740@korath> <400A3353.6050903@gentoo.org> <200401181804.31114@korath>
In-Reply-To: <200401181804.31114@korath>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Adam Nielsen wrote:


> Oh ok then - so what should I do to actually compile a MIPS kernel?  I'd 
> rather not have to download an entirely separate kernel source, so should I 
> just go back to gcc-3.1.1 that supports -mcpu?
> 
> Will kernel 2.6.1 or whatever's next work properly in this respect?  I realise 
> that there are plenty of valid reasons for removing -mcpu, but it does create 
> a big headache for us users, who just want the darn thing to 'go' ;-)

Get the anonymous cvs info for the linux-mips CVS server from the 
linux-mips.org homepage.  That's the source you want to use for mips 
kernels.  For 2.4, you'll need to checkout the linux_2_4 tag, otherwise 
HEAD will give you 2.6 source.

If you are using a setup that relies on -mcpu, I'd look more at changing 
the setup to use something else, since -mcpu is deprecated in gcc for 
mips for all newer toolchains from 3.3 and beyond.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
