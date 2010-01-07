Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 21:37:43 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:3786 "HELO
        imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with SMTP id S1492771Ab0AGUhk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 21:37:40 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
        by imap.sh.mvista.com (Postfix) with SMTP
        id 1FD3E3ECA; Thu,  7 Jan 2010 12:37:31 -0800 (PST)
Message-ID: <4B4645EE.5050302@ru.mvista.com>
Date:   Thu, 07 Jan 2010 23:37:02 +0300
From:   Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 1/7] MIPS: Octeon: Fix EIO handling.
References: <4B463005.8060505@caviumnetworks.com> <1262891106-32146-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1262891106-32146-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 25542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5221

Hello.

David Daney wrote:

> If an interrupt handler disables interrupts, the EOI function will
> just reenable them.  This will put us in an endless loop when the
> upcoming Ethernet driver patches are applied.
>
> Only reenable the interrupt on EOI if it is not IRQ_DISABLED.  This
> requires that the EIO function be separate from the ENABLE function.
> We also rename the ACK functions to correspond with their function.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>   

   I guess the subject should read "EIO", not "EIO"...

WBR, Sergei
