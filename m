Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2009 20:18:25 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2857 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492698AbZIISSR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Sep 2009 20:18:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4aa7f12f0004>; Wed, 09 Sep 2009 14:17:19 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Sep 2009 11:17:23 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Sep 2009 11:17:23 -0700
Message-ID: <4AA7F133.20104@caviumnetworks.com>
Date:	Wed, 09 Sep 2009 11:17:23 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Dok Sander <doksander@yahoo.com>
CC:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: io.h doesn't get installed by target "headers_install" for mips
References: <806810.23677.qm@web59313.mail.re1.yahoo.com>
In-Reply-To: <806810.23677.qm@web59313.mail.re1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2009 18:17:23.0636 (UTC) FILETIME=[C7340740:01CA3179]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Dok Sander wrote:
> Hi,
> 
>  I noticed the absence of the header io.h while trying to build(cross-compile, host i686-pc-linux-gnu) a software(lm-sensors-3.1.1, wants io.h in /sys) for mips. I can find io.h for mips in arch/mips/asm/include/{,sn/} However, io.h doesn't get installed when i do "make ARCH=mips headers_install" on linux 2.6.30.6
> 
>  According to someone on the eglibc mailing list, linux should provide io.h for mips. Is this true?
> 

I don't think so (for two reasons):

1) The things in /usr/include/sys are provided by libc not the kernel.

2) MIPS doesn't have I/O ports, so all the functions in sys/io.h on an 
x86 are undefined for MIPS.

David Daney
