Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2011 01:35:04 +0200 (CEST)
Received: from mail-pw0-f65.google.com ([209.85.160.65]:37329 "EHLO
        mail-pw0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491202Ab1DJXfC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Apr 2011 01:35:02 +0200
Received: by pwi8 with SMTP id 8so742910pwi.0
        for <multiple recipients>; Sun, 10 Apr 2011 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lA2nLszBgqtSEGbYAA0xeWBtUJBxO4hI2wyvJwECP6I=;
        b=pwPRXOsjCK6xbuzLlP9j2BLQ/TlXeS8pIvpDbpv3jhASUeQD6YMeCbo+UGLqpkR3VK
         HuPlGHsm4LlSsG+hPfcqbUcbvT/svEUtejzBRK04bKEYnCN4TzxYyvFFcW6SKXD1sWUn
         Sb1hGkkSX44AXQ24cmRRfjwQNcKpMLXb/klLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tsOeg/3dJ+YKU43gq/9oJpR9ZaTEjPO4mNlPoQzOKNKtV3Px3UpFfImoFUUslURHxN
         UaQTIe1xARKGAYHZI88Ghb7xMs4Pyo5qEKCNuju6yNuTbcPxIhHJaqVsTOrkHges5Opr
         E2y2zkJWPaxIiM1SCTN3uHQZwUwnm4J7eBz1Q=
MIME-Version: 1.0
Received: by 10.142.250.5 with SMTP id x5mr4820436wfh.440.1302478493247; Sun,
 10 Apr 2011 16:34:53 -0700 (PDT)
Received: by 10.68.64.232 with HTTP; Sun, 10 Apr 2011 16:34:53 -0700 (PDT)
In-Reply-To: <20110410181238.GE18601@pengutronix.de>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
        <20110410181238.GE18601@pengutronix.de>
Date:   Mon, 11 Apr 2011 07:34:53 +0800
Message-ID: <BANLkTima9-xmm2r6KeQcksvwhk5Wv4oaMA@mail.gmail.com>
Subject: Re: [PATCH] fix build warnings on defconfigs
From:   wanlong gao <wanlong.gao@gmail.com>
To:     =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        david.woodhouse@intel.com, akpm@linux-foundation.org,
        mingo@elte.hu, rientjes@google.com, nicolas.ferre@atmel.com,
        eric@eukrea.com, tony@atomide.com, santosh.shilimkar@ti.com,
        khilman@deeprootsystems.com, ben-linux@fluff.org, sam@ravnborg.org,
        manuel.lauss@googlemail.com, galak@kernel.crashing.org,
        anton@samba.org, grant.likely@secretlab.ca, sfr@canb.auug.org.au,
        jwboyer@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wanlong.gao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wanlong.gao@gmail.com
Precedence: bulk
X-list: linux-mips

On 4/11/11, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao@gmail.com wrote:
>> From: Wanlong Gao <wanlong.gao@gmail.com>
>>
>> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
>> since BT_L2CAP and BT_SCO had changed to bool configs.
> Pointing out the commit that changed these two in the commit log would
> be nice. Something like:
>
> 	The BT_L2CAP and BT_SCO configs are bool since
>
> 		6427451 (Bluetooth: Merge L2CAP and SCO modules into bluetooth.ko)
>
> 	. So change all defconfigs from =m to =y.
>
> Other than that
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Thanks .
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>
