Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 17:44:03 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:43862 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024416AbZESQn4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 17:43:56 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a12e1ab0000>; Tue, 19 May 2009 12:43:23 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 09:43:26 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 09:43:26 -0700
Message-ID: <4A12E1AD.6000302@caviumnetworks.com>
Date:	Tue, 19 May 2009 09:43:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	linux kernel <linuxk3rnel@gmail.com>
CC:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Feasibility study: Linux on core 0, using other cores as worker
 	cores. Octeon II
References: <29f1ba300905190458y44c8aadeuc8ff914e09105a09@mail.gmail.com>
In-Reply-To: <29f1ba300905190458y44c8aadeuc8ff914e09105a09@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2009 16:43:26.0308 (UTC) FILETIME=[EE6A4A40:01C9D8A0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

linux kernel wrote:
> Hi,
> 
> This might seem as an unusal feasibility question, but I would like to
> discuss this here at LKML to hear you views on this matter.
> The idea would be to build a IBM cell blade lookalike architecture,
> using full blown linux on core 0, using the other cores as worker
> threads.
> Possible target CPUs are Octeon II with 32 cores or more.
> 
> The main goal for this would be to reduce interrupt latency for worker
> cores, having them run possibly bare-bone with an IPC method between
> core 0 and worker cores. probably DMA and HW IRQs.
> 

As you may be aware, this is a common use case for current users of 
Octeon SOCs.

> Is there an existing system design in the kernel already that I can
> expand/use ? Perhaps expanding/porting the cell blade IPC method.
> What would you guys think would be the most efficient approach(and
> perhaps would be acceptable to the LK maintainers for merging at a
> later stage :) )  ?

Current Octeon applications, architected as you indicate, typically use 
the SOC's work queue hardware for IPC, but this is via custom drivers, 
not any existing kernel framework.

Since one of my main job functions is kernel development for the Octeon 
family, I would certainly be interested in any work done in this area.


David Daney
