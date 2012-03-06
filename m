Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2012 00:08:54 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:61035 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab2CFXIh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2012 00:08:37 +0100
Received: by yhjj52 with SMTP id j52so2863435yhj.36
        for <multiple recipients>; Tue, 06 Mar 2012 15:08:30 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.60.12.8 as permitted sender) client-ip=10.60.12.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.60.12.8 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.60.12.8])
        by 10.60.12.8 with SMTP id u8mr12060860oeb.60.1331075310725 (num_hops = 1);
        Tue, 06 Mar 2012 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ad1pMW43YCX/dGNCiBMbKZu+xhagVyKRn8lRoV27V1M=;
        b=PA6AcduShsWyxAT77B8zEgEhbPDzmg3CslDQOPrF8m1uolcX/XL5RucA48kBXMufdx
         gRgRb93dkH765vb/+9LWhjLmMPrvS8Ligv9b+avJ3U4Q7xaEurebQXg8zhJxUlP/o9Qg
         /len/y77peoe/ytUQquj3HmAPasFcKEJMGLRdSkV4THe9fPSDykbkXGWkYY6+DFCYb/a
         lgi+mLnxbUYIqhhiX/y39XXz44jL6Gpb6N7RtNP8ua4dyDpBnAUr7tO6Ta316l+xAfjp
         SInRKl2SXDLDHf2MXBPquP0bFSaeMKbfTIrKfZcZOizF56wAivrldfh5PpypPebGSNFU
         brkQ==
Received: by 10.60.12.8 with SMTP id u8mr10425743oeb.60.1331075310663;
        Tue, 06 Mar 2012 15:08:30 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vy18sm19223436obc.8.2012.03.06.15.08.29
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 15:08:30 -0800 (PST)
Message-ID: <4F5698EC.1080502@gmail.com>
Date:   Tue, 06 Mar 2012 15:08:28 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        linux-kernel@vger.kernel.org,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] irq_domain/mips: Allow irq_domain on MIPS
References: <1330100995-19823-1-git-send-email-grant.likely@secretlab.ca> <20120306195700.GK4519@linux-mips.org>
In-Reply-To: <20120306195700.GK4519@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/06/2012 11:57 AM, Ralf Baechle wrote:
> On Fri, Feb 24, 2012 at 09:29:55AM -0700, Grant Likely wrote:
>
>> This patch makes IRQ_DOMAIN usable on MIPS.  It uses an ugly workaround
>> to preserve current behaviour so that MIPS has time to add irq_domain
>> registration to the irq controller drivers.  The workaround will be
>> removed in Linux v3.6
>
> Looking good, Ack.
>
> Is there any good example for the changes that need to be done to
> irq controller drivers?
>

Well it only affects things that have USE_OF, so most mips things will 
not need to do anything as they don't USE_OF.

But for those that do USE_OF, you have to call one or more of the 
irq_domain_add_*() functions.

Slightly off topic:  My OCTEON patch set tries to do this, but hasn't 
met with quite as much enthusiasm as I would have liked...

David Daney

> Thanks,
>
>    Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
