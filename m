Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2008 01:31:18 +0000 (GMT)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:40868 "EHLO
	tyo201.gate.nec.co.jp") by ftp.linux-mips.org with ESMTP
	id S24039960AbYLBBbN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Dec 2008 01:31:13 +0000
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mB21UnuJ019279;
	Tue, 2 Dec 2008 10:30:52 +0900 (JST)
Received: from realmbox11.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay21.aps.necel.com with ESMTP; Tue, 2 Dec 2008 10:30:52 +0900
Received: from [10.114.181.65] ([10.114.181.65] [10.114.181.65]) by mbox02.aps.necel.com with ESMTP; Tue, 2 Dec 2008 10:30:52 +0900
Message-Id: <49348FCC.1050404@necel.com>
Date:	Tue, 02 Dec 2008 10:30:52 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 5/5] Serial: UART driver changes for Cavium OCTEON.
References: <492C94FC.9070906@caviumnetworks.com> <1227658719-18297-5-git-send-email-ddaney@caviumnetworks.com> <492F6525.9010308@necel.com> <4934303F.1000509@caviumnetworks.com>
In-Reply-To: <4934303F.1000509@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> ... All our boards are now working with no extra bug flags needed.  So I 
> will simplify this patch set by getting rid of UART_BUG_TIMEOUT.

Great! and makes sense.  Thank you for taking care of my comments.  I've
also checked the serial patches of version 2, and they looks in good
shape.

-- 
Shinya Kuribayashi
NEC Electronics
