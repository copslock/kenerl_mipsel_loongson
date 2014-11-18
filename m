Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 18:32:21 +0100 (CET)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:60268 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013907AbaKRRcTdiVWN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 18:32:19 +0100
Received: by mail-wg0-f50.google.com with SMTP id k14so10286065wgh.9
        for <linux-mips@linux-mips.org>; Tue, 18 Nov 2014 09:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=GzypuUgF3ery2w74p0ctXe4giWayOV53fmz4TmJWw0g=;
        b=R9MeoaDuU/T3s7tRj/ioayd1DlMbhwXtbMSOy2CoCZIje17cnt4jlBb3W3zKduyHT+
         04UJIVGrmfnC7qLitaO3iojS/sVSEn/Bt941adxz/NIHCHmPJt+Sl0j00272VcFykf0c
         ubXMFFjFg4mt6RdpykgRgWmAXccgfsJ1R4bqPmiETMyZ1V4mum9VYlnKsosDptiGbbOf
         hJHQHgqyfXYGHEujsu+tRMuUWhcDoNaXargkTTfxkt+bRC5CDBXqhcEg/07d01lbDh1d
         RmP4lwReX8LIvRASUF9H/F66CS4hGcBcOWuKjp1OiTDALAjMQg4bcfaHDoEvh5tALbHH
         SyCQ==
X-Gm-Message-State: ALoCoQmgFlceoezfeF9qJGEkJXVN/D7J3q9DGn++8Fxp+ufR51+T5cs2DkwokwO9z78/zgkqTkcQ
X-Received: by 10.180.95.74 with SMTP id di10mr5952105wib.54.1416331933521;
        Tue, 18 Nov 2014 09:32:13 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id wa10sm51978841wjc.8.2014.11.18.09.32.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 09:32:12 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id EF793C40966; Tue, 18 Nov 2014 17:32:09 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 03/10] of: Fix of_device_is_compatible() comment
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1415825647-6024-4-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-4-git-send-email-cernekee@gmail.com>
Date:   Tue, 18 Nov 2014 17:32:09 +0000
Message-Id: <20141118173209.EF793C40966@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 12 Nov 2014 12:54:00 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> This function passes back a value from __of_device_is_compatible(), which
> returns a score in the range 0..11, not a bool.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 3823edf..707395c 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -485,7 +485,7 @@ EXPORT_SYMBOL(of_device_is_compatible);
>   * of_machine_is_compatible - Test root of device tree for a given compatible value
>   * @compat: compatible string to look for in root node's compatible property.
>   *
> - * Returns true if the root node has the given value in its
> + * Returns a positive integer if the root node has the given value in its
>   * compatible property.
>   */
>  int of_machine_is_compatible(const char *compat)
> -- 
> 2.1.1
> 
