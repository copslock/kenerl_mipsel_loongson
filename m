Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 12:08:44 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:2628 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225072AbVBQMI3>;
	Thu, 17 Feb 2005 12:08:29 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1HC87H14390;
	Thu, 17 Feb 2005 13:08:07 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1HC87c18392;
	Thu, 17 Feb 2005 13:08:07 +0100
Message-ID: <42148926.8040306@schenk.isar.de>
Date:	Thu, 17 Feb 2005 13:08:06 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	TheNop <TheNop@gmx.net>
CC:	linux-mips@linux-mips.org
Subject: Re: configuration of yosemite board with titan 1.2
References: <42146C27.8080404@gmx.net>
In-Reply-To: <42146C27.8080404@gmx.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Hi,

if you want to use the internal UART, you need an adapted
kernel from PMC. The kernel from linux-mips.org only supports
the external UART chip. You can download an adapted source
archive from the PMC-Sierra ftp site.

Rojhalat Ibrahim


TheNop wrote:
> Hello,
> 
> today i got the yosemite board with titan 1.2.
> Currently I have problems to get the kernel 2.6.10.rc1 running (it runs 
> on the old yosemite quite well).
> The first thing I noticed is that after starting the kernel no output on 
> the console is printed.
> On the new yosemite board I got, the external UART chip (U36) is not 
> mounted anymore. Could that cause my problems?
> 
> Is there anybody how can send my a .config file to get the yosemite 
> working?
> 
> Best regards
> TheNop
> 
> 
