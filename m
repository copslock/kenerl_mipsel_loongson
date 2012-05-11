Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 20:06:53 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50187 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903699Ab2EKSGt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 20:06:49 +0200
Received: by lbbgg6 with SMTP id gg6so2600322lbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 11:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=hljop0e7i4tWOwuHeTaFnUpN5nXVViJticniqRo5bNY=;
        b=FDzdL0zAEbBVLqqEkatCxHl+A4JngWHxsPebTG+YHwmcPeihNqANNEgOWo4DlfOl+t
         ev1kfn48gtUJtNc6LeSRMSOnCjPdF4R+4i0Rxx0B9+k6SE8EZu+TfFMISEf2IxgGuKQC
         xSed1mIove4MIEP5FRcBuIDCww8RrPXRNGxLaJoxvlldzp/wRNFraPS6rmbhHmBfIcoC
         vcPTuQqb5OhiZcY4EnBUawTRQ4ZQl0loa5zGbHZ9Bs0dWHHQ6modWc+8/l0g4Y8uw4ga
         KKwH8b34JhGI7xzsa9wxNm1bjrczkTkjJJNfRfM5kbAKRAdX2b07rD7uTlG4QLbVTcd2
         Lw3w==
Received: by 10.152.105.173 with SMTP id gn13mr9226338lab.20.1336759602915;
        Fri, 11 May 2012 11:06:42 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id gv8sm1254502lab.14.2012.05.11.11.06.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 11:06:41 -0700 (PDT)
Message-ID: <4FAD54E9.6030102@mvista.com>
Date:   Fri, 11 May 2012 22:05:29 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Yegoshin, Leonid" <yegoshin@mips.com>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Add MIPS64R2 core support.
References: <1336717784-853-1-git-send-email-sjhill@mips.com>,<4FAD4B9E.70803@mvista.com> <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>,<4FAD4E5C.9040607@mvista.com> <j9ltxtmuep0qhf4mgqhj4du5.1336758301121@email.android.com>
In-Reply-To: <j9ltxtmuep0qhf4mgqhj4du5.1336758301121@email.android.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnrCBrRiQz+ju2jx7YuafI8HmsMbdpK4OLODlwxM05mh2AGMzsMC36P/9GxO0bE9H+Ds2tp
X-archive-position: 33267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/11/2012 09:45 PM, Yegoshin, Leonid wrote:

> I don't see any advantage in separation of it.

    I do. And I certainly do see an advantage of bothering to describe your 
changes, not just throwing in patch with unclear summary, no changelog at all, 
doing 3 things at once and then hoping for it to be silently accepted.

> Sergei Shtylyov<sshtylyov@mvista.com>  wrote:

> Hello.

> On 05/11/2012 09:32 PM, Yegoshin, Leonid wrote:

>> Not exactly - it adds 64R2 support in Malta, plus small verification that build kernel could run 32bit binaries.

>> I don't think it has sense to multiply patches here, there is no sense to have this separated.

>> 5KEc is just test-bed.

>      Well, rule of thumb is do one thing per patch. You do three. All that
> without proper description.

PS: Please stop top-posting.

WBR, Sergei
