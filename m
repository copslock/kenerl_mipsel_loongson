Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 23:16:41 +0100 (CET)
Received: from cantor.suse.de ([195.135.220.2]:37164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492094Ab0AGWQh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Jan 2010 23:16:37 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 6E8596CB00;
        Thu,  7 Jan 2010 23:16:34 +0100 (CET)
Date:   Thu, 7 Jan 2010 13:59:50 -0800
From:   Greg KH <gregkh@suse.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Sergei Shtylyov <sshtylyov@ru.mvista.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/7] MIPS: Octeon: Fix EIO handling.
Message-ID: <20100107215950.GA24672@suse.de>
References: <4B463005.8060505@caviumnetworks.com> <1262891106-32146-1-git-send-email-ddaney@caviumnetworks.com> <4B4645EE.5050302@ru.mvista.com> <4B464977.2090801@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B464977.2090801@caviumnetworks.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-archive-position: 25546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5295

On Thu, Jan 07, 2010 at 12:52:07PM -0800, David Daney wrote:
> Sergei Shtylyov wrote:
>> Hello.
>>
>> David Daney wrote:
>>
>>> If an interrupt handler disables interrupts, the EOI function will
>>> just reenable them.  This will put us in an endless loop when the
>>> upcoming Ethernet driver patches are applied.
>>>
>>> Only reenable the interrupt on EOI if it is not IRQ_DISABLED.  This
>>> requires that the EIO function be separate from the ENABLE function.
>>> We also rename the ACK functions to correspond with their function.
>>>
>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>>   
>>
>>   I guess the subject should read "EIO", not "EIO"...
>>
>
> Indeed.  The compiler didn't catch that one.
>
> Perhaps Ralf can fix it if he merges it, otherwise I can resubmit with 
> corrected spelling.

I can change it when merging, don't worry about it.

thanks,

greg k-h
