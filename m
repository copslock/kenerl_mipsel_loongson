Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 13:17:20 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34594 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008404AbcCFMRPz3PwA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Mar 2016 13:17:15 +0100
Received: by mail-lb0-f170.google.com with SMTP id xr8so7332618lbb.1
        for <linux-mips@linux-mips.org>; Sun, 06 Mar 2016 04:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7EDANN/67KKAnW1rTj1mfK80bUnfEKcEeZW34PzDDQ0=;
        b=xFoLjylEokjz9eT6Qbfdpx7P/x8HtPNxdqvSTgE4Ql+peMifcOCdf4x68aR4iHZN1s
         orAbKyi+XVlOflp674NjtyS0KsNL/Kd4v+KfG0badB6bC2H8BGw+S//XrgZlO5QFxR31
         Yg1YbX7NbDlXAMnRvKSOeXETx21ovhXPTPSmQE0BAIZRzyMlIYAQJfAT5n9c5nQH8I6b
         VbOlelSIOh5mkCPKxE2zPqS/OZtLR9VlDO1tJMf90l3lGkDziamH6jNEijElX+B0cKg0
         OBnNoA1zXapsWhcudWxct8LQ0wxENjLTJVqW79WccD8jbR81gUnobqOVaASf3smx60t1
         PFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7EDANN/67KKAnW1rTj1mfK80bUnfEKcEeZW34PzDDQ0=;
        b=OcquJ2HvxN2VcGTxve+cqCvaCPUM6t5LS/5mSuu4bnSdN4HQq3xHwHvz2MigpOMdIN
         eE7VjV6kHLAMYlLW0ZPfLkE7iNAleQ0U15rPXUUNrXUnW18YBDi8s3ZrnkD2ZNsxCnyg
         VNZexiMA6744yfAkLLekX3TMBEBgf3M45nB4fX5kcOzypBlQiWfZJu28M6lbENKfZ/Bn
         qbFfv+Ys/nkTAbijV70nr5qKyp07thStnUjpBg2vWqhWobUCXJeI5UJdGb9mf0oN+EaP
         B7ZDvk8k1uil39BCvirn+PecB7SVXhAqeW+dPooGUxdcINnf8JBxlev9pOIGiCYL9aga
         S+rg==
X-Gm-Message-State: AD7BkJI8GKbyuI0hbyi/N04lYkyA59S49OH+hRwxM2eCm+b0RowSdwtTqpdG2cyzB4+v7g==
X-Received: by 10.112.143.163 with SMTP id sf3mr5653123lbb.117.1457266629757;
        Sun, 06 Mar 2016 04:17:09 -0800 (PST)
Received: from [192.168.4.126] ([195.16.110.49])
        by smtp.gmail.com with ESMTPSA id ze8sm2002947lbb.45.2016.03.06.04.17.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2016 04:17:08 -0800 (PST)
Subject: Re: [PATCH 1/3] MIPS: Reserve nosave data for hibernation
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1457236202-16321-1-git-send-email-chenhc@lemote.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56DC1FC4.7020007@cogentembedded.com>
Date:   Sun, 6 Mar 2016 15:17:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1457236202-16321-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52477
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

On 3/6/2016 6:50 AM, Huacai Chen wrote:

> After commit 92923ca3aacef63c92dc (mm: meminit: only set page reserved
> in the memblock region), the MIPS hibernation is broken. Because pages

    scripts/checkpatch.pl now enforces certain commit citing style, yours 
doesn't quite match it...

> in nosave data section should be "reserved", but currently they aren't
> set to "reserved" at initialization. This patch makes hibernation work
> again.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

[...]

MBR, Sergei
