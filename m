Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:22:14 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:42715 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133767AbWBTOVl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:21:41 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 8789E706AF;
	Mon, 20 Feb 2006 15:28:38 +0100 (CET)
Received: from schenk.isar.de (host-82-135-47-202.customer.m-online.net [82.135.47.202])
	by mail.m-online.net (Postfix) with ESMTP id 6BE41936AF;
	Mon, 20 Feb 2006 15:28:38 +0100 (CET)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id k1KESca00985;
	Mon, 20 Feb 2006 15:28:38 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (Postfix) with ESMTP id 01DEE9CA10;
	Mon, 20 Feb 2006 15:28:37 +0100 (CET)
Message-ID: <43F9D215.3090506@rtschenk.de>
Date:	Mon, 20 Feb 2006 15:28:37 +0100
From:	Rojhalat Ibrahim <imr@rtschenk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: Tracking down exception in sched.c
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de> <43F9C58E.4020606@mips.com>
In-Reply-To: <43F9C58E.4020606@mips.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imr@rtschenk.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imr@rtschenk.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> The "for" loop is what used to be there, but if you use it in
> a system with "hot-pluggable" CPUs, I could imagine that there
> would be problems.  While for_each_cpu is pathetically inefficient
> as it gets expanded and compiled for MIPS, if your phys_cpu_present_map
> (which is by default what gets used in MIPS as cpu_possible_map
> for the purposes of sched.c) is being properly initialized and
> maintained, the behavior of the two loops should be the same.
> Have you double-checked that?  Secondary CPUs turn generally
> set their bits in that mask in prom_build_cpu_map().
> 

The behavior of the two loops is not the same because sched_init
is called long before smp_prepare_cpus. Therefore for_each_cpu
only loops once for CPU 0. I know this is not a great fix.
I simply reverted the code to what's worked before.

Rojhalat Ibrahim
