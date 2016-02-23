Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 03:03:07 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34241 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011315AbcBWCDFhmPYj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 03:03:05 +0100
Received: by mail-pa0-f53.google.com with SMTP id fy10so100805812pac.1;
        Mon, 22 Feb 2016 18:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WHbQgLXdSd7kMnBIeAfr5f6Oyd4c+LHlaX4npLwC9+U=;
        b=RBV4sLMZOcTD7DcSmkVRoVnh5I3uMOklNWSd5jKDDVlK71IgN617RyPR5foUCF6/VA
         qEmg0NhsaRJ9VSrBu3vx/+nGYK1KCzOVGMfGyddU4sMLES7lmJJLp6M7XeszJqONxDcq
         RccY6hNT3BfZFWz7U65NYNVa2V5cKx+PaqpfjWRJxEi8U2s/bHO6AvlX9IQvPjXDWnwy
         Z/MsppcWTrRTXUbYZjeh3RkrWoyO5IK7vczUoL9msRh6extHlWv6Q4jXS51tj9/lRM4G
         L/DkmL8eSa0i+hVbwta5e8UTBwNN63l43vCdfzknHQutGRkJ2hoo7ZLCEKnFakxQFbaX
         H8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=WHbQgLXdSd7kMnBIeAfr5f6Oyd4c+LHlaX4npLwC9+U=;
        b=nJ93r6w1foKlU3+44IYN9A058GSBS0DC/j4Fz28ne54hPNXGv/AjJyRzI8wplsHHgY
         kcZnOEIsM1Mouq33d0XrGCj8HA21tH0Z9L92sP23PTVBFlstCPfeejvb1waPpUmu6c+P
         fzFjMzg/8G+h+PvNZfy5VT0bd2SsXEEIGTPmYV8LEXQYzEQbQ/N0jy4E1Aj5yi05Ssdg
         iSvx/g1CNIm4hb2adXXP0maa0cfvmWfMppfrCdt0NXYv6xPmwlUZfaX9q/pijylQtJ6T
         dbcek9y8v8TC0z+ls7d+i3okKvjhNrw+rAA7ewW7BmDsm3o/1HJWpbJq6wHIHG4PaOpD
         XRUQ==
X-Gm-Message-State: AG10YOSmL0nVPhDtwOwinUwFXMyfqyATwxlkeEvy/dPZklCNqbFh1H+hPR53tDsrzjfksQ==
X-Received: by 10.66.231.100 with SMTP id tf4mr42767823pac.44.1456192979535;
        Mon, 22 Feb 2016 18:02:59 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id yj1sm39904691pac.16.2016.02.22.18.02.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 18:02:57 -0800 (PST)
Message-ID: <56CBBDD0.3030709@gmail.com>
Date:   Mon, 22 Feb 2016 18:02:56 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Make DT "model" visible in /proc/cpuinfo
References: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52175
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

Acked-by: David Daney <david.daney@cavium.com>

On 02/22/2016 02:22 PM, Aaro Koskinen wrote:
> Hi,
>
> This is a small cosmetic change to get rid of "Unsupported Board" in
> /proc/cpuinfo with "pure DT" boards.
>
> E.g. on EdgeRouter Pro this changes system type in /proc/cpuinfo from:
>
> 	system type             : Unsupported Board (CN6120p1.1-1000-NSP)
>
> to:
>
> 	system type             : ubnt,e200 (CN6120p1.1-1000-NSP)
>
> A.
>
> Aaro Koskinen (3):
>    MIPS: OCTEON: board_type_to_string: return NULL for unsupported board
>    MIPS: OCTEON: initialize system type string after device tree init
>    MIPS: OCTEON: use model string from DTB for unknown board type
>
>   arch/mips/cavium-octeon/setup.c              | 23 +++++++++++++++++------
>   arch/mips/include/asm/octeon/cvmx-bootinfo.h |  2 +-
>   2 files changed, 18 insertions(+), 7 deletions(-)
>
