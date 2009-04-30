Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 21:21:38 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9032 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026733AbZD3UVc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 21:21:32 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49fa08360005>; Thu, 30 Apr 2009 16:21:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Apr 2009 13:21:06 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Apr 2009 13:21:06 -0700
Message-ID: <49FA0831.8060406@caviumnetworks.com>
Date:	Thu, 30 Apr 2009 13:21:05 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	randrik_a@yahoo.com
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 0002-sgi-o2-gbe-mte-init.diff
References: <309181.52579.qm@web59814.mail.ac4.yahoo.com>
In-Reply-To: <309181.52579.qm@web59814.mail.ac4.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2009 20:21:06.0160 (UTC) FILETIME=[30D84F00:01C9C9D1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Andrew Randrianasulu wrote:
> Very simple test patch, broke nothing for me.
> 
> diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
> index ed732a8..1d3b599 100644
> --- a/drivers/video/gbefb.c
> +++ b/drivers/video/gbefb.c

Are all these patch passing checkpatch.pl?  I see no Signed-off-by: headers.

David Daney
