Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 18:28:12 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:56213 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008105AbaLLR2LFGY08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 18:28:11 +0100
Received: by mail-lb0-f176.google.com with SMTP id p9so6146627lbv.7
        for <linux-mips@linux-mips.org>; Fri, 12 Dec 2014 09:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=awrFGXSx2vsoW1x1NDMJBTtej5DdfxIu9cm1WOKyfrU=;
        b=YsLht15AxQf4DBrxUgq52E/Zkd4xxi3ngPIRUnUuWnzzBidOSQgLBVHsKFBSdBwMs8
         uU1OfG7bH9eTEdV196HTMzKrVb+07Oty3aZugxPdgIw0N+9KymfVyq7oxeI90Cro/9BK
         +1AGHCgjJIf+1eK9ppnWjSHw1hpdunmPhjReoK5W8pvrmxsg88H693AWAkl/47QNXXaz
         p/fEhxzsEUC89uMHfYcvjcD5RjktkyhEMgJUbkjDcdUR3zQ+eBSOa2CdwXPT1hjzJEFt
         MqFE6usEyhImKOi9ycG4ZOV6ASQu8n7iSfHl9r8q0nUyQv6GgAv9tiKgB9fHGg3nmtX/
         EgHg==
X-Gm-Message-State: ALoCoQlPqhpMSv417gJU8sk2eIN9ywuS6h3yZAk9zOZ9waNiKUwYNfAnO7wvj3k2ImBcjyyE4Coz
X-Received: by 10.152.234.140 with SMTP id ue12mr16227529lac.78.1418405285333;
        Fri, 12 Dec 2014 09:28:05 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp18-99.pppoe.mtu-net.ru. [81.195.18.99])
        by mx.google.com with ESMTPSA id li3sm549879lbc.31.2014.12.12.09.28.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Dec 2014 09:28:04 -0800 (PST)
Message-ID: <548B25A3.9090303@cogentembedded.com>
Date:   Fri, 12 Dec 2014 20:28:03 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: use phys_addr_t instead of phy_t
References: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
In-Reply-To: <1418398003-1098-1-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 12/12/2014 06:26 PM, Jaedon Shin wrote:

    s/phy_t/phys_t/ in the subject.

> add missing patch

    Maybe part?

> of commit "MIPS: Replace use of phys_t with phys_addr_t".

> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

WBR, Sergei
