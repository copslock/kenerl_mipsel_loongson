Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 03:03:32 +0100 (CET)
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36541 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011315AbcBWCD1XWpkj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 03:03:27 +0100
Received: by mail-pf0-f173.google.com with SMTP id e127so102912916pfe.3;
        Mon, 22 Feb 2016 18:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Qg2gqjB4Dk1fwvzmWEWUlxszlHwrENHTLSvipiDdDwc=;
        b=E+y/Eh7+05sn0dCLqV8LAMu+loXWSx0CHh1bPoB0B4KkF+1y7zJMTxHwctvTXOIlAw
         zWFr39BpU+6tnNvXv1N25zORITV/VXMl9Es1Mn0B2C1JHuj0wqfpO9wTo9GrmvgXZ/vo
         GBveIRSKws33yMa1l4PU+G9PGBkU3Pr/MMJiDAPTp0+lDqSfVFlzjCF4fMjyZkGFcfA4
         fy6afPQchnWnfr0wmiENFIMZknIwub/npp8XFJNCEG4jw5LlTdo4ObV17OUyW0Bw881N
         2tzSUNVQrzdXeLE0c823lm8fJKeDtowjz+kRFOtWwf21MPK4msN6RILdN2E2FVVtdzuK
         T9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Qg2gqjB4Dk1fwvzmWEWUlxszlHwrENHTLSvipiDdDwc=;
        b=jmuLWuu3O+h9A2YfLoBmj4Gd+JbJKJ/vwiEAgyh6bSNXKLgWDm82qqVBejLm/9FEYn
         09rApdzaG1fcg2/H5GM/DmzM9HLNGMmMpM9d+CgdbUKcqNz1PSlOi8mmQz6b5MWSSFHq
         GRHZTJNMIvAwfZD5nz+UMQ7awe69/F0MFllAr6XXqN5jHiQ6U+XT/R367QPM6+Ry9fAp
         bflGFOMt+gMY2cCmtBzNUSRyhZbsmIWU5lmCRvfhwTe/zMeehoYKtz0D6xNC6myIUVkK
         K+qZDgLA/KkCWz4m9PNIK2mZTI9bwW/A2BFi82pKwdP6Ak0e3MjhUwVBcNtgDREJyj6Q
         oIZQ==
X-Gm-Message-State: AG10YOTAGuDyCIcm0r0w6yVhbzu2kW2uD6+GRK6jx1msK9ZP/6uZ61SsUr+kESBggYcB7g==
X-Received: by 10.98.9.129 with SMTP id 1mr42934691pfj.163.1456193001327;
        Mon, 22 Feb 2016 18:03:21 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id kw10sm39981836pab.0.2016.02.22.18.03.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 18:03:19 -0800 (PST)
Message-ID: <56CBBDE6.6090308@gmail.com>
Date:   Mon, 22 Feb 2016 18:03:18 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS: OCTEON: fill mac addresses with appended DTB
References: <1456180788-6803-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1456180788-6803-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52176
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

On 02/22/2016 02:39 PM, Aaro Koskinen wrote:
> Hi,
>
> When using appended DTB, the MAC addresses should be filled in
> from the bootinfo.
>
> A.
>
> Aaro Koskinen (3):
>    MIPS: OCTEON: device_tree_init: use separate pass to fill mac
>      addresses
>    MIPS: OCTEON: device_tree_init: don't fill mac if already set
>    MIPS: OCTEON: device_tree_init: fill mac addresses when using appended
>      dtb
>
>   arch/mips/cavium-octeon/octeon-platform.c | 95 +++++++++++++++++++++++++------
>   arch/mips/cavium-octeon/setup.c           |  8 +++
>   2 files changed, 87 insertions(+), 16 deletions(-)
>
