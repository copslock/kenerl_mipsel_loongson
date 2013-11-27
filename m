Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Nov 2013 23:14:05 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65295 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867263Ab3K0WODUHuF8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Nov 2013 23:14:03 +0100
Received: by mail-ie0-f181.google.com with SMTP id e14so12741660iej.40
        for <multiple recipients>; Wed, 27 Nov 2013 14:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BB92krnoaZajH5Ro8eI/vWGYvGQBdcz/Fq1eNnCdpuA=;
        b=kqkqEH6CPyX0TuNqpN6GGJNOCjl8MpuDinEW7zPIGI0PBC2cllxVqkLZty5WI/n6Ne
         IJtDK+o6g7NDn9CLoFOzaPpuV+w/O3sLrqxgo7NEabpaBOrSQMg6A2PHLcbVnbLyItqR
         IWD3RJK+W0W5UawHE9bHrvSm7i2fLU5G6aJN7n2U95JkE5RBH9KMWt26Zi9IdF/86h/q
         7SFYwbMIGJ09yUnnGs62S1gLOJzpBXmby9z9OcvjZwhe0T8aVLUKdTPA8KlMbZUFytTr
         MeB7GoM9jEy3PLeGeH3TiicXNcLYfaetLkTa9vblcPupZBTb8qy/r9LLE295TxRGBc5z
         pulQ==
X-Received: by 10.43.145.197 with SMTP id jv5mr25783210icc.2.1385590436835;
        Wed, 27 Nov 2013 14:13:56 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id u1sm40729907ige.1.2013.11.27.14.13.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 14:13:56 -0800 (PST)
Message-ID: <52966EA2.6050109@gmail.com>
Date:   Wed, 27 Nov 2013 14:13:54 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: cavium-octeon: export symbols needed by octeon-ethernet
References: <1385590304-29540-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1385590304-29540-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38593
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

On 11/27/2013 02:11 PM, Aaro Koskinen wrote:
> Export symbols needed by the octeon-ethernet driver. The patch fixes a
> build failure with CONFIG_OCTEON_ETHERNET=m.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c   | 1 +
>   arch/mips/cavium-octeon/executive/cvmx-helper-util.c | 4 ++++
>   arch/mips/cavium-octeon/executive/cvmx-helper.c      | 8 ++++++++
>   arch/mips/cavium-octeon/executive/cvmx-pko.c         | 3 ++-
>   arch/mips/cavium-octeon/executive/cvmx-spi.c         | 1 +
>   5 files changed, 16 insertions(+), 1 deletion(-)
>
[...]
