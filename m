Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 21:39:41 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:57784 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20023133AbXC1Ujj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 21:39:39 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 1677F29D29C;
	Wed, 28 Mar 2007 20:38:56 +0000 (GMT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 28 Mar 2007 20:38:55 +0000 (GMT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Mar 2007 13:38:55 -0700
Message-ID: <460AD25F.9090306@avtrex.com>
Date:	Wed, 28 Mar 2007 13:38:55 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
References: <36E4692623C5974BA6661C0B18EE8EDF6CD5B2@MAILSERV.hcrest.com> <460AA1A0.1050508@avtrex.com> <20070328203459.GB12955@linux-mips.org>
In-Reply-To: <20070328203459.GB12955@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2007 20:38:55.0432 (UTC) FILETIME=[1A954480:01C77179]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Mar 28, 2007 at 10:10:56AM -0700, David Daney wrote:
> 
>> Would you mind posting your patch to this list?
>>
>> There are some of us that are using the same processor you are that 
>> could find this helpful.
> 
> You only need this patch for kernels older than last week's -2.6.16-stable.
> That is linux-2.6.16-stable, linux-2.6.17-stable have it applied.
> 

Thanks, I know this.  It turns out that I am working with the exact 
processor/kernel that Ravi is, so his patch could be useful to me.

David Daney
