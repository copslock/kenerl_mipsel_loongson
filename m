Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 20:08:39 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34407 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013144AbbKITIhKHyJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2015 20:08:37 +0100
Received: by lbbcs9 with SMTP id cs9so449023lbb.1
        for <linux-mips@linux-mips.org>; Mon, 09 Nov 2015 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nOj3STvU6ca7Eiy9gfggj6XBfzWxtrhBBfnyFdzTkVo=;
        b=wJbVG3qdTpsbu65oaL9Jsu9NcjQafPBnTxD82LqXrYsPjlKdKogQ4G1xoYwLa0Pqxb
         7pEOux84/CVfse2wT+6vJNOw9Hpx9VtD8+Dcuf237fF5VATqaXNXddKm7dVkccX5vQgt
         sdzsIuXgsDhimTgPLPvCYsdkePwKRuuYIRWl6Yaohbe4gHeaEsoMYOE7UghNSYGy5jKL
         4+iYmKEVdvxHTy1ia71jPkeLHNcjoKCKgT6rvolqmlzSnf7Zu1r9NVdYW8CsaCByd1Zy
         RQV6QDk4J3IqJ0mp/Cedbd47zuNEi2PU3GHCF8a3oO/OcYbDbTrHORt9TGXcSSiT6+7E
         9z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nOj3STvU6ca7Eiy9gfggj6XBfzWxtrhBBfnyFdzTkVo=;
        b=mNzp4eyZNfYXU2dVbT54OZeRY3vypQd6mi9YP1s6P1w+XzDTyKQwPGKsi5VG3rgRxs
         yp84yfUL3LKgnbu69xpuWLc/xmOarQ3GctePiQgBsiekXtf5ZTOK3EIloWkM3xfW7xTa
         nbJY9UQSYzjdklrqmGILmL6C9vTnGwmO/FgZsEGvqNWqV5U3KYAHcn+1SkBVR/c0v5iX
         nOy02L976zabSN4PykXsdBvIVCRnnWbjaSMiEsKCi3ZmxPtEi1E0K2k96HgYI+ERzEo1
         6YecCoicLada0HhEn7dx/993S0fYj6uckg3UoYVXYzoqlniHI4MhYCLFoFm4ajCLwSgs
         uUHQ==
X-Gm-Message-State: ALoCoQktlMUaHtCE7xe1lgzOSGNoqyu/CZrzcb7snIi1ueZUhiny5vtxWEgOvcsgsqLxjb72Ov0O
X-Received: by 10.112.8.104 with SMTP id q8mr14087333lba.115.1447096111601;
        Mon, 09 Nov 2015 11:08:31 -0800 (PST)
Received: from wasted.cogentembedded.com ([195.16.110.94])
        by smtp.gmail.com with ESMTPSA id e77sm2604959lfg.10.2015.11.09.11.08.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 11:08:30 -0800 (PST)
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
 <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org>
 <20151109144932.GE22591@linux-mips.org>
 <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
 <5640D8E9.7080808@cogentembedded.com>
 <alpine.LFD.2.20.1511091827480.10231@eddie.linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5640EF2C.40907@cogentembedded.com>
Date:   Mon, 9 Nov 2015 22:08:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1511091827480.10231@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49880
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

On 11/09/2015 09:54 PM, Maciej W. Rozycki wrote:

>>>    I think I've been reasonably serious about my SWARM and despite issues
>>> elsewhere the onboard PATA interface is a part of the system I've never
>>> had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's
>>> still 11MB/s (and one of the 4 generic data movers present in the SoC
>>
>>     If you measure it with something like 'hdparm -t', the real speed figures
>> in the PIO modes would disappoint you. It's usually more like 3 MB/s even in
>> PIO4...

>   Well, various factors contribute to actual figures possible to achieve,
> the physical medium transfer speed being an important one.

    Yes, of course. Yet even with MWDMA2 (same wire speed as PIO4) hdparm 
shows about an order of magnitude higher speeds, IIRC. With the UltraDMA modes 
it becomes even higher...

> That 11MB/s
> throughput is the maximum you can ever get on the wire in PIO 3, assuming
> data is already available to transfer and IORDY is asserted right away
> every cycle.

    Yes, I figured.

[...]

>    Maciej

MBR, Sergei
