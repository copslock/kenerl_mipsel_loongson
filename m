Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 22:35:47 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:11591 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225391AbUBMWfq>;
	Fri, 13 Feb 2004 22:35:46 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 13 Feb 2004 14:35:44 -0800
Message-ID: <402D513F.8080205@avtrex.com>
Date: Fri, 13 Feb 2004 14:35:43 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2004 22:35:44.0118 (UTC) FILETIME=[B794A160:01C3F281]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

>Ralf Baechle wrote:
>  
>
>>On Fri, Feb 13, 2004 at 03:20:27PM +0100, Maciej W. Rozycki wrote:
>>
>>    
>>
>>>2. It changes inline-assembly function prologues to be embedded within the
>>>functions, which makes them a bit safer as they can now explicitly refer
>>>to the "regs" struct and assures the code won't be removed or reordered.
>>>      
>>>
>>It is possible that gcc changes one of the registers before save_static
>>and I can't imagine there's a reliable way to fix this in the inline
>>version.
>>    
>>
>
>As long as __asm__ __volatile__ works as documented, this can't happen.
>  
>
My understanding is that with gcc-3.4 that __asm__ __volatile__ does not 
protect against dead code removal.  If the code is not dead __volatile__ 
works as documented, but dead code removal still happens.

David Daney.
