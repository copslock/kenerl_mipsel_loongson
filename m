Received:  by oss.sgi.com id <S553938AbQKHNxj>;
	Wed, 8 Nov 2000 05:53:39 -0800
Received: from boco.fee.vutbr.cz ([147.229.9.11]:25106 "EHLO boco.fee.vutbr.cz")
	by oss.sgi.com with ESMTP id <S553853AbQKHNxY>;
	Wed, 8 Nov 2000 05:53:24 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.1/8.11.1) with ESMTP id eA8DrJf61423
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Wed, 8 Nov 2000 14:53:20 +0100 (CET)
Received: (from xmichl03@localhost)
	by fest.stud.fee.vutbr.cz (8.11.0/8.11.0) id eA8DrJr40551;
	Wed, 8 Nov 2000 14:53:19 +0100 (CET)
From:   Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Date:   Wed, 8 Nov 2000 14:53:19 +0100 (CET)
X-processed: pine.send
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: setenv eaddr
In-Reply-To: <20001108045804.A12999@bacchus.dhis.org>
Message-ID: <Pine.BSF.4.05.10011081443420.40049-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 8 Nov 2000, Ralf Baechle wrote:

> The -p option doesn't work for the eaddr variable.  

You are right, of course :-) Perhaps you didn't read my post carefully. I
was talking about -f option (as shown in example), which definitely works
on my indy.

> Hey, SGI didn't want it's customers to arbitrarily change serial
> numbers of the machine ...

Hmm, as I already wrote, after kernel crash I was left with incorectly
set eaddr variable and I was unable to boot anything :-< I only set eaddr
to its original value by this pretty simple way. So no arbitrarily change,
but repair to original state. 

Regards
Lada.
