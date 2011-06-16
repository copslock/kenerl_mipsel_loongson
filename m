Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2011 20:29:25 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3821 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491089Ab1FPS3V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jun 2011 20:29:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dfa4bc00000>; Thu, 16 Jun 2011 11:30:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 16 Jun 2011 11:29:18 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 16 Jun 2011 11:29:18 -0700
Message-ID: <4DFA4B7D.7010905@caviumnetworks.com>
Date:   Thu, 16 Jun 2011 11:29:17 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Octeon Ethernet driver
References: <20110616181806.GC19457@ericsson.com>
In-Reply-To: <20110616181806.GC19457@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2011 18:29:18.0067 (UTC) FILETIME=[4D7A4C30:01CC2C53]
X-archive-position: 30428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13805

On 06/16/2011 11:18 AM, Guenter Roeck wrote:
> Hi David,
>
> looks like we'll need to use the Octeon Ethernet driver from SDK 2.0
> or later in our system, for performance reasons. We plan to use 2.6.39,
> so we can not directly use the SDK driver.
>
> Do you (or someone else) have plans to port it to the upstream kernel,
> or do you know if such a port exists ?

I can't really comment on specific plans other than to say that we are 
working towards reducing the divergence between our Octeon SDK and 
upstream kernels.

The existence of any port is irrelevant, what you want is something you 
can use, and I am not aware of anything other that what is currently in 
the drivers/staging.

David Daney
