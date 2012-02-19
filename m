Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 20:14:22 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:45974 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903594Ab2BSTOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 20:14:18 +0100
Received: by iafj26 with SMTP id j26so8082504iaf.36
        for <linux-mips@linux-mips.org>; Sun, 19 Feb 2012 11:14:12 -0800 (PST)
Received-SPF: pass (google.com: domain of larry.finger@gmail.com designates 10.42.150.133 as permitted sender) client-ip=10.42.150.133;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of larry.finger@gmail.com designates 10.42.150.133 as permitted sender) smtp.mail=larry.finger@gmail.com; dkim=pass header.i=larry.finger@gmail.com
Received: from mr.google.com ([10.42.150.133])
        by 10.42.150.133 with SMTP id a5mr15838759icw.38.1329678852368 (num_hops = 1);
        Sun, 19 Feb 2012 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eKJqMNdNLvCFEw5nWmbuPB6VaDur90ft8idZc7qqeSQ=;
        b=jTYs0xBAqtlXhDZA5p+2kZgkagWlD+Z+ZdJVsrq4/btFuKvoJ4bKddjk/4D6eu9lsb
         xaPi4Gz39FqzI/R62Trsjei8UTK0ysm9lAr/oGPvJvlb0THLfI1WFKLjkiXQjX+P6DUJ
         7pT8+eSAeSI8yola7DJKAJ+THJLRrk+4ar8kE=
Received: by 10.42.150.133 with SMTP id a5mr12706855icw.38.1329678852296;
        Sun, 19 Feb 2012 11:14:12 -0800 (PST)
Received: from larrylap.site (CPE-75-81-36-228.kc.res.rr.com. [75.81.36.228])
        by mx.google.com with ESMTPS id df2sm4976897igb.0.2012.02.19.11.14.10
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Feb 2012 11:14:11 -0800 (PST)
Message-ID: <4F4149FC.50900@lwfinger.net>
Date:   Sun, 19 Feb 2012 13:14:04 -0600
From:   Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120129 Thunderbird/10.0
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     linville@tuxdriver.com, zajec5@gmail.com,
        b43-dev@lists.infradead.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, arend@broadcom.com, m@bues.ch
Subject: Re: [PATCH 02/11] ssb: remove 5GHz antenna gain from sprom
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1329676345-15856-3-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 32482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Larry.Finger@lwfinger.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/19/2012 12:32 PM, Hauke Mehrtens wrote:
> There is no 2.4 GHz or 5GHz antenna gain stored in sprom. The sprom
> just stores the gain values for antenna 1 and 2 or 1 to 4 for more
> recent sprom versions. On old devices antenna 2 was used for 5 GHz wifi.
>
> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
> ---
>   drivers/net/wireless/b43legacy/phy.c |    2 +-
>   drivers/ssb/pci.c                    |   40 ++++++++++++----------------------
>   drivers/ssb/pcmcia.c                 |   12 +++------
>   drivers/ssb/sdio.c                   |   12 +++------
>   include/linux/ssb/ssb.h              |    7 +-----
>   5 files changed, 24 insertions(+), 49 deletions(-)

After this patch, I get the warning

drivers/ssb/pci.c: In function ‘sprom_extract_r123’:
drivers/ssb/pci.c:334:5: warning: unused variable ‘gain’ [-Wunused-variable]

I am still testing, but all other patches compile OK.

Larry
