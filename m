Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Mar 2005 23:43:03 +0000 (GMT)
Received: from 63-207-7-10.ded.pacbell.net ([IPv6:::ffff:63.207.7.10]:20221
	"EHLO cassini.enmediainc.com") by linux-mips.org with ESMTP
	id <S8224947AbVCJXmr>; Thu, 10 Mar 2005 23:42:47 +0000
Received: from [127.0.0.1] (unknown [192.168.10.203])
	by cassini.enmediainc.com (Postfix) with ESMTP
	id 0181E25C95F; Thu, 10 Mar 2005 15:42:45 -0800 (PST)
Message-ID: <4230DB4C.7090103@c2micro.com>
Date:	Thu, 10 Mar 2005 15:42:04 -0800
From:	Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Steve Stone <stone@c2micro.com>
Subject: initrd problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <martini@c2micro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martini@c2micro.com
Precedence: bulk
X-list: linux-mips

Background:

I'm trying to get 2.6.11 to run on a MIPS Malta board with Yamon.  The 
kernel that comes with the board is 2.4.18 with an embedded ramdisk that 
runs some scripts to install RPMS via NFS or CD-ROM.  The kernel is 
converted to s-records via objcopy(1), and loaded into memory via tftp.  
I want to do something similar with 2.6.latest.

Problem:

On or about Nov 21 of last year, the CONFIG_EMBEDDED_RAMDISK disappeared.

http://www.linux-mips.org/archives/linux-mips/2004-11/msg00135.html

In it's place it is suggested to use the tools in arch/mips/boot, so I 
tried it.  I can cross-compile the kernel, and I get an ELF vmlinux.  I 
can convert it to ecoff with elf2ecoff, and attach an initrd image with 
addinitrd.  The problem begins here.  I end up with an ecoff format 
kernel which is not recognized by objcopy(1), and therefore no s-records.

It seems there is a program called gensrec that would do the job, but 
google doesn't want to tell me where to get it.  Some IRIX binary perhaps?

Solution?

Should I put CONFIG_EMBEDDED_RAMDISK and its ilk back into my kernel, or 
write an ELF version of addinitrd?  Other ideas?

Thanks in advance.
