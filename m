Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:35:56 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:39835 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137Ab1ASTfu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:35:50 +0100
Received: by qyk27 with SMTP id 27so1393319qyk.15
        for <multiple recipients>; Wed, 19 Jan 2011 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=l3do2g7UFAYJ4sofgcftQNprh/1Ujv/h/7ZEJnZo8+I=;
        b=wMjl4rjGvPHbsyFYHZIfhMEA3Yz5TTYxqsy4dkxI8id+IT8vWXTwN18UOYwv+xcpTk
         UCcvsMqpfL8LjI9kTPijXGYfV7Ts1m4No9rWKWJwFovXgQDquazAmYaxxi6y+QYyQUev
         vzB4rjj3RsgMCeHlv4SZibNPsPIIMcTXayWFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ZE9TRJ+w1jH5x5jxqFGmx6EWAuXvWnC/N6u5cgUatv/zud9yefukTryXn7mseroIJ3
         cza6tID8pucibZr9u9Q57x1aiXsGVp2/0GA3aaVdamWtPWwEj+c8xnppH5iX3nUzhBHm
         rd5rB2G6rU6i5Ww3gkiMFo7D00ZgBRd44+UC0=
MIME-Version: 1.0
Received: by 10.229.96.133 with SMTP id h5mr940377qcn.147.1295465743928; Wed,
 19 Jan 2011 11:35:43 -0800 (PST)
Received: by 10.229.39.9 with HTTP; Wed, 19 Jan 2011 11:35:43 -0800 (PST)
In-Reply-To: <1293502077-9196-3-git-send-email-ddaney@caviumnetworks.com>
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
        <1293502077-9196-3-git-send-email-ddaney@caviumnetworks.com>
Date:   Wed, 19 Jan 2011 20:35:43 +0100
X-Google-Sender-Auth: qx_cJjf1I_wVmrS6MH61D_fY2OM
Message-ID: <AANLkTinZZ2TziwkiBfhqV-3-VfXwU+EPx3OHsnTRVChT@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Optimize TLB handlers for Octeon CPUs
From:   Jonas Gorski <jonas.gorski+openwrt@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski+openwrt@gmail.com
Precedence: bulk
X-list: linux-mips

On 28/12/2010, David Daney <ddaney@caviumnetworks.com> wrote:
> +#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE) && \
> +    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
> (...)
> +#else
> +static bool scratchpad_available(void)
> +{
> +	return false;
> +}
> +static int scratchpad_offset(int i)
> +{
> +	BUG();
> +}
> +#endif

This seems to have broken the build for any non-octeon mips build:

  CC      arch/mips/mm/tlbex.o
cc1: warnings being treated as errors
arch/mips/mm/tlbex.c: In function 'scratchpad_offset':
arch/mips/mm/tlbex.c:112: error: no return statement in function
returning non-void

Regards,
Jonas
