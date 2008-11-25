Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 18:51:47 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:52389 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23911589AbYKYSvh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 18:51:37 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 454EF3EC9; Tue, 25 Nov 2008 10:51:33 -0800 (PST)
Message-ID: <492C4936.2030305@ru.mvista.com>
Date:	Tue, 25 Nov 2008 21:51:34 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492BDB28.8020103@ru.mvista.com> <492C2BCE.60409@caviumnetworks.com>
In-Reply-To: <492C2BCE.60409@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:

>>   Wrong, -DIOR hold time is 5 ns for MWDMA0 as well as for all other 
>> modes.

> Point taken.

    Besides, I'm not sure how useful that timing could be for the host 
controller since it's apparently not determined by the host side -- it's for 
how long the device holds valid data after -DIOR is released IIRC.

WBR, Sergei
