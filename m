Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 10:46:17 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36581 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823021Ab2KTJqMxuYR4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2012 10:46:12 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so1065286bkc.36
        for <multiple recipients>; Tue, 20 Nov 2012 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=7LQIFCTUSqwNqOF9OjWBsUz2+MD7t1clD7zZ9Wxq470=;
        b=Vw8ZPoSAAqaWwRtvGeoaNdRj00nPqYpX8SUNvFJoz3Oxd3GsaVtf2OBW4Vg065Dleq
         4SNC2vCrwEsF7h2RrLkle2/ojheyAczHuygh21BaF0sTSvrExca2CUh3tAQCe7iSAdp3
         J+aB1VDtUje0EGAJADS51qbIgDpTfNK8YRkIoeY+Jy7hzuxnkrvJmjUSnTCfGBqBuZge
         8MghKx4SDpV6mKe/IyKOuEKfD/udrchk+ZG0dYiuJyD7kH+H7+LMIu4/R4IMWLmi/ehk
         JSMoZBL/dfHNgeCogDMwWmbD6j+fBHLZz4gJgSAdocMPFVNiuk2o4/AdjFlWaTsj/mwo
         ltUA==
Received: by 10.204.147.18 with SMTP id j18mr5763375bkv.79.1353404767484;
        Tue, 20 Nov 2012 01:46:07 -0800 (PST)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v8sm2963897bku.6.2012.11.20.01.46.06
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 01:46:07 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, zajec5@gmail.com, m@bues.ch
Subject: Re: [PATCH 8/8] MIPS: BCM47XX: remove GPIO driver
Date:   Tue, 20 Nov 2012 10:44:23 +0100
Message-ID: <2709503.xrLFuOobtI@flexo>
Organization: OpenWrt
User-Agent: KMail/4.9.2 (Linux/3.5.0-17-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <1353365877-11131-9-git-send-email-hauke@hauke-m.de>
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de> <1353365877-11131-9-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 35058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Monday 19 November 2012 23:57:57 Hauke Mehrtens wrote:
> Instated of providing an own GPIO driver use the one provided by ssb and
> bcma.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Florian Fainelli <florian@openwrt.org>

Thanks Hauke!
--
Florian
