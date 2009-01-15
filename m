Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 17:47:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:39032 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365238AbZAORrd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 17:47:33 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496f76ae0000>; Thu, 15 Jan 2009 12:47:26 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:46:41 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:46:40 -0800
Message-ID: <496F7680.2090805@caviumnetworks.com>
Date:	Thu, 15 Jan 2009 09:46:40 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Only allow Cavium OCTEON to be configured for boards
 that support it.
References: <1232041457-28675-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1232041457-28675-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2009 17:46:40.0981 (UTC) FILETIME=[38FE7050:01C97739]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/Kconfig |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
[...]
>  
> +config SYS_HAS_CPU_CPU_CAVIUM_OCTEON
> +	bool
> +

Probably there are too may CPUs in the name.  These are things that are 
only found after mailing the patch.

I will send a fixed patch.

David Daney
