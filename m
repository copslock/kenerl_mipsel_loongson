Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 23:20:48 +0200 (CEST)
Received: from mail-ve0-f174.google.com ([209.85.128.174]:49992 "EHLO
        mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819473Ab3IYVUpyChfQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 23:20:45 +0200
Received: by mail-ve0-f174.google.com with SMTP id jy13so238751veb.33
        for <multiple recipients>; Wed, 25 Sep 2013 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gX8/+sOyiFfbe1fCPomHKE4cQ4LwYJUKJVRdF3cCSPU=;
        b=NWPtiGyXusSlWFnlhMRTfcGMVlN0pGTqlxZLXZq4fVXHr77R4pILWM1ru2yJ5i4oDg
         ZiH9nkXJi3spg7GQpuzdZMcrDE7JPEi0n5uyEUQJYEAnUyFoz7poz21ADEpOUqjo/676
         KU8Fk7bi/JCB0XcnA12DBilKT25W/GYZyUjPKE7lPR+1sjUNZ24VlEH1fuiLE7jdC4gn
         NH1fJ4ZggmY5HJZ4L7eUC4T9gRWCshP8BYfeTBLTlA2I8gmc1wa1HlZTFB1Qcdvhzw3h
         cYvjXZ9CQaghFsdqbDsCbRxq7lBwIlvNbSVE1rMt4+QRhVMvRP+ge9tdaOLPItK3V7as
         fnlw==
X-Received: by 10.58.181.230 with SMTP id dz6mr2105785vec.35.1380144040006;
        Wed, 25 Sep 2013 14:20:40 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ut6sm15407288vec.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 14:20:39 -0700 (PDT)
Message-ID: <524353A5.9000506@gmail.com>
Date:   Wed, 25 Sep 2013 14:20:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V12 09/12] MIPS: Loongson: Add Loongson-3 Kconfig options
References: <1380100546-8302-1-git-send-email-chenhc@lemote.com> <1380100546-8302-10-git-send-email-chenhc@lemote.com>
In-Reply-To: <1380100546-8302-10-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/25/2013 02:15 AM, Huacai Chen wrote:
> Added Kconfig options include: Loongson-3 CPU and machine definition,
> CPU cache features, UEFI-like firmware interface, HT-linked PCI, and
> big memory support.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>   arch/mips/Kconfig          |   29 ++++++++++++++++++++++++
>   arch/mips/loongson/Kconfig |   52 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 81 insertions(+), 0 deletions(-)
>

You probably should move the arch/mips/loongson/Platform change from 
patch 1/12 to this patch.

David Daney
