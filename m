Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 14:09:00 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:58677 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822330AbaG2MIt60Ve- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 14:08:49 +0200
Received: by mail-la0-f47.google.com with SMTP id mc6so6412431lab.20
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2014 05:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DYr6N2XLcCzJUPOAjGRuZHObjV+8CYjhuj2ffslc4P0=;
        b=mTrcnmNVVpxnt9ZqNd4DOiYCksMff46s/WJGWO5trmSxo+OxXZ2zVGUG/QHtMOQ/tc
         H17UTB9rdaKG/zIH0Sa8hGTb8wWEtBq3fAes1NhDI5wS9rgzppjAroDS2ygOV2zFo9up
         vvqpqQHuYI9u+BLL/h/jWvrgJ82YjKTvplJop6YHSJwTchxnytLBCY/wNyyp8JpdCXqg
         eKYGbnkoCbjEJXMIbzYhNm7Y7F1S5VDpk06WvE+ZaN5YuHom2iYTrg8vs51QYTSfp4Kc
         Y73gHBwXGwtcKLp9n1wvlhK1oeFtSWyxY0hzsBcTjcmO/fA3IrHFGxviDRQq9kv2pXBd
         bVtw==
X-Gm-Message-State: ALoCoQmtzzKy267QgRMvNIA3H6XaIcLEMUhcihImwYNYL32pK5R1rZLNqUo6Pnq4iwPasm5GD7eK
X-Received: by 10.112.63.65 with SMTP id e1mr1743438lbs.81.1406635722869;
        Tue, 29 Jul 2014 05:08:42 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-248-198.pppoe.mtu-net.ru. [83.237.248.198])
        by mx.google.com with ESMTPSA id uo5sm35500585lbb.6.2014.07.29.05.08.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 05:08:42 -0700 (PDT)
Message-ID: <53D78EC8.6010603@cogentembedded.com>
Date:   Tue, 29 Jul 2014 16:08:40 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
CC:     zajec5@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: BCM47XX: fixup broken MAC addresses in nvram
References: <1406584487-31167-1-git-send-email-hauke@hauke-m.de> <1406585281-13054-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1406585281-13054-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41788
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

On 07/29/2014 02:08 AM, Hauke Mehrtens wrote:

> The address prefix 00:90:4C is used by Broadcom in their initial
> configuration. When a mac address with the prefix 00:90:4C is used all
> devices from the same series are sharing the same mac address. To
> prevent mac address collisions we replace them with a mac address based
> on the base address. To generate such addresses we take the main mac
> address from et0macaddr and increase it by two for the first wifi
> device and by 3 for the second one. This matches the printed mac
> address on the device. The main mac address increased by one is used as
> wan address by the vendor code.

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

> v1: fix checkpatch warnings

>   arch/mips/bcm47xx/sprom.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)

> diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
> index da4cdb1..41226b6 100644
> --- a/arch/mips/bcm47xx/sprom.c
> +++ b/arch/mips/bcm47xx/sprom.c
[...]
> @@ -648,6 +677,25 @@ static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
>
>   	nvram_read_macaddr(prefix, "macaddr", sprom->il0mac, fallback);
>   	nvram_read_macaddr(prefix, "il0macaddr", sprom->il0mac, fallback);
> +
> +	/* The address prefix 00:90:4C is used by Broadcom in their initial
> +	   configuration. When a mac address with the prefix 00:90:4C is used
> +	   all devices from the same series are sharing the same mac address.
> +	   To prevent mac address collisions we replace them with a mac address
> +	   based on the base address. */

    The preferred multi-line comment style in the kernel is this:

/*
  * bla
  * bla
  */

WBR, Sergei
