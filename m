Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 08:38:20 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33196
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbdCGHiNGvDgW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 08:38:13 +0100
Received: by mail-wm0-x241.google.com with SMTP id n11so17282308wma.0;
        Mon, 06 Mar 2017 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9l6sGPEpQKFnsLkc0YbbmYooRuA3AiFYHl4BwU+xyIM=;
        b=GN6jjwdKAV9vURBs9Ltv5TzSElODbE57LYfchjwXRcJr3MFs/Ox6LKJDfCqPn1KtXc
         FHY7i81TVYbhGvSUfEHR8oQv+BRXSzCVbxatZ33Uk5SPjD3Jmcy6Sa7F2vk/imbxbcm1
         /gfNm8rgFlzcmf80cRL0j0SZSr4lHcp9CEigGd+OXGyFXX2yaZJ/vGKDMX+o0wK4x00/
         AJPUhv1QumN2Mab/YTM/AA8F3YUAEYduzTvofeUaT2HNIAbyaDBK2Ejqqlj/PgmDxMsr
         /7SmTifBluoWpQAJ033KDvwbpI2AUfgMUXQXw8kdnOjyarWYSVZEJUgAR22hsTUd64/w
         U95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9l6sGPEpQKFnsLkc0YbbmYooRuA3AiFYHl4BwU+xyIM=;
        b=jRS8Jtp3rmB8hoi3M9eOZ9oq4rFOS+qPkxEymj1ETl3nk8KBArLxCYIBgHhGK/lazt
         OKpF8XMN2ylYRdSWrfO5G7fX+K42JoTS9axpwoLlku7SC07SUDlr9A0IhMBesS/fPzwF
         HpEgA6cLXFbeMz9RIBtQwgKcvJivKUn3FZgynnUMeL4nMnIneikLB3il/XB+BMv1UOag
         CDmvr5ArDva3K36lPCPhGxRjgRjzikCoZwGtFBs8uY95YQ4nGOeiEbqVguqHU3RtG2EM
         MNmfuYssc8thAAQEwABq0sZuVJDYSHuvR20haPF1xGyTFfzmfaMH9PoBpCtFfPDy8W9c
         3KsQ==
X-Gm-Message-State: AMke39lfj+E6c2gTEx8JwSsGeX7K6neEvHUiwQX4u7TbXhBFyxbHJbdVzolmKK6SbhvPCw==
X-Received: by 10.28.66.77 with SMTP id p74mr17817962wma.107.1488872287832;
        Mon, 06 Mar 2017 23:38:07 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q12sm17799320wmd.8.2017.03.06.23.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 23:38:07 -0800 (PST)
Date:   Tue, 7 Mar 2017 08:38:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] MIPS: Fix build breakage caused by header file changes
Message-ID: <20170307073805.GB15693@gmail.com>
References: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
 <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* James Hogan <james.hogan@imgtec.com> wrote:

> Hi Guenter,
> 
> On Mon, Mar 06, 2017 at 11:13:55AM -0800, Guenter Roeck wrote:
> > Since commit f3ac60671954 ("sched/headers: Move task-stack related
> > APIs from <linux/sched.h> to <linux/sched/task_stack.h>") and commit
> > f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
> > <linux/sched.h>"), various mips builds fail as follows.
> > 
> > arch/mips/kernel/smp-mt.c: In function ‘vsmp_boot_secondary’:
> > arch/mips/include/asm/processor.h:384:41: error:
> > 	implicit declaration of function ‘task_stack_page’
> > 
> > In file included from
> > 	/opt/buildbot/slave/hwmon-testing/build/arch/mips/kernel/pm.c:
> > arch/mips/include/asm/fpu.h: In function '__own_fpu':
> > arch/mips/include/asm/processor.h:385:31: error:
> > 	invalid application of 'sizeof' to incomplete type 'struct pt_regs'
> 
> This one is in an inline function, so I think it'd affect multiple
> includes of <asm/fpu.h> even if __own_fpu isn't used, so I think the
> following patch which adds the include ptrace.h in fpu.h is more robust
> than adding to the individual c files affected:
> https://patchwork.linux-mips.org/patch/15386/
> 
> Admitedly it could probably have a more specific subject line since
> there are more similar errors.

Just a quick question: is your MIPS build fix going to be merged and sent to 
Linus? I can apply it too, and send it to Linus later today, together with a few 
other sched.h header related build fixes.

Assuming it's all properly tested - my limited MIPS defconfig builds worked fine - 
but MIPS has a lot of build variations.

Either way is fine to me.

Thanks,

	Ingo
