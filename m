Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2008 00:27:14 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:23186 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28601225AbYCDA1M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Mar 2008 00:27:12 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id B6D4031569E;
	Tue,  4 Mar 2008 00:27:17 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue,  4 Mar 2008 00:27:17 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Mar 2008 16:26:57 -0800
Message-ID: <47CC974F.3090306@avtrex.com>
Date:	Mon, 03 Mar 2008 16:26:55 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	James Zipperer <jamesz@modsystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: smp8634 add memory at dram1
References: <2D30722FBBDE6749973243F4F01BE984A242CA@dotexchange.dotcorporation.com>
In-Reply-To: <2D30722FBBDE6749973243F4F01BE984A242CA@dotexchange.dotcorporation.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2008 00:26:57.0316 (UTC) FILETIME=[747BD640:01C87D8E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

James Zipperer wrote:

> 
>  
> 
> I'm running out of memory in linux on the smp86xx and attempting to 
> implement this solution.  Did you ever get it to work?  No luck for me 
> yet.  I'm still a bit unclear why you must switch linux to run off DRAM 
> 1 instead of leaving it on DRAM 0 and adding an additional call to 
> add_memory_region in prom_init for DRAM 1.  But then again, I haven't 
> gotten that to work yet either :)
> 
>  
> 
> Any info/patches are greatly appreciated.  Thanks!
> 
>  
> 

Typically DRAM 1 must be accessed through the TLB as its address lays 
outside of the 512MB window of KSEG[012].

The best way to make this memory available to Linux may still be up for 
debate.

David Daney
