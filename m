Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 09:28:27 +0100 (BST)
Received: from [IPv6:::ffff:213.83.151.3] ([IPv6:::ffff:213.83.151.3]:35529
	"EHLO dk-ex01.thrane.tt.ad") by linux-mips.org with ESMTP
	id <S8225256AbUDBI20>; Fri, 2 Apr 2004 09:28:26 +0100
Received: from murphy.dk ([10.1.6.102]) by dk-ex01.thrane.tt.ad with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 2 Apr 2004 10:27:57 +0200
Message-ID: <406D240C.8020208@murphy.dk>
Date: Fri, 02 Apr 2004 10:27:56 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en, en-ie
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com> <406B2E90.5060307@murphy.dk> <20040401173154.GA30634@linux-mips.org>
In-Reply-To: <20040401173154.GA30634@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2004 08:27:57.0051 (UTC) FILETIME=[66AFECB0:01C4188C]
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Wed, Mar 31, 2004 at 10:48:16PM +0200, Brian Murphy wrote:
>
>  
>
>>Not sure what you mean. I get the panic "Break instruction in kernel 
>>code" from do_bp
>>in traps.c. This seems like a strange "assertion" to me...
>>    
>>
>
>The more information BUG or BUG_ON provide the bigger the kernel gets.
>Using a simple break instruction was simply the smallest thing.  The
>previous, just slightly more verbose BUG() implementation did result
>in ~ 87k of bloat ...
>  
>
Perhaps you could mention this usage of break explicitly in the message 
in do_bp.

/Brian
