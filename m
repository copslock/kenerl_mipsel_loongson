Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 03:34:08 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:34311
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226078AbVF3Cdr>;
	Thu, 30 Jun 2005 03:33:47 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 29 Jun 2005 19:34:54 -0700
Message-ID: <42C359F8.4060000@avtrex.com>
Date:	Wed, 29 Jun 2005 19:33:28 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"M. Warner Losh" <imp@bsdimp.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
References: <42C1C6EA.5080709@avtrex.com>	<42C34C4D.9020902@avtrex.com> <20050629.195743.48512936.imp@bsdimp.com>
In-Reply-To: <20050629.195743.48512936.imp@bsdimp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2005 02:34:54.0140 (UTC) FILETIME=[4C3AB7C0:01C57D1C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

M. Warner Losh wrote:
> In message: <42C34C4D.9020902@avtrex.com>
>             David Daney <ddaney@avtrex.com> writes:
> : Does anyone have any idea what would cause 1000mS delay?
> 
> That's remarkably close to 1s.  This often indicates that the transmit
> of your next packet is causing the receive buffer to empty.  This is
> usually due to blocked interrupts, or a failure to enable interrupts.
> 

But I observe ever increasing counts for the device in /proc/interrupts. 
  So the interrupts are working somewhat.

David Daney
