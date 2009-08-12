Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2009 23:24:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:37406 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493617AbZHLVYg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2009 23:24:36 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a8332bc0000>; Wed, 12 Aug 2009 17:23:08 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 12 Aug 2009 14:22:52 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 12 Aug 2009 14:22:52 -0700
Message-ID: <4A8332AB.20105@caviumnetworks.com>
Date:	Wed, 12 Aug 2009 14:22:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	=?ISO-8859-15?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: MIPS: Avoid clobbering struct pt_regs in kthreads
References: <4A832E6E.8020300@rw-gmbh.de>
In-Reply-To: <4A832E6E.8020300@rw-gmbh.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2009 21:22:52.0254 (UTC) FILETIME=[0CCF5FE0:01CA1B93]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Rösch wrote:
> Hi David,
> 
> Sorry to say, but your commit d406c9ae84d6ef12c55a41c97c34266b2eb7ed31 
> makes my TX49xx (Toshiba RISC mipsel) based system unusable.
> 
> The kernel boots fine until the stage:
>    Freeing unused kernel memory: 140k freed
> and then stops.
> Some of our LEDS are updated as supposed, so a part of the kernel should 
> be running.
> 
> Reverting your commit makes the latest 2.4.37.4 kernel usable again.
> Do you have an idea what might go wrong?
> 

I'm sorry, I can't think of anything.

I would look in copy_thread and the kthread spawning code.  Does TX49xx 
have custom versions of these?

David Daney
