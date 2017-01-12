Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2017 17:32:28 +0100 (CET)
Received: from mail-lf0-x231.google.com ([IPv6:2a00:1450:4010:c07::231]:34859
        "EHLO mail-lf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdALQcVqXt1I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2017 17:32:21 +0100
Received: by mail-lf0-x231.google.com with SMTP id m78so16909003lfg.2
        for <linux-mips@linux-mips.org>; Thu, 12 Jan 2017 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=T5awhpMa40jOrPvwHDOg5UUPu0c/qcmDDSHB4Qa+v/4=;
        b=mRZtGZ9qwEnd9lo3BGbblTWJh9x/rwo05Ua3SWGwxdA5Ykyz50Cw4ftgMw8OmDBHWJ
         miXlv15easQsUk9sF/6cI9hCXj8RLTZQfQO4ag+ThGESBADVPGn5sGCJxnqPFA2dpXYf
         iPEjH8jui00wreY5MNeE+XF6BRwknfVDt225mp1RMj/gpiORIMNzTN6SOyPqzjslm3vq
         IFVig51ToomTgbpeOTAYbuoYbFdiOa7rVk2nhCPNvJzLTmTRmMvVPMFhBoXV+QiY26XQ
         7I63q3/YqpVI+jzL4CvGPYgOV+GrRdSpZwxtLg9tMbVJ3Hp2LCEZxBzzruHLie/CI6FA
         zo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=T5awhpMa40jOrPvwHDOg5UUPu0c/qcmDDSHB4Qa+v/4=;
        b=C7En1hUQDASYVHEQklFZOHHltzbmIDok4H9V1C+7tcqf22JAsgdz6AlJox8a385R0Y
         MqteDA/XA3fJrXJgyL7uhH8FLwl6Pj+3lB+Hcg8foVvltMjJU7PXrbKG8bjJ2xhzE3H0
         RLf3J5wvypDQ89hf3z/x30WBJyLvx53X/19A/hBaKHF7pLvBFmEvkNAO1XUvGjq8JlXI
         UtphtFP/Yz9UGJX0TdUTVVf0L2xtfuA2b2PRRjfzhYSav/HaA7uJlDQ+IMInS6LYiBFB
         MOfTewi45BlUlQhXhqHuGlTjSlBkTa6xCUCwxo9ZbAs2uzfHk4MTA4mzgQwfZatheWbW
         qXAg==
X-Gm-Message-State: AIkVDXJxyAewbz7VA/tl9Dg3Q+DO6GbfOdln0CPF1wSWOumQM+rF0G8MeLB2605vmkxqfS8s
X-Received: by 10.46.7.10 with SMTP id 10mr5946368ljh.60.1484238736309;
        Thu, 12 Jan 2017 08:32:16 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:ec62:e68a:f008:ebc2? ([2a01:e35:8b63:dc30:ec62:e68a:f008:ebc2])
        by smtp.gmail.com with ESMTPSA id i9sm2508334lfg.45.2017.01.12.08.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 08:32:15 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 7/7] uapi: export all headers under uapi directories
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170109125638.GA15506@infradead.org>
 <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
 <alpine.LSU.2.20.1701121727180.19188@erq.vanv.qr>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Christoph Hellwig <hch@infradead.org>, arnd@arndb.de,
        mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <9d68af8a-a609-d7b1-58a9-f1155313b077@6wind.com>
Date:   Thu, 12 Jan 2017 17:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.20.1701121727180.19188@erq.vanv.qr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <nicolas.dichtel@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.dichtel@6wind.com
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

Le 12/01/2017 à 17:28, Jan Engelhardt a écrit :
> On Thursday 2017-01-12 16:52, Nicolas Dichtel wrote:
> 
>> Le 09/01/2017 à 13:56, Christoph Hellwig a écrit :
>>> On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
>>>> Regularly, when a new header is created in include/uapi/, the developer
>>>> forgets to add it in the corresponding Kbuild file. This error is usually
>>>> detected after the release is out.
>>>>
>>>> In fact, all headers under uapi directories should be exported, thus it's
>>>> useless to have an exhaustive list.
>>>>
>>>> After this patch, the following files, which were not exported, are now
>>>> exported (with make headers_install_all):
>>>
>>> ... snip ...
>>>
>>>> linux/genwqe/.install
>>>> linux/genwqe/..install.cmd
>>>> linux/cifs/.install
>>>> linux/cifs/..install.cmd
>>>
>>> I'm pretty sure these should not be exported!
>>>
>> Those files are created in every directory:
>> $ find usr/include/ -name '\.\.install.cmd' | wc -l
>> 71
> 
> That still does not mean they should be exported.
> 
> Anything but headers (and directories as a skeleton structure) is maximally suspicious.
> 
What I was trying to say is that I export those directories like other are.
Removing those files is not related to that series.


Regards,
Nicolas
