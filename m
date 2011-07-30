Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jul 2011 15:47:22 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:56910 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491104Ab1G3NrT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jul 2011 15:47:19 +0200
Received: by wyf23 with SMTP id 23so474950wyf.36
        for <multiple recipients>; Sat, 30 Jul 2011 06:47:13 -0700 (PDT)
Received: by 10.227.137.14 with SMTP id u14mr3576771wbt.31.1312033633223;
        Sat, 30 Jul 2011 06:47:13 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.88.54])
        by mx.google.com with ESMTPS id m38sm2090258weq.21.2011.07.30.06.47.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 06:47:11 -0700 (PDT)
Message-ID: <4E340B44.3050305@mvista.com>
Date:   Sat, 30 Jul 2011 17:46:44 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Netlogic: Minor fixes for XLR processors
References: <20110730110449.GA30043@jayachandranc.netlogicmicro.com>
In-Reply-To: <20110730110449.GA30043@jayachandranc.netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22310

Hello.

On 30-07-2011 15:04, Jayachandran C wrote:

> * Avoid unneeded cache flushes, XLR dcache is fully coherent across
>    CPUs.
> * add r4k_wait as the cpu_wait
> * Move load address - the current value wastes space.

    This seems like a material for the whole 3 patches...

WBR, Sergei
