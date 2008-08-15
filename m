Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 18:16:57 +0100 (BST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:64695 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28576021AbYHORQw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Aug 2008 18:16:52 +0100
X-IronPort-AV: E=Sophos;i="4.32,216,1217808000"; 
   d="scan'208";a="41702202"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-5.cisco.com with ESMTP; 15 Aug 2008 17:16:44 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m7FHGivS031533;
	Fri, 15 Aug 2008 10:16:44 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m7FHGiHO026063;
	Fri, 15 Aug 2008 17:16:44 GMT
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA07620; Fri, 15 Aug 2008 17:16:33 GMT
Message-ID: <48A5B9F1.3080201@sciatl.com>
Date:	Fri, 15 Aug 2008 10:16:33 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, jfraser@broadcom.com,
	Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz> <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de> <1218815299.23641.80.camel@nimitz> <48A5AADE.1050808@sciatl.com> <20080815163302.GA9846@alpha.franken.de>
In-Reply-To: <20080815163302.GA9846@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results:	sj-dkim-2; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <Michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> On Fri, Aug 15, 2008 at 09:12:14AM -0700, C Michael Sundius wrote:
>   
>> yes,  actually the top two bits are used in MIPS as segment bits.
>>     
>
> you are confusing virtual addresses with physcial addresses. There
> are even 32bit CPU, which could address more than 4GB physical
> addresses via TLB entries.
>
> Thomas.
>
>   
Ah, your right. thanks.  "but it's not necessar*il*y a good idea". That 
is to say, we don't put
memory above 2 GiB. No need to make the mem_section[] array bigger than 
need be.

This gives further credence for it to be a configurable in Kconfig as well.

Mike
