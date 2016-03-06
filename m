Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 13:18:42 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33383 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008306AbcCFMSlBKDpA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Mar 2016 13:18:41 +0100
Received: by mail-lb0-f176.google.com with SMTP id k15so104015866lbg.0
        for <linux-mips@linux-mips.org>; Sun, 06 Mar 2016 04:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nL5LmQmmRn48M2zDzK5HeZ5Yv6MOnMV0BaD58HYc7ow=;
        b=p4d2aYcPoSaBxRaR08KMIc/uHmVrUHr6Q52nxWRueNIT1BfDcQ3bTx3+4qKwMOUwIy
         PugaaxoL49O02Gx7EI4K4tZOYD/B1f9Th9Ri4Ngq9LB4KrnsH3il10Cj9pAYIoDEJzCB
         OhzViEaJh34HpHoQPX8kVVekEJ452uW5E18ChVjuI5Txub9Kyz9a6LErDj4OxR4E6Dsk
         7Qk5vrz8PjtTuDXEjk97DfZYd8b+1Hxm6//slMYG5ljnGz5itCrqaNSyewwEZl7Y3eRS
         w9qfzjirHI97HiEViqKczaWeG6MPeADM8vCDPGswX0trY+wvMCJ+qPqA0NjsSittM7z+
         yYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nL5LmQmmRn48M2zDzK5HeZ5Yv6MOnMV0BaD58HYc7ow=;
        b=FBqaJNpk7K0qn/3+l8T74TBOkUwb+Xhv+Ctk+ODnfAj0v6fx4K55eA1VcHy4ZWsrC9
         3Ud/VJMuueE/OIh4t0sa4pT4Gvkax2/iXY03brHHuGF36GIE0Fn5SYygF8HbKoXPdQkU
         2g8C8DMR4ZfHXTSP2Xn54oMrkAjZ8FZXxnJI5MZgJLJ9YYCJHy5BDl2xSmld5u4R7EOc
         0f1vp1ukk2sjSyrJxNPh8vT8LKyiD3FkdllHJCp0QvEOWdW1GLHg0wMNGeycW3nrBjAo
         50OfteNQqBBC7p1uKpXqMPebD1sWDsk6Upoe0I1c4NBq06Qy4iXdEkextaiDiCcIA6ak
         DYEw==
X-Gm-Message-State: AD7BkJKdUDmlRmTBChncuk899rSHACLZsRglmN+pEHqeIDEfGbQzui689e88EenwbDsydw==
X-Received: by 10.112.161.225 with SMTP id xv1mr6023352lbb.127.1457266715727;
        Sun, 06 Mar 2016 04:18:35 -0800 (PST)
Received: from [192.168.4.126] ([195.16.110.49])
        by smtp.gmail.com with ESMTPSA id i186sm2037819lfb.30.2016.03.06.04.18.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2016 04:18:35 -0800 (PST)
Subject: Re: [PATCH 2/3] MIPS: Loongson-3: Fix build error after ld-version.sh
 modification
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1457236202-16321-1-git-send-email-chenhc@lemote.com>
 <1457236202-16321-2-git-send-email-chenhc@lemote.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56DC201A.1080100@cogentembedded.com>
Date:   Sun, 6 Mar 2016 15:18:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1457236202-16321-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52478
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

On 3/6/2016 6:50 AM, Huacai Chen wrote:

> Commit d5ece1cb074b2c708 (Fix ld-version.sh to handle large 3rd version
> part) modifies the ld version description. This causes a build error on

    The same comment on what scripts/checkpatch.pl expects.

> Loongson-3, so fix it.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

[...]

MBR, Sergei
