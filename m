Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 13:10:37 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35953 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013340AbbLHMKejBbdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 13:10:34 +0100
Received: by lbblt2 with SMTP id lt2so9877718lbb.3
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2015 04:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=dRCi3GvwQN8yxeZAVGuCY5+4yh78dNyjWFKQ9kS340g=;
        b=k3qxALxu55r3I9mCCyYpGVMSWfnnNmKW2GqDKmZIgziDoLPSxeUPojut81RbvuSchw
         hdERrBEpsFmQAqOdDe707gR8Ae2RazAq/lthJG8k2BlbPqiCShGkzTTlMbGjaG7J/erY
         1l+QpRyZFSfaqBbxmcItuHDkWJCpi0Ly957Bnf8Q9llo/546HTP8belQBvs6tpMtTnxV
         suy3e3wJnxCFAi5dBV1ooB5xrg08mwL6LQOQtB8Tjao58+lQgb+ReQtajEv7aLHDWBOX
         0/LbPUVEJ6LXSgSQhE+UaVpRdjVWgLjM06kzynaOIVWRXMc0Mc5VzIkO/kDrrqLsP9ad
         AigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dRCi3GvwQN8yxeZAVGuCY5+4yh78dNyjWFKQ9kS340g=;
        b=X4O4O+XE89DfKedwEOIRa319n93/NIqwBLdqoF3slwR6gGM0MCEWUVIGmBepqng2J3
         oNkc39aE8uffuFd+ZmVByH1Lh0ggfbEI/jFVmcK+bjUxSqlvEmdXSpFrgt5AroKVhKku
         Ia1r5t0WQj65jxupqd5M6e2z6YamL4cP9WRN47xqeucszhNS3FUCtxAhHcpogPGjqJIQ
         uruylnfoqzrqhy9b0uJGqBSP/wOiQ7HzYkcXJkC6xja40UUOzvvLXT1fg1Kjj4eD0wTf
         xmni6bKRcLS8+V+08rjLOnLYZMGTLS0qqtKWuGswScpT/PVHwvcJJ92EYE5l+vzflNBX
         fLsg==
X-Gm-Message-State: ALoCoQkSggGUDKDaQqX9I1OVHIZCQBY+whqAK8+/SwW8CfHgVz9vEGqsUm5+DBVBfa2ZQKT/0y4qJDo3XykXjimkiNIBwOMs9A==
X-Received: by 10.112.200.40 with SMTP id jp8mr1371751lbc.104.1449576628961;
        Tue, 08 Dec 2015 04:10:28 -0800 (PST)
Received: from [192.168.4.126] ([83.149.8.57])
        by smtp.gmail.com with ESMTPSA id au8sm523719lbc.31.2015.12.08.04.10.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Dec 2015 04:10:27 -0800 (PST)
Subject: Re: [PATCH] MIPS: VDSO: Fix build error
To:     Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org
References: <1449569503-1611-1-git-send-email-qais.yousef@imgtec.com>
Cc:     alex@alex-smith.me.uk, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5666C8B2.2030402@cogentembedded.com>
Date:   Tue, 8 Dec 2015 15:10:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1449569503-1611-1-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50420
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

On 12/8/2015 1:11 PM, Qais Yousef wrote:

> Commit ebb5e78cc634 (MIPS: Initial implementation of a VDSO) introduced a build
> error.

    scripts/checkpatch.pl now enforces certain format for the commit citing -- 
you also need to enclose the summary in "".

> For MIPS VDSO to be compiled it requires binutils version 2.25 or above but the
> check in the Makefile had inverted logic causing it to be compiled in if binutils
> is below 2.25.
>
> This fixes the following compilation error:
>
> CC      arch/mips/vdso/gettimeofday.o
> /tmp/ccsExcUd.s: Assembler messages:
> /tmp/ccsExcUd.s:62: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}
> /tmp/ccsExcUd.s:467: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}
> make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
> make[1]: *** [arch/mips/vdso] Error 2
> make: *** [arch/mips] Error 2
>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
[...]

MBR, Sergei
