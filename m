Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 05:23:01 +0000 (GMT)
Received: from mxsf09.insightbb.com ([74.128.0.79]:41084 "EHLO
	mxsf09.insightbb.com") by ftp.linux-mips.org with ESMTP
	id S20023568AbYAPFWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jan 2008 05:22:52 +0000
X-IronPort-AV: E=Sophos;i="4.24,291,1196658000"; 
   d="scan'208";a="215332119"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf09.insightbb.com with ESMTP; 16 Jan 2008 00:22:46 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAMQjjUdKjlCP/2dsb2JhbACBWKtS
X-IronPort-AV: E=Sophos;i="4.24,291,1196658000"; 
   d="scan'208";a="186994857"
Received: from 74-142-80-143.dhcp.insightbb.com (HELO mailhub.coreip.homeip.net) ([74.142.80.143])
  by asav02.insightbb.com with ESMTP; 16 Jan 2008 00:22:45 -0500
Received: from core.corenet.prv (core.corenet.prv [192.168.45.150])
	by mailhub.coreip.homeip.net (Postfix) with ESMTP id 96721526DA2;
	Wed, 16 Jan 2008 00:29:45 -0500 (EST)
Received: by core.corenet.prv (Postfix, from userid 500)
	id 2E5DE167343; Wed, 16 Jan 2008 00:22:44 -0500 (EST)
From:	Dmitry Torokhov <dtor@insightbb.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] I8042: SNI RM support
Date:	Wed, 16 Jan 2008 00:22:42 -0500
User-Agent: KMail/1.9.3
Cc:	linux-input@vger.kernel.org, linux-mips@linux-mips.org
References: <20080112233904.4E149C2F36@solo.franken.de>
In-Reply-To: <20080112233904.4E149C2F36@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801160022.43487.dtor@insightbb.com>
Return-Path: <dtor@insightbb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dtor@insightbb.com
Precedence: bulk
X-list: linux-mips

Hi Thomas,

On Saturday 12 January 2008 18:39, Thomas Bogendoerfer wrote:
> +
> +/*
> + * IRQs.
> + */
> +static int i8042_kbd_irq = -1;
> +static int i8042_aux_irq = -1;

Why initialize with -1 and not leave at 0? Or even initialize with 1/12
and override with 33/44 in i8042_platform_init()?

-- 
Dmitry
