Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2009 01:52:32 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8221 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023636AbZEEAw0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2009 01:52:26 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ff8db40000>; Mon, 04 May 2009 20:52:04 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 May 2009 17:51:56 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 May 2009 17:51:56 -0700
Message-ID: <49FF8DAC.8090701@caviumnetworks.com>
Date:	Mon, 04 May 2009 17:51:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/3] mips:powertv: Integrate Cisco Powertv platform into
 MIPS architecture (resend)
References: <20090504225821.GA22833@cuplxvomd02.corp.sa.net>
In-Reply-To: <20090504225821.GA22833@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2009 00:51:56.0780 (UTC) FILETIME=[B09F22C0:01C9CD1B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> Adds the Cisco PowerTV platform to the configuration and Make files so
> that we can build a kernel for it.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/Kconfig                   |   30 +
>  arch/mips/Makefile                  |    8 +
>  arch/mips/configs/powertv_defconfig | 1484 +++++++++++++++++++++++++++++++++++
>  3 files changed, 1522 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 99f7b6d..b23ec4c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
[...]
>  
> +#
> +# The flag for POWERTV clock source.
> +#
> +config CEVT_POWERTV
> +	bool
> +
>  config CEVT_SB1250
>  	bool
>  
> @@ -742,6 +766,12 @@ config CSRC_R4K
>  	select CSRC_R4K_LIB
>  	bool
>  
> +#
> +# The flag for POWERTV clock event.
> +#
> +config CSRC_POWERTV
> +	bool
> +
>  config CSRC_SB1250
>  	bool
>  

Could/should CEVT_POWERTV and CSRC_POWERTV be either eliminated or moved 
to your processor specific directory?  That is where the corresponding 
code lives.

David Daney
