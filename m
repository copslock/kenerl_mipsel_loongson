Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 01:35:18 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33169 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbcIGXfIbCg-L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 01:35:08 +0200
Received: by mail-pf0-f195.google.com with SMTP id 128so1599066pfb.0;
        Wed, 07 Sep 2016 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PwiWQH3UbmdRLC60bUs0n/UXBF2zODDQh3RD4jA90fY=;
        b=WqDCYcpnc71ks4Y8qRyYSSPkCO5rSw5R8k6IlQegz968qL6y2UKz7kp1CAbH0UEIzC
         8AYeJY/2hbAXEauN1yqOQa1nqKmhLRHtLO4ncqQm6c+9DhxvIKEoPf/oQFgwhLCBEKh2
         UrY0/DbqypaMFbQrIxt2OpHYJVNY5GLGZ34QqJPHmOUNcFmh+ae16QJxAguXvslLWL2c
         UACqI84aLX4denl5p9Yisv8Boi9XyhRiGfxafC4XFDWEvCrRtVHiNhvXq8xE3aiTmIAN
         8hFnfnAMw9Qod1Ofv3r2XGKZnALpVOgZhZus6WvK646NV7TarYLj3BPAzKVGgqig7n9/
         2FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PwiWQH3UbmdRLC60bUs0n/UXBF2zODDQh3RD4jA90fY=;
        b=G8Q6uQJpfvZzzevWsZjXFEX0pnqmnd4pGTzahRltPpbGbRoQOxoG2BCJN6qFty9PV4
         1gwTmlu6FsgDo91EuRduU0znYdMIgkEP/2DCqMdgcUocSwkW/giUwsrqIrDnwazBneWV
         P199zFplQXgtHsDkto0dhGjLcLFIgCSwB8y+IjpzCL5pzrI8qmuLqieBW0hPkr+FuoCN
         g0Xq6b0NvocMFDzWtZ1R5YS7cUcyYUG9OSoJlX3lrZIjjlQDsHs+o2Sru5I4Uu/TteU7
         qPbfklbPH81BtX7qNH17aPc1jdNALL3Q9xoPCJY8H/cezCcyof9gbxkCdAtALWWE5ZlW
         Ja5Q==
X-Gm-Message-State: AE9vXwPs9REEvkRp00/O0pyUXfh6LjsqrYDf3T0kWV71uWHZ39BL1N17O3j4sc0VZNs3yg==
X-Received: by 10.98.222.196 with SMTP id h187mr2531296pfg.9.1473291302398;
        Wed, 07 Sep 2016 16:35:02 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id 81sm51240448pfm.90.2016.09.07.16.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 16:35:01 -0700 (PDT)
Subject: Re: [PATCH] MIPS: c-r4k: Fix size calc when avoiding IPIs for small
 icache flushes
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <20160905142454.30530-1-paul.burton@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2c0ffccf-5ccb-7693-099d-efd688a01eec@gmail.com>
Date:   Wed, 7 Sep 2016 16:34:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160905142454.30530-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 09/05/2016 07:24 AM, Paul Burton wrote:
> Commit f70ddc07b637 ("MIPS: c-r4k: Avoid small flush_icache_range SMP
> calls") adds checks to force use of hit-type cache ops for small icache
> flushes where they are globalised & index-type cache ops aren't, in
> order to avoid the overhead of IPIs in those cases. However it
> calculated the size of the region being flushed incorrectly, subtracting
> the end address from the start address rather than the reverse. This
> would have led to an overflow with size wrapping round to some large
> value, and likely to the special case for avoiding IPIs not actually
> being hit.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Fixes: f70ddc07b637 ("MIPS: c-r4k: Avoid small flush_icache_range SMP calls")

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Yes would be good to get that in v4.8.
-- 
Florian
