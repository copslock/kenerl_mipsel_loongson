Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 16:28:12 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:62481 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225305AbVINP1w>;
	Wed, 14 Sep 2005 16:27:52 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EFZ9I-0001FL-00; Wed, 14 Sep 2005 16:26:12 +0100
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EFZAJ-0003r7-00; Wed, 14 Sep 2005 16:27:15 +0100
Message-ID: <43284153.1040508@mips.com>
Date:	Wed, 14 Sep 2005 16:27:15 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Git
References: <20050913124544.GC3224@linux-mips.org> <20050913133126.GO23161@lug-owl.de> <20050913152038.GE3224@linux-mips.org> <20050914095858.GD23161@lug-owl.de> <20050914123750.GL3224@linux-mips.org> <20050914152144.GJ23161@lug-owl.de>
In-Reply-To: <20050914152144.GJ23161@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.84,
	required 4, AWL, BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Jan-Benedict Glaw wrote:

>>>To get fixes/port updates/subsystem updates upstream to Linus, GIT is
>>>the way[tm] to go, so we'd try to get familiar with it.
>>>      
>>>
>>The other accepted currency of the trade are still simple patches, see
>>http://www.linux-mips.org/wiki/The_perfect_patch.
>>    
>>
>
>ACK. But unless you've got the perfect Patch Queue Manager that'll
>re-diff and re-send your patches automatically to Linus, you keep on
>doing some manual work or at least starting your scripts ever and ever
>again :)
>
>  
>

Speaking of patch management, has anyone tried out Stacked GIT (aka 
StGIT, aka quilt on GIT) at http://www.procode.org/stgit/? It looks like 
it could be useful, and can be used in conjunction with other porcelain 
like Cogito.

Nigel
