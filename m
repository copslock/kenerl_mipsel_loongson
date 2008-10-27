Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 18:34:14 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:62480 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22435274AbYJZSeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Oct 2008 18:34:08 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4904b8120000>; Sun, 26 Oct 2008 14:33:54 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Oct 2008 11:33:50 -0700
Received: from [192.168.111.195] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Oct 2008 11:33:50 -0700
Message-ID: <49051A78.8080601@caviumnetworks.com>
Date:	Sun, 26 Oct 2008 18:33:44 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080829 Iceape/1.1.12 (Debian-1.1.12-1)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	ddaney@caviumnetworks.com, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 35/37] Set c0 status for ST0_KX on Cavium OCTEON.
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-36-git-send-email-ddaney@caviumnetworks.com> <20081026124821.GN25297@linux-mips.org>
In-Reply-To: <20081026124821.GN25297@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2008 18:33:50.0448 (UTC) FILETIME=[64071700:01C93799]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

>> -#ifdef CONFIG_64BIT
>> +#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_CAVIUM_OCTEON)
>> +	/*
>> +	 * Note: We always set ST0_KX on Octeon since IO addresses are at
>> +	 * 64bit addresses. Keep in mind this also moves the TLB handler.
>> +	 */
>>  	setup_c0_status ST0_KX 0
> 
> That's a bit odd - on 64-bit kernels KX would be set anyway and on 32-bit
> kernels would be corrupted by exceptions or interrupts, so 64-bit
> addresses are not safe to use on 32-bit kernels for most part.
> 
> 32-bit virtual addresses mapped to a non-compat address otoh will work fine
> without KX set.
> 
>   Ralf

The Octeon IO space regions are significantly larger than a 32bit kernel
could tlb map easily. The entire range takes 49 bits to address. As a
not particularly clean, but working alternative, we enable 64bit
addressing in the kernel and used XKPHYS to access IO. Every access was
surrounded by a local_irq_save/local_irq_restore. Since this is ugly to
the extreme, maybe we should drop being able to boot a 32bit kernel on
Octeon until something better is worked out.

Chad
