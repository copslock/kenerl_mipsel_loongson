Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 23:27:40 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33893 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008265AbcCAW1idbwqQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 23:27:38 +0100
Received: by mail-pf0-f195.google.com with SMTP id 184so5884194pff.1;
        Tue, 01 Mar 2016 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=fWkJ0/JQDxNmyr6H4Rfdx9Xc0TKYJj0RyKHtiBMTpqU=;
        b=A7Xfy4ifXLQ+MlxQi5Arpt+TafjovS0I3PotmJu23EdkEbULf5RogcY1wDg2R/nLYk
         Ywa3uNbJmGVKxD/KxLQNUU5yzmc2Pj286w1t9vPITS++1psKG3b5i9FsiMPDCcQqqL9S
         vIUY3E8167m4+7MdD9xdCxul4e+4dC4gEWIqy6AftRqpArtYTxKd4ZQ8E9cY0hT53/ks
         Zwtc15kiW2kXhZKYqn7YTPJXKcj+u/kes0Ao6y3h6zms3JNivpEmeEN4o53tuYKEpRGq
         eUvVCj8ItANoBa1CKiIOBDhWFQSXe3ZJeiTSmeG5bjOsx2MsL3bxU+IInU8/HX34MuXM
         hKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=fWkJ0/JQDxNmyr6H4Rfdx9Xc0TKYJj0RyKHtiBMTpqU=;
        b=KYsC3LyRMqKMPBJmxnJlhuWC7jO5H9uTVWCfVs8UtNAIqRVvpnCnhhdndmzAOuOkyD
         lQLS/HyM8YOv7mVE5josUTe+m+GxTJ+JE3m1tHTEGFV228cz84oJTIUX2ySb5uer44Y1
         fTt+ciImKkjUbCmA8r27X37ysn668gddZTq+kkmI/Wgkthwy1U0l45y9mOoFuCAU+ZY0
         EXTJZyJbl7KY4KkFyYLAt/m66fOlfDG5QYg3W1L351vLAIghllq4bnlkTg7xeIeJz0yw
         viNqHP1omp3iOHf+C6LplNGMJhqAUtbP6BseOne8SZptYLpIaMJLSOjEMEm/R0eozEiW
         ZFgQ==
X-Gm-Message-State: AD7BkJK4P3QiotKMk1TKnr5SmuxT056QAsh5PCmpCXlbWbUAi38mDBMfxtXpm3GNCeGwow==
X-Received: by 10.98.17.75 with SMTP id z72mr33879914pfi.16.1456871252773;
        Tue, 01 Mar 2016 14:27:32 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id s14sm18824702pfa.3.2016.03.01.14.27.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 14:27:31 -0800 (PST)
Message-ID: <56D61752.7020804@gmail.com>
Date:   Tue, 01 Mar 2016 14:27:30 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] MIPS: Add and use watch register field definitions
References: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com> <1456870779-21007-5-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1456870779-21007-5-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52394
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

On 03/01/2016 02:19 PM, James Hogan wrote:
> The files watch.c and ptrace.c contain various magic masks for
> WatchLo/WatchHi register fields. Add some definitions to mipsregs.h for
> these registers and make use of them in both watch.c and ptrace.c,
> hopefully making them more readable.
>
> Signed-off-by: James Hogan<james.hogan@imgtec.com>

Seems sane,

Reviewed-by: David Daney <david.daney@cavium.com>

> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc:linux-mips@linux-mips.org
> ---
>   arch/mips/include/asm/mipsregs.h | 18 ++++++++++
>   arch/mips/kernel/ptrace.c        |  7 ++--
>   arch/mips/kernel/watch.c         | 74 ++++++++++++++++++++++------------------
>   3 files changed, 63 insertions(+), 36 deletions(-)
>
[...]
