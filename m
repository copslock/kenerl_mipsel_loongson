Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 16:05:33 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:10398 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20039182AbXBBQFa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 16:05:30 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id A80C82981F0;
	Fri,  2 Feb 2007 11:04:49 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri,  2 Feb 2007 11:04:49 -0500 (EST)
Received: from [127.0.0.1] ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Feb 2007 08:04:48 -0800
Message-ID: <45C3611D.7000702@avtrex.com>
Date:	Fri, 02 Feb 2007 08:04:45 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>	 <20070201135734.GB12728@linux-mips.org>	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>	 <45C21CFE.9060804@avtrex.com> <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
In-Reply-To: <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2007 16:04:48.0100 (UTC) FILETIME=[DCE71240:01C746E3]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> On 2/1/07, David Daney <ddaney@avtrex.com> wrote:
>> I don't think *any* registers *need* to be saved on sys_sigreturn().
>> The values in sigcontext on the user stack associated with the system
>> call are all used instead of the actual register values.
>>
>
> Sorry but I don't understand what you mean. Could you explain ?
sys_sigreturn does not return to the caller in the conventional sense.  
The entire user context (i.e. the value of *all* registers) is replaced 
with the values stored in the sigcontext structure on the caller's 
stack.  If all registers are being restored from the sigcontext, then 
there is no need to save the current values of the registers, because 
they will never be used.

David Daney
