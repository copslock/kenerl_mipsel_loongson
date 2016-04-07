Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 13:03:05 +0200 (CEST)
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33960 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025616AbcDGLDEBjuW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 13:03:04 +0200
Received: by mail-pf0-f174.google.com with SMTP id c20so53946488pfc.1;
        Thu, 07 Apr 2016 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=73yszL9F5Cj/D7JhdssxgmQwgT8eN2upDmNb7zD53hA=;
        b=cGrMEydtbWjqsKtJ7n118YAT8brjrc7nuR2mqSDvxG8FzsHXScjXkMS9vxN0cvBwFg
         S1guVKWrCZyMrCxsK3tADR3hqLt+kOyD2A2Aw3EGby3JbqEX1/Vp9JOyT0EzCS+USkge
         tFDWzi89lSsZgspvELikck778SIBdhGmZhY56AWmX0Od2ASmteM1o/OJ64UOucFqB0Je
         XpRobszNqPlbM8V5Ki+wuV3+UbVpRMQvIViQgxKij08tJklb0lxNL0KlQ781vQvm9j5T
         ErKbfN5ybbuXSLdpLlFJHRKI02oqySL3B4HFwV/FPovst2TWtJbvAa+lNHyT68WEuNgD
         /BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=73yszL9F5Cj/D7JhdssxgmQwgT8eN2upDmNb7zD53hA=;
        b=Va0Jg9x1ugatoUxsrh8rfIFxnac18Nva4pVgoPTp2hlpZedsBLHeFTPVl/TSkdvm03
         ZNVYQKvH8IcfsXIVHQecldmCLj3pNuHvmVsiaJCu/p0NjOLljkIUV74SgdcBYIIOWJhV
         1reVX2CwXMNtTpzqtOJMKQcFp7IQedgMQnn2Zth0b5x58u8BbbENLbTiv5gfEClZiaI8
         Gq56xyAxADZpJtjX0ZYl6MwFoGt9127nwIjOp69M81rFJMnt9oXVB6QwUKXOGUECKB8/
         r7HHjpCJjtsXwXjN68z9uIhF1Yx1yUAgSGvkWD3pc75OJpIn70V/H+GtFIu9GoLy8GS3
         iwsQ==
X-Gm-Message-State: AD7BkJJFsrnP1iFDh89NoOjv41ugpvsYcDjdmDYkeyS2a/vKQ7QrvcfDYgLqz0VtKD1DhQ==
X-Received: by 10.98.74.6 with SMTP id x6mr3939450pfa.80.1460026977818;
        Thu, 07 Apr 2016 04:02:57 -0700 (PDT)
Received: from [192.168.1.103] ([103.24.124.194])
        by smtp.gmail.com with ESMTPSA id s26sm11419276pfa.0.2016.04.07.04.02.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 04:02:56 -0700 (PDT)
Message-ID: <57063E5B.2080206@gmail.com>
Date:   Thu, 07 Apr 2016 16:32:51 +0530
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Apr 7
References: <20160407152922.73d85ce6@canb.auug.org.au>
In-Reply-To: <20160407152922.73d85ce6@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Thursday 07 April 2016 10:59 AM, Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20160406:

All the mips builds are failing since last few days.

My patch at : https://lkml.org/lkml/2016/4/4/236 fixes the build for 
defconfig and allmodconfig. I have not checked the patch with other builds.

regards
sudip
