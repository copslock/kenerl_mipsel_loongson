Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 16:37:20 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13070 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22013901AbYJUPhQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Oct 2008 16:37:16 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48fdf6ce0000>; Tue, 21 Oct 2008 11:35:42 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Oct 2008 08:35:40 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Oct 2008 08:35:40 -0700
Message-ID: <48FDF6CB.4070605@caviumnetworks.com>
Date:	Tue, 21 Oct 2008 08:35:39 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
References: <48F51114.2010105@caviumnetworks.com>	<20081020141750.d0610586.akpm@linux-foundation.org> <20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
In-Reply-To: <20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2008 15:35:40.0274 (UTC) FILETIME=[AC1F3D20:01C93392]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
>> But yes, copying a spinlock by value is quite wrong.  Perhaps we could
>> retain the struct assigment and then run spin_lock_init() to get the
>> spinlock into a sane state?
> 
> Kind of irrelevant now however, the split of patches that caused the
> original bug is over and the NR_IRQ removal patch half of it hit Linus
> tree.
> 
My original patch fixed *two* problems.  As you note here, you already fixed the first one.

As far as I know, the second problem is still present, and that is what akpm was referring to above.  Several days ago I posted a revised patch for this here:

http://marc.info/?l=linux-serial&m=122408950013741&w=2

The question is:  What is the best way to initialize some (or all) fields of a structure *except* a single lock field that was previously initialized?

We can just copy field by field as my patch does, or you could do something ugly using memcpy on portions of the structure.  In this case we know which structure elements will be used by the early console, so I just copied them.

Any comments about that patch are certainly most welcome.

Thanks,
David Daney
