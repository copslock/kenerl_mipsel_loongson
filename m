Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 17:40:40 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:58424 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S525251AbYC0Qkf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2008 17:40:35 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 67BB93EC9; Thu, 27 Mar 2008 09:40:03 -0700 (PDT)
Message-ID: <47EBCE38.5070503@ru.mvista.com>
Date:	Thu, 27 Mar 2008 19:41:28 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Nico Coesel <ncoesel@DEALogic.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: FW: Alchemy power managment code.
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF985@dealogicserver.DEALogic.nl>
In-Reply-To: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF985@dealogicserver.DEALogic.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Nico Coesel wrote:

>>    BTW, for anybody interested in Alchemy PM code, here's 
>>the interesting
>>link: [ftp|http]://ftp.enneenne.com/pub/misc/au1100-patches/linux/.
>>    It contains  a lot of unmerged PM patches by Rodolfo 
>>Giometti (and not only that) from around 2.6.17 time.

> Sergei,
> Is there a reason why these patches didn't make it into the official
> kernel? IIRC Rodolfo has been quite active on this mailing list.

    Keywords are "on this mailing list" -- most of his patches were for other 
mailing lists (e.g. he did much to support PM in the peripheral drivers but 
never pushed that stuff to the respective maintainers AFAIK). He just wasn't 
consistent about the upstream submission.

> Nico Coesel

WBR, Sergei
