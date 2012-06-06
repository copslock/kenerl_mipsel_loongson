Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 12:53:55 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43316 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903701Ab2FFKxs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 12:53:48 +0200
Received: by lbbgg6 with SMTP id gg6so5571848lbb.36
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 03:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=JRMtM/xQ9SjDwq/z3PCRH9ufA39d3vEDy7KviIycajs=;
        b=GWmWDdo0EHDRpCS44NNwZe5zXp186FWReWj7NK3ZAdsTZGZXsVrv8ABW2FOe/acv3c
         XuJpkAW4+dPPel29+DECNTFOwdT8xRY31LNlslEWiy+vIBjOQroMFH02cU5QuKbcw1eb
         61mzfmYjDrmmBBeJznEb4am6Cjp5ZZp+VQeacx7TkOoh3WCyMXSYxYhRXgnsfHkm2tI3
         7rOAAuDnx/he0AERmgx4humS8CL2jMWK9b67HQw27dC54in7813Y+WcjHc6vQQSk/XA+
         434bb7i+lnOLLfVuqjUzMb5so+S+qtApZTgSLIQXdvvFUIhBsa1hVDkh7qGN6VEpAHY8
         /MQA==
Received: by 10.112.25.106 with SMTP id b10mr9656161lbg.36.1338980021871;
        Wed, 06 Jun 2012 03:53:41 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-181.pppoe.mtu-net.ru. [91.79.86.181])
        by mx.google.com with ESMTPS id hm7sm2270479lab.12.2012.06.06.03.53.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 03:53:40 -0700 (PDT)
Message-ID: <4FCF3694.206@mvista.com>
Date:   Wed, 06 Jun 2012 14:53:08 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Alex Shi <alex.shi@intel.com>
CC:     a.p.zijlstra@chello.nl, anton@samba.org, benh@kernel.crashing.org,
        cmetcalf@tilera.com, dhowells@redhat.com, davem@davemloft.net,
        fenghua.yu@intel.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        mattst88@gmail.com, paulus@samba.org, lethal@linux-sh.org,
        ralf@linux-mips.org, rth@twiddle.net, sparclinux@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, sivanich@sgi.com,
        greg.pearson@hp.com, kamezawa.hiroyu@jp.fujitsu.com,
        bob.picco@oracle.com, chris.mason@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mingo@kernel.org, pjt@google.com, tglx@linutronix.de,
        seto.hidetoshi@jp.fujitsu.com, ak@linux.intel.com,
        arjan.van.de.ven@intel.com
Subject: Re: [RFC PATCH] sched/numa: do load balance between remote nodes
References: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
In-Reply-To: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQngGdQ8DF+gcqoXhZYntN02t0UbITXR4tQ/dd8f8MOjt7R2UOE8qIm3bTgMvw99RGv9rQna
X-archive-position: 33564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 06-06-2012 10:52, Alex Shi wrote:

> commit cb83b629b

    Please also specify that commit's summary in parens.

> remove the NODE sched domain and check if the node
> distance in SLIT table is farther than REMOTE_DISTANCE, if so, it will
> lose the load balance chance at exec/fork/wake_affine points.

> But actually, even the node distance is farther than REMOTE_DISTANCE,
> Modern CPUs also has QPI like connections, that make memory access is

    "Is" not needed here.

> not too slow between nodes.  So above losing on NUMA machine make a
> huge performance regression on benchmark: hackbench, tbench, netperf
> and oltp etc.

> This patch will recover the scheduler behavior to old mode on all my
> Intel platforms: NHM EP/EX, WSM EP, SNB EP/EP4S, and so remove the
> perfromance regressions. (all of them just has 2 kinds distance, 10 21)

> Signed-off-by: Alex Shi<alex.shi@intel.com>

WBR, Sergei
