Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 16:34:30 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62704 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822997Ab3E0OeXBu76H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 16:34:23 +0200
Received: by mail-lb0-f174.google.com with SMTP id u10so6687763lbi.5
        for <linux-mips@linux-mips.org>; Mon, 27 May 2013 07:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=FsrfkX66V5DQRz/WMvDAGc3WqytgRqZJ9n66UWQMAMI=;
        b=NwTKMXQ3vNbitTC0ivYJjgui/gRdmESQHypxaP+WD0U0wJEwWCuz4LzHXD2aki54GA
         PQJhNAWQvjdJoPX9BoyAID293QlXOCU1U9TgqILStpsHu/FZlNqxlRJ6TNIFVuMcXTT0
         OGPM/ka8HbRR9o94QYxP329KcysnJJNNVb6WFGDS5N3rtF/u1xk3jZDai23RGI7mpntZ
         semfULmqoDHsPt5/TtDiLAfrpA4dFQas64xbYQVqco7YVPEhG7aX30PiuzGKTKc/WWhi
         ANDFlgyHDBCwfVxlWay+KcaFHtvkVoZEH864F96A793rjwiTuJq6bSNnVAihmzlc+KMo
         5zqQ==
X-Received: by 10.152.8.231 with SMTP id u7mr14701775laa.27.1369665257326;
        Mon, 27 May 2013 07:34:17 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-145-214.pppoe.mtu-net.ru. [91.76.145.214])
        by mx.google.com with ESMTPSA id n7sm11666304lbd.12.2013.05.27.07.34.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 07:34:16 -0700 (PDT)
Message-ID: <51A36EE6.3040901@cogentembedded.com>
Date:   Mon, 27 May 2013 18:34:14 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>
CC:     ralf@linux-mips.org, macro@linux-mips.org, Steven.Hill@imgtec.com,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 2/3] MIPS: microMIPS: Add kernel_uses_mmips in cpu-features.h
References: <20130527124421.GA32322@hades> <20130527124557.GB32322@hades>
In-Reply-To: <20130527124557.GB32322@hades>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQk4RtumaXa1rCy3Ce8OHNhNULoQpMURdhjOdhdXikGH4Z0YQQjnxlvCtS3fm+HwUKQOZlfr
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36616
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

On 27-05-2013 16:45, Tony Wu wrote:

> Add kernel_uses_mmips to denote whether CONFIG_CPU_MICROMIPS
> is set or not. This variable can help cut down #ifdef usage.

    You can avoid #ifdef usage with using IS_BUILTIN() macro, not 
defining extra macros.

> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>

WBR, Sergei
