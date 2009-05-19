Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 17:16:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51291 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024619AbZESQQy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 17:16:54 +0100
Date:	Tue, 19 May 2009 17:16:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux kernel <linuxk3rnel@gmail.com>
cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Feasibility study: Linux on core 0, using other cores as worker
  cores. Octeon II
In-Reply-To: <29f1ba300905190458y44c8aadeuc8ff914e09105a09@mail.gmail.com>
Message-ID: <alpine.LFD.1.10.0905191710460.7037@ftp.linux-mips.org>
References: <29f1ba300905190458y44c8aadeuc8ff914e09105a09@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 19 May 2009, linux kernel wrote:

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
> Is there an existing system design in the kernel already that I can
> expand/use ? Perhaps expanding/porting the cell blade IPC method.
> What would you guys think would be the most efficient approach(and
> perhaps would be acceptable to the LK maintainers for merging at a
> later stage :) )  ?

 I'm not sure if there is a ready to use implementation available 
anywhere, but what you've described is one of the proposed use models for 
the MIPS 34K core.  Of course the method of communication would differ.  
You may want to search the Internet to see if you can find anything 
relevant.  Since the Octeon is a MIPS architecture implementation too I've 
cc-ed the linux-mips list, where you might be able to get additional 
responses; also about the 34K.

  Maciej
