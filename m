Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 14:51:42 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:25650
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225203AbVAFOvi>; Thu, 6 Jan 2005 14:51:38 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CmYyu-0005Jb-00; Thu, 06 Jan 2005 15:51:20 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CmYyt-00078U-00; Thu, 06 Jan 2005 15:51:19 +0100
Date: Thu, 6 Jan 2005 15:51:19 +0100
To: Mudeem Iqbal <mudeem@Quartics.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: mipes-linux-ld: final link failed: Bad value
Message-ID: <20050106145119.GN4017@rembrandt.csv.ica.uni-stuttgart.de>
References: <1B701004057AF74FAFF851560087B16106469D@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B701004057AF74FAFF851560087B16106469D@1aurora.enabtech>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Mudeem Iqbal wrote:
> hi,
> 
> I have built a toolchain using the following combination
> 
> binutils-2.15
> gcc-3.4.3
> glibc-2.3.3
> linux-2.6.9	(from linux-mips.org)
> 
> I am cross compiling linux kernel for mips. I think the toolchain has been
> successfully built. But when cross compiling the kernel I get the following
> error
> 
>   CC      mm/fremap.o
> mipsel-linux-ld: final link failed: Bad value
> make[1]: *** [mm/fremap.o] Error 1

A _final_ link for mm/fremap.o sounds like a broken cc invocation
in mm/Makefile (does it miss the '-c' somehow?).


Thiemo
