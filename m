Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 23:19:03 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8113 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026264AbZEMWS4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 23:18:56 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b472c0000>; Wed, 13 May 2009 18:18:20 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 15:17:55 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 15:17:55 -0700
Message-ID: <4A0B4713.7070103@caviumnetworks.com>
Date:	Wed, 13 May 2009 15:17:55 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	paul.gortmaker@windriver.com, David VomLehn <dvomlehn@cisco.com>
Subject: Re: [PATCH 2/2] MIPS: Replace some magic numbers with symbolic values
 in tlbex.c (v2)
References: <1242247717-21324-2-git-send-email-ddaney@caviumnetworks.com> <1242252913-6581-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1242252913-6581-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2009 22:17:55.0403 (UTC) FILETIME=[AA0CA9B0:01C9D418]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips


Well I replied to the wrong message and screwed up the subject.  So
Ignore this one and I will send it again properly

David Daney

David Daney wrote:
> The logic used to split the r4000 refill handler is liberally
> sprinkled with magic numbers.  We attempt to explain what they are and
> normalize them against a new symbolic value (MIPS64_REFILL_INSNS).
> 
> Changes from v1:  Corrected spelling in comment.
> 
> CC: David VomLehn <dvomlehn@cisco.com>
> Reviewed-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> 
> Please use this version instead of the original 2/2.
> 
>  arch/mips/mm/tlbex.c |   34 ++++++++++++++++++++++++++--------
>  1 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 4dc4f3e..cbc09de 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -649,6 +649,14 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
>  #endif
