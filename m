Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 12:19:41 +0100 (BST)
Received: from firewall.spacetec.no ([IPv6:::ffff:192.51.5.5]:16163 "EHLO
	spacetec.no") by linux-mips.org with ESMTP id <S8225240AbTFLLTj>;
	Thu, 12 Jun 2003 12:19:39 +0100
Message-Id: <200306121119.h5CBJWqC027855@pallas.spacetec.no>
From: tor@spacetec.no (Tor Arntsen)
Date: Thu, 12 Jun 2003 13:19:29 +0200
In-Reply-To: Trevor Woerner <mips081@vtnet.ca>
       "64-bit sysinfo" (Jun 12, 12:05)
To: mips081@vtnet.ca, linux-mips@linux-mips.org
Subject: Re: 64-bit sysinfo
Return-Path: <tor@spacetec.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tor@spacetec.no
Precedence: bulk
X-list: linux-mips

On Jun 12, 12:05, Trevor Woerner wrote:
[...]
>I compiled a 64-bit MIPS kernel, then built a busybox-based ramdisk. At 
>first I couldn't get busybox's 'init' to work but later solved it by 
>disabling the 'check_memory()' call.
>
>Further investigation into why the 'check_memory()' call was failing 
>revealed a problem with the 'sysinfo()' system call. The kernel is 
>64-bit, therefore when it fills in the 'struct sysinfo' (as it does 
>when 'sys_meminfo()' is called) unsigned int's are 64 bits. But back in 
>userspace, the 'struct sysinfo' that gets allocated thinks that 
>unsigned int's are 32 bits.
[...]

Hm, that sounds wrong to me. 'int' is supposed to be 32 bits also on
64-bit systems, only 'long' should be 64 bits.

-Tor
