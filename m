Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 15:11:34 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:57737 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225269AbUCPPLd>; Tue, 16 Mar 2004 15:11:33 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B3GDw-0007vr-00; Tue, 16 Mar 2004 09:11:21 -0600
Message-ID: <40571916.6060502@realitydiluted.com>
Date: Tue, 16 Mar 2004 10:11:18 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] missing _raw_write_trylock
References: <20040316070911.B29232@mvista.com>
In-Reply-To: <20040316070911.B29232@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> Please help me reviewing the code, because inline assembly bug is
> always tricky and miserable.  
>
Are you going to do a non-LLSC, or are we no longer concerned about
those?

-Steve
