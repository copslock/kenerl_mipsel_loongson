Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 18:33:40 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33945 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013115AbbKIRdhqonDD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2015 18:33:37 +0100
Received: by lbbwb3 with SMTP id wb3so104059243lbb.1
        for <linux-mips@linux-mips.org>; Mon, 09 Nov 2015 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NuMwCPT02zz0vbUQYhXaGuNqz6OOlvdZnlIgKIwulGQ=;
        b=gy36C0t6K1VVG8PImutHSBHZdepwyEz+nr33sYY0B95PD+xcPJTH35eEqcdhPVS4vc
         ZwZD7XGu8VE4OoY6Ikb/J6BUHgKyXOEfOlPbFdCI+F90++xTA1efAcGMpBC6al1E0xYT
         b+3FZcuj4SO6HNTlvVrFQHb9rAkwog76T8i6NNfuVrR83Wu0xatYJd61Ym1aQrrTAf0w
         SSEriiHoO/oSqk5nxUVBP9KMntt3w6Kmrtaq+RrhKfIQNx+djheWA/fB5SZz5sm2M2ru
         wmyFEL5zJE64e4CZzzpIq2Fu70Nx9zdVJeJS7b3Mjua0XJm0QQcE3sWXgXR4cD1uGDmH
         EVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NuMwCPT02zz0vbUQYhXaGuNqz6OOlvdZnlIgKIwulGQ=;
        b=HBC+OIfal4SgincxM0DnwmmEGHYk5E1AGFHFBPG2RYGQxMmMPj3PpS3oQJLqzfBbcd
         BMDs4UzD3AaiIzy6b+qM3YHeIERC+KIDF0xVJI+6WqS/KpAqZbHAnsNhMT2WdEtYZKCn
         nk71CUAYvXtPmedVL2CTwnWzVmGlQT/EpPjwDKJT1pNRcjHexK5DlezF2G3DUA+U8ULG
         S+B5qz+phbenRk+TfUdenxNDZN2eOXzB1Xm6ubeQUX3furO7sJCqvduI4B7Uon4spajB
         UiAZ7+y4tyvQA32T/x1o4uGEm7AB16k6dm+Lyo5OI5ef2J/pbz+3EQegiYpSr/mT06BJ
         nvfA==
X-Gm-Message-State: ALoCoQkcIir9Pm4ZLqqP8YSv7otujfren2H9hTCUEsRt8bzzGrvLzWb/qQ0ZMfFeZ0/fnamAV/g/
X-Received: by 10.112.184.196 with SMTP id ew4mr14810968lbc.17.1447090411964;
        Mon, 09 Nov 2015 09:33:31 -0800 (PST)
Received: from wasted.cogentembedded.com ([195.16.110.94])
        by smtp.gmail.com with ESMTPSA id j83sm2538953lfi.47.2015.11.09.09.33.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 09:33:30 -0800 (PST)
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
 <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org>
 <20151109144932.GE22591@linux-mips.org>
 <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5640D8E9.7080808@cogentembedded.com>
Date:   Mon, 9 Nov 2015 20:33:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49878
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

On 11/09/2015 07:18 PM, Maciej W. Rozycki wrote:

>>> I can check if things still work correctly when routed through libata,
>>> although it'll have to wait a couple of weeks yet at the least as I have
>>> wired my SWARM for hardware debugging, making it not immediately bootable
>>> and I'll be departing soon (i.e. I have no time for complicated fiddling).
>>> The host driver itself is actually in arch/mips/sibyte/swarm/platform.c
>>> BTW.
>>>
>>>   Note to self: it would be nice if physical rather than virtual MMIO
>>> addresses were reported too.
>>
>> Part of the problem is that everybody who is serious about using a Swarm
>> is using PCI PATA/SATA card, so this part receives very little TLC.  I
>> btw. can't test because the controller on my Pass 2 board is broken ...
>
>   I think I've been reasonably serious about my SWARM and despite issues
> elsewhere the onboard PATA interface is a part of the system I've never
> had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's
> still 11MB/s (and one of the 4 generic data movers present in the SoC

    If you measure it with something like 'hdparm -t', the real speed figures 
in the PIO modes would disappoint you. It's usually more like 3 MB/s even in 
PIO4...

> could be used as a DMA engine to offload the CPU if anyone bothered
> implementing that in the HBA driver).

    Oh, that's nice!

MBR, Sergei
