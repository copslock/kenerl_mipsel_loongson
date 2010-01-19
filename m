Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2010 02:07:37 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13098 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493086Ab0ATBHb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2010 02:07:31 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b56449d0000>; Tue, 19 Jan 2010 15:47:46 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 19 Jan 2010 15:47:34 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 19 Jan 2010 15:47:34 -0800
Message-ID: <4B564496.3090509@caviumnetworks.com>
Date:   Tue, 19 Jan 2010 15:47:34 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     myuboot@fastmail.fm
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: loadable kernel module link failure -  endianness incompatible
 with that of the selected emulation
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <4AD906D8.3020404@caviumnetworks.com> <1263930694.9779.1355491925@webmail.messagingengine.com>
In-Reply-To: <1263930694.9779.1355491925@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2010 23:47:34.0914 (UTC) FILETIME=[C62C2620:01CA9961]
X-archive-position: 25616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12934

myuboot@fastmail.fm wrote:
> I got a link error when compiling 2 loadable kernel modules -
> "endianness incompatible with that of the selected emulation". 
> 
> But both kernel and the kernel modules of error are in big endian. I
> don't know what I should check or fix. Any suggestions? I checked the
> endianess of the kernel by checking the elf header of vmlinux file, is
> that the right way to do it?
> 
> Below are the error info and the readelf output, showing both the kernel
> and a kernel module are in big endian.
> Thanks for your help. Andrew
> 
> 1) error log 
> make -C /home/root123/sources/kernel/linux
> CROSS_COMPILE=""/home/root123/sources/gcc3.4.3-be"/bin/mips-linux-"
> M=/home/root123/sources/sdk/platform/src/linux/mxp/src modules    
> 
>   LD [M]  /home/root123/sources/sdk/platform/src/linux/mxp/src/mxpmod.o
> /home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld:
> /home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o:
> compiled for a big endian system and target is little endian
> /home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld:
> /home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o:
> endianness incompatible with that of the selected emulation
> /home/root123/sources/gcc3.4.3-be/bin/mips-linux-ld: failed to merge
> target specific data of file
> /home/root123/sources/sdk/platform/src/linux/mxp/src/mmxpcore.o
> make[13]: ***
> [/home/root123/sources/sdk/platform/src/linux/mxp/src/mxpmod.o] Error 1
> 

Looks like a toolchain bug/configuration-problem.  Hard to tell though 
as you didn't pass 'V=1' on the make invocation line.

David Daney
