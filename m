Received:  by oss.sgi.com id <S553661AbQJQXRa>;
	Tue, 17 Oct 2000 16:17:30 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:12017 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553648AbQJQXRN>;
	Tue, 17 Oct 2000 16:17:13 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9HNFnx26468;
	Tue, 17 Oct 2000 16:15:53 -0700
Message-ID: <39ED40B4.EEB5F444@mvista.com>
Date:   Tue, 17 Oct 2000 23:18:28 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: 16K page size?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Has anybody tried that before?

I wonder if it is just as simple as changing PAGE_SHIFT from 12 to 14 in
include/asm-mips/page.h.  

I remember I have seen many places in kernel and drivers that assume 4k
page size (perhaps minimum 4k page size in reality.)  What about glibc? 
Does it assume any page size?

Thanks.

Jun
