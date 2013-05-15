Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 13:55:55 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:46750 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3EOLzxnIJPN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 13:55:53 +0200
Received: by mail-lb0-f182.google.com with SMTP id r11so1765344lbv.13
        for <linux-mips@linux-mips.org>; Wed, 15 May 2013 04:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=gDlC9WkfhGx1bztq+fIV8/3wf2zWuObWFYKRInkH/Ew=;
        b=IoQ1flsq0w9xVAErKQ0EekXp9Dq8b+C8LwozRHFuZpI7kUyhvUeszZA67y76F20sSe
         vD4oH5X9obPbihWm/xqNrOZpYUxWRBaujdeYQw3TKc5d0yIfrO6qWSpqAF2V62Yub+Fw
         lw2mhiCdt+cBpBLYw08l3eTj7r9oiR7mMikVmroFhrKUGy5c/iShtTeiM2WaJaJexwiC
         Ui+4Qx5v1IHPyYmDE9PmUcmubJbvnlqFo+3vDOKfDo3N7K0T+RF8ptXUK2FpgRB2mNzR
         OAr/Gr3PzQO2DmjipKeJzFtbuVwVcqCotZx4BbLibWYU/7+HzXtybB4ERhcrD6h6VkmL
         cmKw==
X-Received: by 10.112.120.170 with SMTP id ld10mr17375425lbb.31.1368618948011;
        Wed, 15 May 2013 04:55:48 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-84-82.pppoe.mtu-net.ru. [91.76.84.82])
        by mx.google.com with ESMTPSA id ay3sm1070400lab.1.2013.05.15.04.55.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 May 2013 04:55:46 -0700 (PDT)
Message-ID: <519377C4.1040800@cogentembedded.com>
Date:   Wed, 15 May 2013 15:55:48 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Libo Chen <clbchenlibo.chen@huawei.com>
CC:     grant.likely@linaro.org, rob.herring@calxeda.com,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree-discuss@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] usb: omap2430: fix memleak in err case
References: <5192E650.3070303@huawei.com>
In-Reply-To: <5192E650.3070303@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQleGLbyh6YU1CqkW+wJvO3QV9JNi1fJ/mLOhYbtGxwyNxR/MXCCVBZpvSfcT4uXHQmAfQol
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36404
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

On 15-05-2013 5:35, Libo Chen wrote:

> when omap_get_control_dev fail, we should release relational platform_device

    s/fail/fails/, s/relational/related/?

> Signed-off-by: Libo Chen <libo.chen@huawei.com>

    You've posted this to the wrong mailing list, linux-mips; 
devicetree-discuss also seems hardly related.

WBR, Sergei
