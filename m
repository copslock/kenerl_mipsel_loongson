Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 16:48:24 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:29968
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3465672AbVJEPsF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 16:48:05 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 5 Oct 2005 08:48:02 -0700
Message-ID: <4343F5B2.3020509@avtrex.com>
Date:	Wed, 05 Oct 2005 08:48:02 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix warning in tlbex.c for CONFIG_32BIT
References: <4343586E.4030703@avtrex.com> <20051005105336.GH2699@linux-mips.org>
In-Reply-To: <20051005105336.GH2699@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2005 15:48:02.0848 (UTC) FILETIME=[2B610A00:01C5C9C4]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Oct 04, 2005 at 09:37:02PM -0700, David Daney wrote:
> 
>>Date:	Tue, 04 Oct 2005 21:37:02 -0700
>>From:	David Daney <ddaney@avtrex.com>
>>To:	linux-mips@linux-mips.org
>>Subject: [PATCH] fix warning in tlbex.c for CONFIG_32BIT
>>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
>                                                 ^^^^^^^^^^^^^
> 
> Applied - BUT: your mailer garbles patches ...
> 

Some people on this list are quite adamant that patches be in-line.

I was trying to see how my mailer (Thunderbird) handled this.  Obviously 
  (in hindsight) it screws things up.

Sending as an attachment works well except some mailers (Not 
Thunderbird) cannot quote attached patches with out jumping through hoops.

I don't really want to change the mailer that I am using, so I am in a 
bit of a bind WRT submitting patches here.

FWIW other mailing lists (binutils, gcc) don't seem to have the same 
trouble with attached patches.

David Daney
