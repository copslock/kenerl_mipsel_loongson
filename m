Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2015 20:02:28 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33592 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008159AbbJRSCXuy-J3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2015 20:02:23 +0200
Received: by pabrc13 with SMTP id rc13so167282654pab.0;
        Sun, 18 Oct 2015 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=s0eTSzmpCm9Ti06KpivvKjqgqzOxkLi6oVdraxFg21E=;
        b=VBlC/AsWa56tsSulYd9+titTi87gBpK96+LC6gLYg6F5pij7gNqEMypnXxzwDgKyVt
         A2fP6pgsxUdynvU2Dhq/aRTdZV0J3wfqnHC0T90d3w0hVgfB22Z4zieBtfZoh+ALeuvQ
         r/+cFLS+HjJfKAO8w8GuyY5CUKlPhuuuzXFcGOjJkQMNCcJb3oHrzd0QD2sW0oPwAltZ
         sndyAVXgifQp2dj8Ii8Sku5sYKjyTMWqx0kMnYaYIoSS+aRW+W+tor16H23/hRturSxq
         bOKOHQoMDPCZE4OizAGIy+6kIihkVrFMYRkPSHiRUflzVCORlRVxktPMDUueaGufRBEs
         DmKw==
X-Received: by 10.68.87.226 with SMTP id bb2mr18215597pbb.84.1445191336648;
        Sun, 18 Oct 2015 11:02:16 -0700 (PDT)
Received: from [192.168.1.16] (ip174-67-200-7.oc.oc.cox.net. [174.67.200.7])
        by smtp.gmail.com with ESMTPSA id tn2sm5681390pac.0.2015.10.18.11.02.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2015 11:02:15 -0700 (PDT)
Message-ID: <5623DEAE.2060708@gmail.com>
Date:   Sun, 18 Oct 2015 11:02:22 -0700
From:   Dragan Stancevic <dragan.stancevic@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org
Subject: Re: [PATCH] MIPS: BMIPS: Enable GZIP ramdisk and timed printks
References: <1445025118-13290-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1445025118-13290-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dragan.stancevic@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dragan.stancevic@gmail.com
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

On 10/16/2015 12:51 PM, Florian Fainelli wrote:
> Update bmips_be_defconfig and bmips_stb_defconfig to have GZIP ramdisk
> support enabled by default as well was timed printks.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Dragan Stancevic <dragan.stancevic@gmail.com>
