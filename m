Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 21:13:45 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:30056 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207732AbYLJVNf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Dec 2008 21:13:35 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494030e70000>; Wed, 10 Dec 2008 16:13:11 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 13:13:10 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 13:13:10 -0800
Message-ID: <494030E6.1040002@caviumnetworks.com>
Date:	Wed, 10 Dec 2008 13:13:10 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Update ip32_defconfig.
References: <49400169.8090605@caviumnetworks.com>
In-Reply-To: <49400169.8090605@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2008 21:13:10.0412 (UTC) FILETIME=[1ACC94C0:01C95B0C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> This is the config I am running on my ip32 (O2).  It seems to work
> well.
> 
>
[...]
> -CONFIG_LOCALVERSION=""
> +CONFIG_LOCALVERSION="-DDmaster"
> CONFIG_LOCALVERSION_AUTO=y

Well that part may not be appropriate for the default.

David Daney
