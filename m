Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 19:22:10 +0200 (CEST)
Received: from mail-la0-f50.google.com ([209.85.215.50]:34512 "EHLO
        mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013321AbbEMRWII2LI6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 19:22:08 +0200
Received: by laat2 with SMTP id t2so34536401laa.1
        for <linux-mips@linux-mips.org>; Wed, 13 May 2015 10:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cpG1kLwLVSO/3MWq/D8hMH72WbiMBxtjv3WL4YOhkDk=;
        b=cAF9SruSLJM8/UG20rcW241322tK0ddH3+iLCGjBunj/I9xcpFwD6VchB1phpEwuCG
         Jpa+K8zIDNmbqlLKAIM+/OaiNRWOfjAnLc3qoEjfvdCzL+giSLoyXTR+OctkwvX50vkH
         LwNefAMJ9Xrs6KqeiMDdf+KaVMEB0nb8cmkpg2wuj1J/WMh7ZXrZ0C3U8StTU48Y6SfS
         IO96bHUgvGGu2iDhaaMwGac+WRNh7Twq9lkFNmwqT4b/AtmTyPncXwXBC13RAWEAAX+E
         PLGNApqXsWAOpQVRwCixtruhpSQPeTptaoDwGye1ktGT8msbyQEWkRh/srRAXh4T7oSo
         JL5A==
X-Gm-Message-State: ALoCoQlHFV6hp66mhEfzWWRud6gS0AbEfB2JSZCoeurR67lydlRy7jVaTUwKmzZf4y7Hn9Rt7VNI
X-Received: by 10.112.120.199 with SMTP id le7mr16641927lbb.48.1431537724807;
        Wed, 13 May 2015 10:22:04 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp85-141-198-186.pppoe.mtu-net.ru. [85.141.198.186])
        by mx.google.com with ESMTPSA id am7sm5218226lbc.3.2015.05.13.10.22.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 10:22:03 -0700 (PDT)
Message-ID: <55538839.1010908@cogentembedded.com>
Date:   Wed, 13 May 2015 20:22:01 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: cpu: Convert MIPS_CPU_* defs to (1ull << x)
References: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com> <1431530234-32460-3-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1431530234-32460-3-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 05/13/2015 06:17 PM, James Hogan wrote:

> The MIPS_CPU_* definitions have now filled the first 32-bits, and are
> getting longer since they're written in hex without zero padding. Adding
> my 8 extra MIPS_CPU_* definitions which I haven't upstreamed yet this is
> getting increasingly ugly as the comments get shifted progressively to
> the right. Its also error prone, and I've seen this cause mistakes on 3
> separate occasions now, not helped by it being a conflict hotspot.

> Convert all the MIPS_CPU_* definitions to the form (1ull << x). Humans
> are better at incrementing than shifting.

    I'm suggesting to use BIT_ULL() then.

> Signed-off-by: James Hogan <james.hogan@imgtec.com>

WBR, Sergei
