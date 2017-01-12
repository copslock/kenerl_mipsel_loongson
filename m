Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 00:31:06 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:33799
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993934AbdALXa60yNRg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 00:30:58 +0100
Received: by mail-wm0-x244.google.com with SMTP id c85so7380242wmi.1;
        Thu, 12 Jan 2017 15:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=eMWz0ChQAu7lN2KE7xTU23yyAh4jtHXHd2rzuntAxzI=;
        b=aBhSn/+HKQMOTyETn8PsAMnWeFOuvGi67tk2Zva2CFEP5A3eEQFpijPobpDUu9x+Oe
         0AcNEsFHw1sreuHNs/Qm8sY+T4ETOiuHekd+RLDFcLQJAxwYb3eFkVEhPQ5677cNMErL
         31uWAPcpv8wKPrmf1w14iI/sy76GLtgtZPfF1EahenelN+1SPdbpoSgYk9fMTDwAKt5G
         zJmq9jJmM6Iygr6caSlNpjyHxZJpx1whW+xEvWPS7Tmo391kR6cTnDLOfSV7CAK15Ye4
         OmkRUwu/7EBYqfQOAR1M3oMazatBlyCBrl38Q4+pvcuJ/W20MZuCDb51G7DZADgBgZCF
         Xgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=eMWz0ChQAu7lN2KE7xTU23yyAh4jtHXHd2rzuntAxzI=;
        b=J2CZN7mmRw5DoZMapCrmLJMA2w0+Kr/yDmQu2BjG3v6DLvFYTjj7PzbPWn9SK74/wQ
         ZhvkxJp2pdGJUsi6+D3L2TrdoVqgbsKG491lM858nx3reGIh8i1FL2J2bMFh52M30g0T
         Va8ZhI43njohehaedr5Fbzh8lxfadwa1uXXK7tr6z8iPunywX5EEFjxA7q1uty+YL8Hb
         1kzU/am/48klxy94cmMvTWcd7Mnr6izPAZkSj/Fk0K5AZ02eeo6OrIZFteWSkkwkU8yY
         rh2siyA7aTPg2NLEnrjDi555ITuGbmBIjCvXnEleoLAOGBVRwkBdacnyHuvHu9ESNWqa
         JMDA==
X-Gm-Message-State: AIkVDXI9w/ozWQ+fcobQaIZ8Ucig1CybL3CWVsmBr/1nZBX238nYFYx165WPEsoFT6QpTQ==
X-Received: by 10.28.22.200 with SMTP id 191mr322682wmw.132.1484263852983;
        Thu, 12 Jan 2017 15:30:52 -0800 (PST)
Received: from [192.168.0.10] (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id w18sm6296994wme.9.2017.01.12.15.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 15:30:52 -0800 (PST)
Message-ID: <587811A7.2040202@gmail.com>
Date:   Thu, 12 Jan 2017 23:30:47 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: zboot: fix build failure
References: <1483553098-5013-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1483553098-5013-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56284
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

On Wednesday 04 January 2017 06:04 PM, Sudip Mukherjee wrote:
> The build of mips ar7_defconfig was failing with the error:
> arch/mips/boot/compressed/Makefile:21:
>    *** insufficient number of arguments (1) to function `filter-out'.
> 	Stop.
>
> A ',' was missing while adding filter-out.
>
> Fixes: afca036d463c ("MIPS: zboot: Consolidate compiler flag filtering.")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---

A gentle ping.
Many of the mips builds are failing daily.

regards
sudip
