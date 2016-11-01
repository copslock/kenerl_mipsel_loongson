Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 20:51:08 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35318 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993221AbcKATvAWMTrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 20:51:00 +0100
Received: by mail-pf0-f194.google.com with SMTP id i88so1104573pfk.2;
        Tue, 01 Nov 2016 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CVfVKPiopAdq0MKvl+wC51J1H63NKakudmirzs5l3+A=;
        b=MLA0ErzZelnz5tJpvZUzbWUuDQpLy4QYp2rX5Ls+xgHIJsKvw9ELANpBZTEMI5gd28
         PCser4nH3pVRWfZ5OhKghq9XEthQFxj91Q0KRueEDHjGWz1YRWKEMQ9C1G8C+IFvDlwQ
         Br1H36Eu/NyL2JDD2+esQUMt+0R2vnhV2ML/VBzJq2ZVQffUc5m5L+xDYewmTQXsJs9V
         hSdBrrRPJbgADaS5UQGJFe2+5us66thgfVVprJU+r80G0GhGhLLla8MA9pq6HRh4nNGr
         pa2PMCWLuiiwzjOlfzHO08WHcDfNx4bqiB6asQZLdry/RiJK2v9uorVEWWY8FicuK7En
         lPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CVfVKPiopAdq0MKvl+wC51J1H63NKakudmirzs5l3+A=;
        b=gMvWknhEbI6iOVcwp8y3+NyNbTQMrc02uMk4NIRE5lXNE3ztGUe/7MiIlcGfgxilOo
         mzY1eE5QMgCpXe4/BfOk+l3OznRcLWP+Je1IyZ5/y7fvrFXocjvHnkCk4qF5GSE/+hHp
         si3oubzAEBAMND6IC1dEeKRMQ48lyXsg6nO4ArxMhbZoqkcMlrqWPQmcJyKn93p3rRzf
         I7lzUUTN1ChjtccndVkk8mqkNFWAY1XSFmQxLlUPK0/W/qr/s31DUvneY65d6eSDQrCV
         LUx29HstA05HMbgGx+NdVwKNzbsRUT5+0u2ztXCp4QOJmA+75l77YFlwRh2MnHZcSS1N
         TV5g==
X-Gm-Message-State: ABUngvfJ6g1bvOmT9Xkth8cBGDJ/ekuQcwGpA86QQKgEQiQgXyNLrAahnK3LRn7kS6U4/g==
X-Received: by 10.98.105.68 with SMTP id e65mr56489786pfc.174.1478029854387;
        Tue, 01 Nov 2016 12:50:54 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id p20sm26355838pfi.78.2016.11.01.12.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2016 12:50:53 -0700 (PDT)
Subject: Re: [PATCH v2] MIPS: Fix max_low_pfn with disabled highmem
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <b7e353db4d5ee94b8e8dfba9f99e5ab9a7b95f65.1478008638.git-series.james.hogan@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <24d343a2-2a74-f74d-a32b-68b10ccfe5c6@gmail.com>
Date:   Tue, 1 Nov 2016 12:50:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <b7e353db4d5ee94b8e8dfba9f99e5ab9a7b95f65.1478008638.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55644
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

On 11/01/2016 06:59 AM, James Hogan wrote:
> When low memory doesn't reach HIGHMEM_START (e.g. up to 256MB at PA=0 is
> common) and highmem is present above HIGHMEM_START (e.g. on Malta the
> RAM overlayed by the IO region is aliased at PA=0x90000000), max_low_pfn
> will be initially calculated very large and then clipped down to
> HIGHMEM_START.
> 
> This causes crashes when reading /sys/kernel/mm/page_idle/bitmap
> (i.e. CONFIG_IDLE_PAGE_TRACKING=y) when highmem is disabled. pfn_valid()
> will compare against max_mapnr which is derived from max_low_pfn when
> there is no highend_pfn set up, and will return true for PFNs right up
> to HIGHMEM_START, even though they are beyond the end of low memory and
> no page structs will actually exist for these PFNs.
> 
> This is fixed by skipping high memory regions when initially calculating
> max_low_pfn if highmem is disabled, so it doesn't get clipped too high.
> We also clip regions which overlap the highmem boundary when highmem is
> disabled, so that max_pfn doesn't extend into highmem either.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org

Should this also go to -stable, if so, which kernels would be affected?
-- 
Florian
