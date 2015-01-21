Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 19:00:08 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:47601 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008667AbbAUSAHDKXpm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 19:00:07 +0100
Received: by mail-ig0-f181.google.com with SMTP id hn18so9571248igb.2;
        Wed, 21 Jan 2015 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=s5mK+IJZ1C6j1FrMDuI7rnLfRM4oJ7ZLFDC1BJi2IdY=;
        b=bHxyX4rDN4pFPxhGs7o8OTvVreJjzNq86SZR4xQULb/I/tb58b52Mqla+0jMwN+A+9
         MVI9JPYIG/EdS2b91PLPXERnGYQ/G61WQTCqPrklgSrbA0yUmVp3sOn/V+XYb9A00iAJ
         8hzXYOIW2blMXrED/kD/BVIxuBrTyhklMwK1n8cwpbS6gAZ7koD5NxSeeNpqlhfBC5Ec
         qiFPfECVM81+KngjLiQgzovIOoD3XuBpvKRnxMf2k0+vLkyRb6HHFe+wfPxIEXmZJhjN
         y9k+67pLrEvrksG1wczdbN5cMsfEO18CV3R9rsPo6K+kCnhqlMyIZxAgAVbcISxpHAHq
         UQgg==
X-Received: by 10.42.25.144 with SMTP id a16mr36110358icc.66.1421863201346;
        Wed, 21 Jan 2015 10:00:01 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id qs3sm6390071igb.8.2015.01.21.10.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 10:00:00 -0800 (PST)
Message-ID: <54BFE91F.7050906@gmail.com>
Date:   Wed, 21 Jan 2015 09:59:59 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>, stable@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: kernel: cps-vec: Replace "addi" with "addiu"
References: <1421854030-28929-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421854030-28929-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45417
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

On 01/21/2015 07:27 AM, Markos Chandras wrote:
> The "addi" instruction will trap on overflows which is not something
> we need in this code, so we replace that with "addiu".
>
> Link: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00430.html
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Acked-by: David Daney <david.daney@cavium.com>

Same comment about the stable thing.  Is it needed for anything other 
than follow-on MIPS r6 Patches?


> ---
> Moving this out of the R6 patchset as requested by Maciej
> ---
>   arch/mips/kernel/cps-vec.S | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
[...]
