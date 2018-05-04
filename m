Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 12:26:20 +0200 (CEST)
Received: from mail-wm0-x233.google.com ([IPv6:2a00:1450:400c:c09::233]:55645
        "EHLO mail-wm0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991783AbeEDK0OG19u8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 12:26:14 +0200
Received: by mail-wm0-x233.google.com with SMTP id a8so3232866wmg.5;
        Fri, 04 May 2018 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HX9iqQbzF17HeGiMIG05s2IJds1xKIx6T0e15iYOFGE=;
        b=Ff6Y+yc78EDyh3XbdsJ/2u90SXaIkBgpZytGQllxjHGQPCMFJEKw7ZsN845LSqHYyc
         J7FF3IKb2wl3Tjp8ZgsdPDxQFNdNEzR70SYhc5EQszqfwursWtjob3TjWvTMH+yHBn0Y
         AEcaIBXl47ouwVjXflE8tutbh3ic+z3oB+9PEDDZkZE3U+pqWWsD5PKOfJ+GxwbK7Zum
         pCS5zZd9cKMne8Gkxme8l2BbIM3k/muDVZQ+pPTCPbziz+yyVLK8ITGPCw9jEnY8BrbO
         GhGIya3U9X3KsZM2ZPOqgMg1zYltARCWqPPMJCIW9X/3iNbMgw0DIq1G6OMvouOaGLXv
         FEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HX9iqQbzF17HeGiMIG05s2IJds1xKIx6T0e15iYOFGE=;
        b=j/Zuwr+T1S6gnnF4ct9wgae9FNTSTNzCZu6f2YdraVBTVaQB/+oW2LO8jUvdZecZME
         4fv3W3X4owU9tB83UPyD0w3G00oxQnmTKT76r1Bq1LWrtxFC9J0++QBT9F+JH96E2fNn
         Fdh9Hw0pgyKVvOfPXzuQMNU+49XNDjgZYSYIZOCfrFHIgjq7uZM9l6PGkURAX3zTDLFs
         CvN00XlvxabK5ZpOPn96ZaWzJkJo6xSG2Pr8kEbCJCw9Qq6VI2Wuvj6m4RbTD3sokJ3O
         Wzx2lXiQ1Yabvi+5/Hhp+Ju6c6mvYdXtsNfyrMt1xHpzxmh9R5fDl0vftJrvf5RrZcl3
         26XA==
X-Gm-Message-State: ALQs6tD6mAOl3mKx6B4NXWf3Cd7KZP2f1gpRGmzLnSNivKx7pi35zb+h
        H4JZvfJrqAVTGREz5Y+NqU4=
X-Google-Smtp-Source: AB8JxZq4DXWDCmu9PMzTA+5fKTihwLLVJh1gGkbIoz93Uv3kHqbr8Y/kqI/mhcyeEbBl9zv/L6AWIA==
X-Received: by 10.28.18.208 with SMTP id 199mr15764166wms.153.1525429568637;
        Fri, 04 May 2018 03:26:08 -0700 (PDT)
Received: from rric.localdomain (x4e37fc4f.dyn.telefonica.de. [78.55.252.79])
        by smtp.gmail.com with ESMTPSA id k23-v6sm19497330wrc.59.2018.05.04.03.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 03:26:07 -0700 (PDT)
Date:   Fri, 4 May 2018 12:26:01 +0200
From:   Robert Richter <rric@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504102600.GD4493@rric.localdomain>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <rric.net@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rric@kernel.org
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

On 04.05.18 10:54:32, Matt Redfearn wrote:
> perf is available for MIPS and supports many more CPU types than oprofile.
> oprofile userspace seemingly has been broken since 1.0.0 - removing oprofile
> support from the MIPS kernel would not break it more thatn it already is,

What do you mean with "oprofile is broken"? It looks like you modified
Kconfig to enable oprofile and perf in parallel, which is not intended
to work. Have you tried a kernel with oprofile disabled and perf
enabled?

As said, oprofile version 0.9.x is still available for cpus that do
not support perf. What is the breakage?

Thanks,

-Robert
