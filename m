Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 19:07:15 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:57286 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903697Ab1LQSHL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 19:07:11 +0100
Received: by iadk27 with SMTP id k27so5762989iad.36
        for <multiple recipients>; Sat, 17 Dec 2011 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=j/iVUZMpwt9PFIpTvk5XKcQxw2ViQpBWqL0rfKZE06A=;
        b=ngYRUmU7AJbEPNBEPAlcJ9N3C3KHcwOllDi5ifJmkhW0GgqQyoFkMxdGYFfzBRmBVd
         9a+c5TkkmNKWXxamtpKax/Xj1GwG7L+w60l1jry3SQmiKi9uICzLTITHOfH5VrFl4A+x
         nZvzMpN+QPfG/eo7H82XCDp40rwGlu2XqUV74=
Received: by 10.50.46.167 with SMTP id w7mr16510511igm.88.1324145224181;
        Sat, 17 Dec 2011 10:07:04 -0800 (PST)
Received: from dd_xps.caveonetworks.com (adsl-67-127-191-181.dsl.pltn13.pacbell.net. [67.127.191.181])
        by mx.google.com with ESMTPS id lu10sm21119427igc.0.2011.12.17.10.07.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 10:07:03 -0800 (PST)
Message-ID: <4EECDA43.6040004@gmail.com>
Date:   Sat, 17 Dec 2011 10:06:59 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc13 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hillf Danton <dhillf@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Subject: Re: linux-next: build failure after merge of the final tree (mips
 tree related)
References: <20111217155044.094c4c2b51af7c66e8ec90a3@canb.auug.org.au>
In-Reply-To: <20111217155044.094c4c2b51af7c66e8ec90a3@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14181

On 12/16/2011 08:50 PM, Stephen Rothwell wrote:
> Hi all,
>
> After merging the final tree, today's linux-next build (mips almost all
> configs) failed like this:
>
> arch/mips/mm/tlb-r4k.c: In function 'local_flush_tlb_range':
> arch/mips/mm/tlb-r4k.c:128: error: 'HPAGE_SIZE' undeclared (first use in this function)
> arch/mips/mm/tlb-r4k.c:130: error: 'HPAGE_SHIFT' undeclared (first use in this function)
>
> Probably caused by commit 0b07e859f87b ("MIPS: Flush huge TLB").

Indeed that is the case.

We have a patch for this issue:  http://patchwork.linux-mips.org/patch/3114/

Perhaps Ralf will push out a mips-for-linux-next containing this patch 
in the near future.

David Daney
