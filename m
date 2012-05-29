Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2012 08:53:15 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:45978 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903544Ab2E2GxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2012 08:53:08 +0200
Received: by vbbfo1 with SMTP id fo1so2695292vbb.36
        for <multiple recipients>; Mon, 28 May 2012 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ioR/RRJR6ly/G5UOpXKQQXnLe/VttkoAA+qBXXfV9KU=;
        b=lG8W8udH+AwGM6uaXrg1KFHsDZ6PxPsOOG877H/wB4Kdf/Kwhbv9akCaAz6/YWT6SA
         mxkGuFUr919KJD/JwGzHi6tCdZFKyabVSl3K2nvNzI6FiYwxeunMgciFL+AmkDIZ092U
         /3vcF3Qpod0HdU/8JVjdKjlJIPwLH6WtJV0aUYWyhldt3B/4I4iCipBJTDUp17lcySzZ
         saD82HuIiPoQt4wX841jRV6AICrNaOStY6N4Gav3CtSZsX5rDUKyIvJJvXT87zETF+vC
         bjvdYvE/u+AYShOswIFO1KprKuzrQLEKqteihbdLNO3FCbv3yg5IvIjX/XiGoU4QAofN
         MwQw==
Received: by 10.220.214.8 with SMTP id gy8mr11607686vcb.45.1338274382107;
        Mon, 28 May 2012 23:53:02 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id bj6sm22888431vdc.12.2012.05.28.23.52.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 23:52:59 -0700 (PDT)
Date:   Tue, 29 May 2012 14:52:48 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com,
        Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, axboe@kernel.dk,
        jeremy.fitzhardinge@citrix.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with
 irq disabled
Message-ID: <20120529065248.GA2597@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
 <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com>
 <4FBA1B54.3@linux.vnet.ibm.com>
 <20120522062126.GB12098@zhy>
 <4FC369E3.1030901@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FC369E3.1030901@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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

On Mon, May 28, 2012 at 05:34:51PM +0530, Srivatsa S. Bhat wrote:
> No, I think you are right. Sorry for the delay in replying.
> It indeed looks like we need not use ipi_call_lock/unlock() in CPU bringup
> code..
> 
> However, it does make me wonder about this:
> commit 3d4422332 introduced the generic ipi helpers, and reduced the scope
> of call_function.lock and also added the check in
> generic_smp_call_function_interrupt() to proceed only if the cpu is present
> in data->cpumask.
> 
> Then, commit 3b16cf8748 converted x86 to the generic ipi helpers, but while
> doing that, it explicitly retained ipi_call_lock/unlock(), which is kind of
> surprising.. I guess it was a mistake rather than intentional.

Agree. I think it's a mistake(or leftover) too :)

Anyway, let me cook a patch to throw a stone to clear the road.

Thanks,
Yong
