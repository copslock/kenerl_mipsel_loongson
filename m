Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 11:01:47 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55328 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab1ATKBo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jan 2011 11:01:44 +0100
Received: by wyf22 with SMTP id 22so435572wyf.36
        for <multiple recipients>; Thu, 20 Jan 2011 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4DoeZZu6x71npd9tbcGcYlKWyJmZK51Dv0WqBCfZZ2M=;
        b=bX+UV2MNS8j3kowOQ1s18Z7Vh0vVMHmwohcSGdMaaW/09YNGINwWTHLw7DGdJab0/R
         AmtZZ3flaj+kWTrq3rhYOzKRYzynefIfuFYxYLDyaR2TtqAwHvJXDzXcNCEKuYInLdFe
         BXN5l/nUjr4MQ3ZZPag1MrI5PtQl/fq/KaBDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i1C3edNnGzFaNPL95lcpt36UfwAmoVRwk2JiB8JbSmRbRyS/cpCqDUO38NKV3wzGpt
         2WzhfM4onnCQ0z3LC6rmp8Fr39QgiLthuDCRjL8+4eOPE1IE1sRK5efP6Fb9rZUf6jbg
         tfDbUuxslTmOOM6WlXbmeF2s4KZxcl5DxyHFY=
MIME-Version: 1.0
Received: by 10.216.52.134 with SMTP id e6mr1687408wec.49.1295517698770; Thu,
 20 Jan 2011 02:01:38 -0800 (PST)
Received: by 10.216.63.200 with HTTP; Thu, 20 Jan 2011 02:01:38 -0800 (PST)
In-Reply-To: <1294367707-2593-5-git-send-email-ddaney@caviumnetworks.com>
References: <1294367707-2593-1-git-send-email-ddaney@caviumnetworks.com>
        <1294367707-2593-5-git-send-email-ddaney@caviumnetworks.com>
Date:   Thu, 20 Jan 2011 18:01:38 +0800
Message-ID: <AANLkTi=5+QxOipaTycLBuLUHr7iOGCe0nfG9mQsKADoj@mail.gmail.com>
Subject: Re: [PATCH 4/6] MIPS: perf: Reorganize contents of perf support files.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2011/1/7 David Daney <ddaney@caviumnetworks.com>:
> @@ -1034,5 +1560,3 @@ init_hw_perf_events(void)
>        return 0;
>  }
>  arch_initcall(init_hw_perf_events);
> -
> -#endif /* defined(CONFIG_CPU_MIPS32)... */

arch_initcall should be now early_initcall.
