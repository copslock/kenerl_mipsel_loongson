Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 20:44:20 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:49260 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820513Ab3ADToTquM6i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 20:44:19 +0100
Received: by mail-la0-f51.google.com with SMTP id fj20so10097213lab.24
        for <linux-mips@linux-mips.org>; Fri, 04 Jan 2013 11:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=f/qIS7csv+7S92xYwzs8Yh7E285UKmwCDR7VTITzdH4=;
        b=T84xqdlkpf21hd8+36WhqqsIywL4Ph+N+Buo8Br1khj8x2eZfOj/QjnBW3TgiUKYpC
         vWnrQ2I+GZ4cv23JPEM51EnI+IArF60clvWSYbNub+nyDLuaE38FXJNwHyqwe1E1NJNz
         VKvEJk8+1l5GLwN0usVjAi+34AseYrwEFRlzqW08GD2OAfNDgVx3+Q9I0tFElG9aw7iN
         uX86rlWuC5D81RIOJB/YmXaH4YjNP6iCk/VXvGcQQCOKPrOjhZZpWOL+pqpmWHXJ/jHm
         KjtKvktqpB/LNxR2PtNCPqCWjjXNIr5Luiun2d9nEAD15SKHKBo3Q8v3SmhXjuvJ2JbT
         0mAQ==
X-Received: by 10.112.17.108 with SMTP id n12mr20489224lbd.21.1357328653767;
        Fri, 04 Jan 2013 11:44:13 -0800 (PST)
Received: from wasted.dev.rtsoft.ru (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id u5sm18214231lbm.8.2013.01.04.11.44.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 11:44:12 -0800 (PST)
Message-ID: <50E73EB6.9090100@mvista.com>
Date:   Fri, 04 Jan 2013 23:42:30 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
CC:     Russell King <linux@arm.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, mhocko@suse.cz,
        srivatsa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line
 of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org> <50E6C776.7060707@mvista.com> <20130104192934.GB29866@quicinc.com>
In-Reply-To: <20130104192934.GB29866@quicinc.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQloT3DHFxnSeSz8+laetL+MAz4Cfz38wkd59v9RYheqelRB+20PukV1bbfqAoch+RpiGpN8
X-archive-position: 35375
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

On 01/04/2013 10:29 PM, Srivatsa Vaddagiri wrote:

>>> With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
>>> don't need the check for cpu_online() introduced in commit 7386cdbf. Offline

>>    Please also specify the summary of that commit in parens (or
>> however you like).

> I had that in Subject line, but yes would be good to include in commit message
> as well. I will incorporate that change alongwith anything else required in
> next version of this patch.

   Ah, that was a revert with atypical subject -- didn't notice. Then there's no
need to specify it twice.

> - vatsa

WBR, Sergei
