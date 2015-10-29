Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 12:19:27 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:32946 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007280AbbJ2LTZH5TAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 12:19:25 +0100
Received: by lbbec13 with SMTP id ec13so26294929lbb.0
        for <linux-mips@linux-mips.org>; Thu, 29 Oct 2015 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=m4igpylASd07jAKyiv491UPJipGqJDRGNbAbwyKpN5c=;
        b=uZIcPnAautsWw4BXOfhVXT8S29zjEDY72908ZeqjNUU3Dpi0u5fC8WcMS7KD+ychqk
         EbzDQ64fIAsusZkbsj8+uPxyrcfvDrgTnnJsTTaOIu4kS+TtpNOzC1BC4J4Wwu4WYXba
         Lt+EdvgFXQ6hHDdnS6wjHKjR3H9br+PanYqlcku10fvKkOFCxkJOrotnAoNicuiDLQMy
         U/5jt07mKWeexx5x8mb0m9JmpfLGF9i/pOm4/Heksa+N+5kuZRj+arc+CZXvX9aH1QhC
         /DfVZTS50HqliPgC8D7cFqAT+oWZTMXfeEUdPsKvNhEt811QVdJhgMQjaGL/5FXt4Qle
         MuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=m4igpylASd07jAKyiv491UPJipGqJDRGNbAbwyKpN5c=;
        b=G+6l2HmlgchcMw1tu45kUCu/fvVgsgQdkqH/5ONrS2cH5R+R/7ugURa9+8iWn9JvTD
         b5+dDw5xEwaO7GJj6TVN2+ZRW2Qe9rVQIu0NnKhbRYA6bkxiZKnusTP4MkrRwol6vU2Q
         t0FX41FMUqzLP9ZgcgI1r5UwANaoM3n69iTP9XpOFnTBDGRGHjf/UP3QE8IMOlsb87a9
         yZufZGN9mUYqayjOFN4InRSMvDzqlHmnyUIROcd4qUqFeV2oHgwdCMW1iie/WKDHF4zO
         lXqAb9moBIdyz3Ao0e/Z3ooxo7OChRUSEZ0uHawoBG2BouGd3Un8uI1jytqqpnVt06nw
         awlg==
X-Gm-Message-State: ALoCoQkqbhmMrWdas2t0Wk5cU7GzghIgAx852mUo7PL4KKUMbFSK+kzRxiAruSfI7zfTm0h87Qm9
X-Received: by 10.112.168.138 with SMTP id zw10mr690842lbb.12.1446117559393;
        Thu, 29 Oct 2015 04:19:19 -0700 (PDT)
Received: from [192.168.4.126] ([195.16.110.1])
        by smtp.gmail.com with ESMTPSA id 100sm218153lfr.29.2015.10.29.04.19.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2015 04:19:18 -0700 (PDT)
Subject: Re: [PATCH 01/15] MIPS: lantiq: add locking for PMU register and
 check status afterwards
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
 <1446071865-21936-2-git-send-email-hauke@hauke-m.de>
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <563200B4.7090105@cogentembedded.com>
Date:   Thu, 29 Oct 2015 14:19:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1446071865-21936-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49763
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

On 10/29/2015 1:37 AM, Hauke Mehrtens wrote:

> From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
>
> From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

    Hm... why twice?

> The PMU register are accesses in a non atomic way and they could be

    Accessed?

> accesses by different threads simultaneously, which could cause

    Accessed?

> problems this patch adds locking around the PMU registers. In
> addition it is now also waited till the PMU is actually deactivated.

    Perhaps "we now also wait"?

> Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

[...]

MBR, Sergei
