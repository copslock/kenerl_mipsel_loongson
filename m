Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:34:02 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52135 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2HUSd4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:33:56 +0200
Received: by pbbrq8 with SMTP id rq8so309355pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hFXDPO6pmV0ItVz3WE9AvtAwzIU05aAKnc5P/qrnQYM=;
        b=DBVEWQoVdqsHjCVvMm3fOa7KTlrrChcPOXgo7hxbKaTg2PIJuYtoAdh2u5GHo4IHX4
         R70BevoHgqNrhil88veoVFRl+L7Seiax9x1ryvuTFes61OTu7xKHwV5gffMp9Ss3juW6
         OpxMb60/kLnnZ/9MaPS8tS16ZXFUAKmKSrDIjb2s46KER0XXm5F93/GbWNsouj2Nz4Qt
         ZObW7yYHj1Ui/nuCc9T/Ryahl1w7bm+A6FSBX5+g/f5Tr5I+MJB1fULAw02IcAb1O2Oc
         X8BSqW0Ywa3BumTahxq0RO/Zz1k6IkkwmV1n9T8XdC0yG6iBVqF0MCYyr6lQkfyWj23Y
         zsiw==
Received: by 10.66.76.226 with SMTP id n2mr39825853paw.67.1345574029569;
        Tue, 21 Aug 2012 11:33:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pj10sm1923219pbb.46.2012.08.21.11.33.47
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:33:48 -0700 (PDT)
Message-ID: <5033D48B.8050903@gmail.com>
Date:   Tue, 21 Aug 2012 11:33:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <5033D22E.2050307@phrozen.org>
In-Reply-To: <5033D22E.2050307@phrozen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34313
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

On 08/21/2012 11:23 AM, John Crispin wrote:
> On 11/05/12 23:34, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Add the driver, link it into the kbuild system and provide device tree
>> binding documentation.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> Thanks, queued for 3.7.
>

This cannot go in like this.

There were a bunch of requests by other maintainers that were never 
done.  Also since it is in a foreign subsystem, it at a minimum needs 
some additional Acked-bys

David Daney
