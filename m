Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 19:14:26 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:57165 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903629Ab2BWSOX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 19:14:23 +0100
Received: by wico1 with SMTP id o1so1185876wic.36
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2012 10:14:17 -0800 (PST)
Received-SPF: pass (google.com: domain of zajec5@gmail.com designates 10.216.139.147 as permitted sender) client-ip=10.216.139.147;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of zajec5@gmail.com designates 10.216.139.147 as permitted sender) smtp.mail=zajec5@gmail.com; dkim=pass header.i=zajec5@gmail.com
Received: from mr.google.com ([10.216.139.147])
        by 10.216.139.147 with SMTP id c19mr1502057wej.11.1330020857753 (num_hops = 1);
        Thu, 23 Feb 2012 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FpBNnWKLBLd77dLhpimfJ2cGjbMI5uU8Knw6/XZEpLE=;
        b=paffGuJUkcck+BHYZf8CWRvyY4rDsPJOBniu9qtVTa0C1tNQlu/QtJfaWE7GE6iykt
         hLr6JR+bldAVHJb8NAPI+bTY11LJAVP1Vqv9myiSQ3nA3O1K3b0KSc2cYEKqNCNdCLas
         wedlCwVu7Iv6W8fa6ulWucRbVsxXxY8Hh+RO8=
MIME-Version: 1.0
Received: by 10.216.139.147 with SMTP id c19mr1226952wej.11.1330020857691;
 Thu, 23 Feb 2012 10:14:17 -0800 (PST)
Received: by 10.216.86.8 with HTTP; Thu, 23 Feb 2012 10:14:17 -0800 (PST)
In-Reply-To: <1329676345-15856-2-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
        <1329676345-15856-2-git-send-email-hauke@hauke-m.de>
Date:   Thu, 23 Feb 2012 19:14:17 +0100
Message-ID: <CACna6rwNEPY3iJCeWV3AmbBy7fQwQrgr9Oji6tro-Dr23y5udQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] ssb: sprom fix some sizes / signedness
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linville@tuxdriver.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/2/19 Hauke Mehrtens <hauke@hauke-m.de>:
> @@ -53,10 +53,10 @@ struct ssb_sprom {
>        u8 gpio1;               /* GPIO pin 1 */
>        u8 gpio2;               /* GPIO pin 2 */
>        u8 gpio3;               /* GPIO pin 3 */
> -       u16 maxpwr_bg;          /* 2.4GHz Amplifier Max Power (in dBm Q5.2) */
> -       u16 maxpwr_al;          /* 5.2GHz Amplifier Max Power (in dBm Q5.2) */
> -       u16 maxpwr_a;           /* 5.3GHz Amplifier Max Power (in dBm Q5.2) */
> -       u16 maxpwr_ah;          /* 5.8GHz Amplifier Max Power (in dBm Q5.2) */
> +       u8 maxpwr_bg;           /* 2.4GHz Amplifier Max Power (in dBm Q5.2) */
> +       u8 maxpwr_al;           /* 5.2GHz Amplifier Max Power (in dBm Q5.2) */
> +       u8 maxpwr_a;            /* 5.3GHz Amplifier Max Power (in dBm Q5.2) */
> +       u8 maxpwr_ah;           /* 5.8GHz Amplifier Max Power (in dBm Q5.2) */
>        u8 itssi_a;             /* Idle TSSI Target for A-PHY */
>        u8 itssi_bg;            /* Idle TSSI Target for B/G-PHY */
>        u8 tri2g;               /* 2.4GHz TX isolation */

Just a note in case you're going to develop ssb/bcma/b43/brcm code.
Please note we're trying to switch from properties you modified to
struct ssb_sprom_core_pwr_info.

The patch still looks fine.

-- 
Rafał
