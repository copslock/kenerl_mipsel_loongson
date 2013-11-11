Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Nov 2013 21:01:05 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:43255 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827340Ab3KKUBDXQ4PK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Nov 2013 21:01:03 +0100
Received: by mail-ie0-f179.google.com with SMTP id u16so5070184iet.38
        for <linux-mips@linux-mips.org>; Mon, 11 Nov 2013 12:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7b94Ju7gsU9nfAqxljpluFahKbxHYMHvw0k+p1ZDsbg=;
        b=S3wiloEqxjacu5cSNyy1JmgObEGCuY50jLo9OIkryPESZw120FYX3U+XOTFx/RoBaO
         vj4PCryc8I7xMQwm2gniexv7uvS33kLAscZ2ZLHePm/xcY/KH2X+Csju5eXtEz9pOES4
         CLABr8Ccca6yWVh2nsuYeprcOz3ntGTsIrwhmtU+VZNFV3w5mDV3/HpFAmIOlpHGL77x
         qNE4k6+isATdmxPhrakMxcgcpjM/iJn9m/lDFd983p6d28i/YaN2078F5jOSDCjbEU3N
         p1NeEUrAM6AjUj5S3bUOehHQZ9rIXpnuOZ/kf7NCuMCVfVFnxpQJjHGif46KQaqFtqQg
         p4Tg==
X-Received: by 10.50.11.11 with SMTP id m11mr13474330igb.47.1384200057524;
        Mon, 11 Nov 2013 12:00:57 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ka1sm20389374igb.7.2013.11.11.12.00.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:00:56 -0800 (PST)
Message-ID: <52813777.7040804@gmail.com>
Date:   Mon, 11 Nov 2013 12:00:55 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 1/6] MIPS: Add missing bits for Config registers
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com> <1383844120-29601-2-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1383844120-29601-2-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38500
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

On 11/07/2013 09:08 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

This seems good to me.

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/include/asm/mipsregs.h | 40 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 38 insertions(+), 2 deletions(-)
>
