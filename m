Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 17:31:22 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:31309 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365776AbZANRbU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Jan 2009 17:31:20 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496e21560004>; Wed, 14 Jan 2009 12:31:02 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 09:30:52 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 09:30:52 -0800
Message-ID: <496E214C.4090206@caviumnetworks.com>
Date:	Wed, 14 Jan 2009 09:30:52 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250: Initialize more fields in early_serial_setup.
References: <1231879604-30140-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1231879604-30140-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2009 17:30:52.0284 (UTC) FILETIME=[D91D03C0:01C9766D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> The initial patch that initialized the fields individually omitted a
> couple that evidently are required by mips/rb532.  This should fix it.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/serial/8250.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 1889a63..e2c3a85 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2837,6 +2837,8 @@ int __init early_serial_setup(struct uart_port *port)
>  	p->regshift     = port->regshift;
>  	p->iotype       = port->iotype;
>  	p->flags        = port->flags;
> +	p->type		= port->type;
> +	p->line		= port->line;
>  	p->mapbase      = port->mapbase;
>  	p->private_data = port->private_data;
>  
Some one got to this before I did.  Linus already committed a 
substantially similar patch as  125c97d8a59888c5678734c2b70cbd08c847bd99

David Daney
