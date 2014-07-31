Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 19:20:32 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:43062 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860188AbaGaRU2tiD5A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 19:20:28 +0200
Received: by mail-wg0-f48.google.com with SMTP id x13so3054213wgg.19
        for <linux-mips@linux-mips.org>; Thu, 31 Jul 2014 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H1HQ1ltEMiA67J3G+QQBjG3sjuJ3SuZVdBkUCuhDpjk=;
        b=bcwmOsiq7kuymqEydy3cDTOwAw3prz9MrcB15bgWizMqhpm+roM7ZM9fd221KP/Y5R
         VljwD5rfs5LLwtBvkS5BF3waqGyYL8v/NlBscGclkQUruZSd/jemXaHCmqwm6vQBapjD
         VUEsDlvm0VjXnexVeT6s5vCnHdogdMBQxNFX4cgjKJKIVWmz4c/k8lB/cKFJ5xbyVH8N
         ZQ+KKv95RIx/P3DNrCF8nVznu5ct5Qa/7HiYiv82FZJtvK9uRQKKRdJkGQUHYTi7LGit
         lI7F2N1pXc6sCIyP/SyeT/ThOokWGW8s6+7rdNPno7GK3CBk0qnOQMkVL+52OBcRZuHX
         rnoQ==
X-Received: by 10.194.85.78 with SMTP id f14mr19321898wjz.36.1406827221315;
        Thu, 31 Jul 2014 10:20:21 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id bx2sm14684617wjb.47.2014.07.31.10.20.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 10:20:20 -0700 (PDT)
Date:   Thu, 31 Jul 2014 19:20:18 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp
 fastpath
Message-ID: <20140731172017.GF7842@localhost.localdomain>
References: <cover.1406604806.git.luto@amacapital.net>
 <20140729192056.GA6308@redhat.com>
 <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
 <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
 <20140730165940.GB27954@localhost.localdomain>
 <CALCETrUafpWfnbfZzgu3qSGqyxcG0+6A=A1RE8g++=GrQKD93Q@mail.gmail.com>
 <53DA7550.40905@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53DA7550.40905@zytor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
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

On Thu, Jul 31, 2014 at 09:56:48AM -0700, H. Peter Anvin wrote:
> On 07/30/2014 10:25 AM, Andy Lutomirski wrote:
> > 
> > And yet x86_64 has this code implemented in assembly even in the
> > slowpath.  Go figure.
> > 
> 
> There is way too much assembly in entry_64.S probably because things
> have been grafted on, ahem, "organically".  It is darn nigh impossible
> to even remotely figure out what goes on in that file.

Always warn your family and give them an estimate return hour before opening that file.
