Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:39:34 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:42552 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491864Ab0E0Wj0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:39:26 +0200
Received: by pxi1 with SMTP id 1so270654pxi.36
        for <multiple recipients>; Thu, 27 May 2010 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ABpQcfFO81Qw6qaar7KbazVQ3ECyV8X4PBBXHFKpD+I=;
        b=B6U/mL3oGXkvXQYru4KMeDyKkwcf4D4PshVzdCgEhC4D47hYUvtr0fyatZqsxxzv7g
         OS1OQDOSqknmix5NDqBa563WXP2ZJe8v1Ospr3gKH5I+HX1lae8NHnxdv9LrH0FqOLlM
         ngE018z7z4s0zOXgkkP7MP+0yP1WpAHQt3Res=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aHTfOpzsDQs6/qg2rpp+y3sdPm9K3tEm9iU7F4QNvdkTNrgr6FFl/aErZDi+RZitLh
         AuzFuduSA37MNI2MPCObXnK01pME4bgAk+pb3u9fNDPJIMbDCU7NZiMVUhfJ3hcYEKas
         yyq8mYJJsqNHH3OWIyj0k1bV9PSvIZv1anIVc=
Received: by 10.142.56.10 with SMTP id e10mr239582wfa.156.1274999958752;
        Thu, 27 May 2010 15:39:18 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id h18sm951367wfg.13.2010.05.27.15.39.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 15:39:18 -0700 (PDT)
Message-ID: <4BFEF494.9000406@gmail.com>
Date:   Thu, 27 May 2010 15:39:16 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 05/12] MIPS/Perf-events: add callchain support
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-6-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-6-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> This patch adds callchain support for MIPS Perf-events. For more info on
> this feature, please refer to tools/perf/Documentation/perf-report.txt
> and tools/perf/design.txt.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
>   arch/mips/kernel/perf_event.c |   98 ++++++++++++++++++++++++++++++++++++++++-
>   1 files changed, 97 insertions(+), 1 deletions(-)
>
[...]
