Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 21:03:33 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:22952 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039034AbXBWVD2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Feb 2007 21:03:28 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B31A53EC9; Fri, 23 Feb 2007 13:02:55 -0800 (PST)
Message-ID: <45DF5679.5090908@ru.mvista.com>
Date:	Sat, 24 Feb 2007 00:02:49 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
References: <45DF5438.1040706@pmc-sierra.com>
In-Reply-To: <45DF5438.1040706@pmc-sierra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:

>> > +config PMC_MSP_UNCACHED
>> > +     bool "Run uncached"
>> > +     select MIPS_UNCACHED
>> > +    
>> > +endmenu
>> > +

>>    Erm, was there really a need for separate option?

> Are you aware of an existing option to accomplish the same
> results? I have not found it.

    How's that when you're using it! "Run uncached" is in the "Kernel hacking" 
menu.

> Marc

WBR, Sergei
