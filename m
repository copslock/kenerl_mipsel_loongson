Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2004 19:33:55 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:65229 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8226077AbUE0Sdn>; Thu, 27 May 2004 19:33:43 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2004052718333201300ffoh0e>
          (Authid: kumba12345);
          Thu, 27 May 2004 18:33:34 +0000
Message-ID: <40B63518.3020509@gentoo.org>
Date: Thu, 27 May 2004 14:36:08 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: help needed : cannot install linux on SGI O2 R5000
References: <200405271333.04712.maksik@gmx.co.uk>
In-Reply-To: <200405271333.04712.maksik@gmx.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Max Zaitsev wrote:

> Hi List,
> 
> couple of days ago I've acquired an oldish O2 box with 180MHz R5k CPU, 256MB 
> ram and ~10GB HD space. Since then I'm trying to get linux installed on that 
> thing, but apparently with no success. I've managed to connect it to a linux 
> box and get bootp() and NFS to work. However, I cannot find a working kernel/
> rootfs combination to proceed. 
> 
> As it follows from the mailing list postings I've read I shall try installing 
> gentoo distribution. However, the binary kernel for net-install from 
> http://dev.gentoo.org/~kumba/mips/netboot/ip32/ does not seem to boot and 
> hangs straight after the download. The same applies to the older kernel image 
> located in the same place.
> 
> What I found to work was the 64 bit binary kernel from glaurung 
> (http://www.linux-mips.org/~glaurung/). It boots nicely, but I have no root 
> partition to go on with. I've tried to use the contents of the initrd image 
> for gentoo netinstall, but it hangs in the busybox after diplaying one line 
> with version information.
> 
> I would like to avoid installing the complete crosscompilation toolchain on my 
> linux box in order to get the recent CVS version of the kernel compiled. 
> Another point is that I have no idea what would be to configuration options 
> to get it to work on my O2. Apparently, it's not straitforward. Can somebody 
> point me a location of the working binary kernel for gentoo install or are 
> there better (or just other) solutions?

The IP32 Netboot I have requires you to setup an NFS-exportable root for 
it to work properly, and it's advised you run off of serial console (if 
you aren't already).  There should be an initrd link in the ip32 
directory -- use that for NFS root, and pass at minimum 'root=/dev/nfs 
console=ttyS0,<baudrate>' (where <baudrate> is the speed your running 
serial console at) after 'bootp(): ', and you should see some data.  If 
you are using serial console, double check to make sure the 
kb/mouse/monitor is unplugged, and the prom var 'console' is set to 'd1'.

See if that gets you anywheres.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
