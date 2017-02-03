Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 19:50:45 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:35589
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdBCSuigib0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 19:50:38 +0100
Received: by mail-pg0-x244.google.com with SMTP id 204so2628595pge.2;
        Fri, 03 Feb 2017 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=y4dCmkybi4356j9lEYZLJcDsEA5cLCwSIo/T+fQgFdM=;
        b=u+XvlTbZTOKCLI74v2TuQ2+Axfe7BM2vsNQdVnGIGDijwqrwRejHjkVfXuuyBB6X13
         8rmrGCv+J8ev0bYvk9gtxelLvlA5UieLQDcy7TFtzmJrUnObOV1YnKojQEG5f47kSpwI
         FzKmmHnRyiiXZpfcaUE9IRVPd3J8xsYZzZToSxWhSGE9Ueh+B+0dF0BrN2sSpQgAQ81V
         LZ93YUNvI7kG7xKFh6WLbESKCR687YF786KVw7QsbKYZViLFCNRlXIkD2NkmVB7c8KAc
         yDi2WFotUmJHZvl6XtdLPVTYZhB+6sZSYwyK0LvCRv1vJJakKIGpz54SiucLDMt30IWT
         MoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=y4dCmkybi4356j9lEYZLJcDsEA5cLCwSIo/T+fQgFdM=;
        b=p245kf2n7Bbk+Vtik3QBtbLo6i34WYt0FyPw10TR8dH09ShVxsVSgwnKuJitgnY//x
         dxjUaMAe59c/uwF967JdWwsL6RoSQ4ZjczvPsxhUSgQjXXlLdc0nbq8V5r7INlmHZ53D
         WycpBOt1sY/dd4JJ9WdnBhtfPNCHS2dTZ6IhqpaO503gcjoETxf2lgxTQdbAXuaHLa81
         X1Qaj0AFp780e/7TZVHgAjQR46d14BXcrrH+eaz8WTvdlRxrABObFUrdlkR5GdsmP8wY
         v0LXmAmnpwQzQrPulYWYY3fbCJa3StxL/vXvWaDV57k7/vu2dbsj0FbeA5lW3rY6TWYR
         KMZQ==
X-Gm-Message-State: AIkVDXJ1r30XjHy9Sl8DSHPzzHjR+L33hznZtZqz5B5UijU8R7IDyOryTLocBsoySQcoOw==
X-Received: by 10.99.177.79 with SMTP id g15mr19762335pgp.185.1486147832696;
        Fri, 03 Feb 2017 10:50:32 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id c18sm68936649pfj.49.2017.02.03.10.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 10:50:32 -0800 (PST)
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
To:     Joe Perches <joe@perches.com>,
        "Jayachandran C." <c.jayachandran@gmail.com>
References: <1486147623.22276.70.camel@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
Date:   Fri, 3 Feb 2017 10:50:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1486147623.22276.70.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56629
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

(with JC's other email)

On 02/03/2017 10:47 AM, Joe Perches wrote:
> 64 bit stats isn't implemented, but is that really necessary?
> Anything else?

Joe, do you have such hardware that you are interested in getting
supported, or was that just to reduce the amount of drivers in staging?
I am really not clear about what happened to that entire product line,
and whether there is any interest in having anything supported these days...
-- 
Florian
