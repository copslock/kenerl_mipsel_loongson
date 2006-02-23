Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 09:45:13 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:18595 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133438AbWBWJoz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 09:44:55 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4874671F8F;
	Thu, 23 Feb 2006 10:52:09 +0100 (CET)
Received: from schenk.isar.de (host-82-135-47-202.customer.m-online.net [82.135.47.202])
	by mail.m-online.net (Postfix) with ESMTP id 3E209C06CC;
	Thu, 23 Feb 2006 10:52:09 +0100 (CET)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id k1N9q8a07177;
	Thu, 23 Feb 2006 10:52:09 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (Postfix) with ESMTP id D0232CC267;
	Thu, 23 Feb 2006 10:52:08 +0100 (CET)
Message-ID: <43FD85C8.5040801@rtschenk.de>
Date:	Thu, 23 Feb 2006 10:52:08 +0100
From:	Rojhalat Ibrahim <imr@rtschenk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
References: <20060222190940.GA29967@linux-mips.org>
In-Reply-To: <20060222190940.GA29967@linux-mips.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imr@rtschenk.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imr@rtschenk.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> This one should hopefully fix the SMP problems of the resent times.  It
> works on Malta with 34K, it seems to work on IP27 (the kernel is
> presumably failing due to other issues), so now I'd ask especially
> RM9000 & BCM1250 users for testing.  This really needs to be fixed for
> 2.6.16.
> 
>   Ralf
> 

Works for me with a little fix. You need to set phys_cpu_present_map
in yosemite/smp.c. Therefore the following two lines in the patch
are unnecessary.

> -		cpu_set(i, phys_cpu_present_map);
> +		cpu_set(i, cpu_present_map);

Thanks
Rojhalat Ibrahim
