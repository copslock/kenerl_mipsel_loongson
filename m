Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 20:50:47 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:55985 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860192AbaGaSufqAwYP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 20:50:35 +0200
Received: by mail-la0-f51.google.com with SMTP id pn19so2377583lab.38
        for <linux-mips@linux-mips.org>; Thu, 31 Jul 2014 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UH/jAbTV2ZBMDfKhF1Q3J2eE1izsJ6uFZRw2SRU0KMk=;
        b=ct34lVLYOhUYuF+vXsOaS3owPhv/of/mQ7EUlNXGAevW7YcqTGrM8LiOpu7876jGJM
         +kIpfifU9miHpt7kq9PVNIB7mAYs07rtZyGrIARUSWNhx+bbCtGQcLRTa+WBrc7vD1oN
         bxgGBKBD4Y5U/xz0/rpH5GvGSqRdShJM1Z7YEleA6iM7Bf5MYIdnc/ri/qRH49YOmiBN
         rdJ/qNDD0MEJqbm2MSlFKbZKK7dk8PREyHAqOdgItUA3Ggm04pwpJ0Sx6V8G9rdnyApY
         CKw2CnrIIUMVIxl7u2r22abzPl+cBk0YTQUPM1OE2lnqzljZSR2WDam/ineHh5KL1iiW
         yVsw==
MIME-Version: 1.0
X-Received: by 10.112.99.231 with SMTP id et7mr85395lbb.75.1406832629824; Thu,
 31 Jul 2014 11:50:29 -0700 (PDT)
Received: by 10.112.139.166 with HTTP; Thu, 31 Jul 2014 11:50:29 -0700 (PDT)
In-Reply-To: <20140731184729.GA12296@localhost.localdomain>
References: <20140728173723.GA20993@redhat.com>
        <20140728185803.GA24663@redhat.com>
        <20140728192209.GA26017@localhost.localdomain>
        <20140729175414.GA3289@redhat.com>
        <20140730163516.GC18158@localhost.localdomain>
        <20140730174630.GA30862@redhat.com>
        <20140731003034.GA32078@localhost.localdomain>
        <20140731160353.GA14772@redhat.com>
        <20140731171329.GD7842@localhost.localdomain>
        <20140731181230.GA18695@redhat.com>
        <20140731184729.GA12296@localhost.localdomain>
Date:   Thu, 31 Jul 2014 20:50:29 +0200
Message-ID: <CAFTL4hyHh3Bw0eeJe9q50HVrt=B-zgmyu6C_hy+RoW21kQEJtg@mail.gmail.com>
Subject: Re: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86: Split
 syscall_trace_enter into two phases)
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-arm-kernel@lists.infradead.org>" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41854
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

2014-07-31 20:47 GMT+02:00 Frederic Weisbecker <fweisbec@gmail.com>:
> On Thu, Jul 31, 2014 at 08:12:30PM +0200, Oleg Nesterov wrote:
>> On 07/31, Frederic Weisbecker wrote:
> No, because preempt_schedule_irq() does the ctx_state save and restore with
> exception_enter/exception_exit.

Similar thing happens with schedule_user().

preempt_schedule_irq() handles kernel preemption and schedule_user()
the user preemption. On both cases we save and restore the context
tracking state.

This might be the missing piece you were missing :)
