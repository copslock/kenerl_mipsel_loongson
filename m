Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 01:48:53 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45364 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903739Ab2FYXst (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 01:48:49 +0200
Received: by pbbrq13 with SMTP id rq13so7815759pbb.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jun 2012 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=V34VFadguOQ3iI8BXoR8+xV4RZ0n480FX5iV5jmW2kM=;
        b=HSiu6vYzXZQWx+WFt22QE8/iDWve052oUNFINjOIv1BTXTdK02mqPgqVCiOcAbLzm+
         VwY8Rub/rxsIAL1TtbpZ5tsGIBxoNC18XpqRT4P51DDnAMG3Pqz6xrLHmgyAoXgQRJTa
         VQZuo0aTsIRp7QtfQmj/EFAWNgMVBJ0MBTbTxhO0OqsgVbJcvlt5VmNAfZNhN5OqkknM
         LGniaL56lbbXOx8MbfYDR+xY+U5omeQh12NAtzi6FWvGxKeQWOc36zSoN4EoyfiGgIbw
         g8HcLPD8h8JqvY8Buu+xTe0YbAq+WxYo/KlL+9ZDLw4dJbLqTsOothobZv+kHH+SttIf
         uDyA==
Received: by 10.68.192.97 with SMTP id hf1mr44916886pbc.132.1340668122934;
        Mon, 25 Jun 2012 16:48:42 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id td5sm5170718pbc.74.2012.06.25.16.48.41
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 16:48:42 -0700 (PDT)
Message-ID: <4FE8F8D8.1050009@gmail.com>
Date:   Mon, 25 Jun 2012 16:48:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     ddaney.cavm@gmail.com, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        david.daney@cavium.com
Subject: Re: [PATCH 1/4] netdev/phy: Handle IEEE802.3 clause 45 Ethernet PHYs
References: <1340411056-18988-2-git-send-email-ddaney.cavm@gmail.com>   <20120625.153440.17010814246237639.davem@davemloft.net> <4FE8F01B.2020207@gmail.com> <20120625.163355.2058784474741116830.davem@davemloft.net>
In-Reply-To: <20120625.163355.2058784474741116830.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/25/2012 04:33 PM, David Miller wrote:
> From: David Daney<ddaney.cavm@gmail.com>
> Date: Mon, 25 Jun 2012 16:11:23 -0700
>
>> Do you realize that at the time get_phy_device() is called, there is
>> no PHY device?  So there can be no attribute, nor are we passing a
>> register address.  Neither of these suggestions apply to this
>> situation.
>>
>> We need to know a priori if it is c22 or c45.  So we need to
>> communicate the type somehow to get_phy_device().  I chose an unused
>> bit in the addr parameter to do this, another option would be to add a
>> separate parameter to get_phy_device() specifying the type.
>
> Then pass it in to the get() routine and store the attribute there
> in the device we end up with.

OK.

addr has only 5 significant bits, and the patch *does* pass the 
information (c22 vs. c45) in one of the high order bits.  So it is 
essentially as you say, but you don't like the idea of multiplexing the 
arguments into a single int.

Therefore, I am going to propose that we add a 'flags' parameter to 
get_phy_device() and change the (two) callers.

Does that seem better (or at least acceptable)?

Or do you really want to pass the address of a (one bit) structure instead?

David Daney

>
> There are many parameters that go into a PHY register access, so
> we'll probably some day end up with a descriptor struct that the
> caller prepares on-stack to pass into the actual read/write ops
> via reference.
>
