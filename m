Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 20:12:48 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:57381 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225209AbVDLTMd>; Tue, 12 Apr 2005 20:12:33 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 12 Apr 2005 15:08:05 -0400
Message-ID: <425C1D9D.2070608@timesys.com>
Date:	Tue, 12 Apr 2005 15:12:29 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"Kevin D. Kissell" <kevink@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: another 4kc machine check.
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com> <425AD440.5050600@timesys.com> <004a01c53ed4$dab12b00$10eca8c0@grendel> <Pine.LNX.4.61L.0504121610500.18606@blysk.ds.pg.gda.pl> <00c701c53f7e$09ec56c0$10eca8c0@grendel> <425BFCC2.9060901@timesys.com>
In-Reply-To: <425BFCC2.9060901@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2005 19:08:05.0656 (UTC) FILETIME=[F4E83180:01C53F92]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Greg Weeks wrote:

> No, it adds it before the TLBWR where there shouldn't be a hazard.

On the off chance that the hazard between the TLBWR and the ERET might 
be coming into play I tried a kernel with 3 nops between the TLBWR and 
ERET and no EHB before the TLBWR and it still machine checks for me.

Greg Weeks
