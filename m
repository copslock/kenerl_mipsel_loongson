Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 19:12:24 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:34856
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHMRMV07H0F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2018 19:12:21 +0200
Received: by mail-qt0-x244.google.com with SMTP id r21-v6so18221887qtm.2;
        Mon, 13 Aug 2018 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FyKlPWaqJErS3JIsjdzMmbOqdIKa+Re5E+4OZqAi45g=;
        b=dHtozOblEv6E+xSqjs4SZTyK3xt/+OMvNEgkHctE+hTBUF4SJQBuJrR2Q0bDMIknrp
         F/GLqLcXk2xWTEr2d1VyvnWUgLQFYjubc8JRLdVgJfblTV4Jqvz7WCt5m2HfkMB0SeXP
         ImVp6UGS5+AcXFsySDYzP9iKJGvOAthfvAKS50bNhazvJhFuqtn+ADQvy7RfqtG5BJR8
         345YxwXlFg99MdjYdRvU/Po3BkHJ8B2k9rzIlmF6blEja37vhARxMCHYWwEQi+OxZqs8
         o4vmzxgjUK4hqxwWvJ2yfPmbj9wwddNc3oxJIPMaGSk8TGUVHbv4LM4A0i0kMKqlCxd4
         mOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FyKlPWaqJErS3JIsjdzMmbOqdIKa+Re5E+4OZqAi45g=;
        b=q+FuZi4Bu/nAUjjOF787RoFyDoGnI7MZrHLUpHpEya8oJW/FTDQ2Vs9oklLS0oOJV8
         wqCjgmf0CK2i5SoDHBnpJi2JVZ58YWyHxNXrmO1PHLGeWqhauz6SACylEqRloKnAOqma
         rg++Xqa0adNaRXsQnh90DWftnTaon6qiQrTjK3ong/LfOF/OEVybaD2fM3dr4kIE3mDD
         fcHmKNS4JDzmLnJPw3MCyFY2f6Ba8yVZCNT8ESgdSTalOqK/xTOMIk176BR5Lk2faV/u
         P1UbDPtbdjR9fdGW6H5RMNf/d1VDqtfSNHzH7tmFcGXd89V8s4GNP58+6xnCgpWeDbx2
         d18g==
X-Gm-Message-State: AOUpUlHeruARad0fuaA3ews81mRnjAQPKq+9QUcbRlpo4XA+2HnJuc1y
        TEQiZ+6Omykz6Z3/aSAkQVYw+dGI8IlDHhYpsrk=
X-Google-Smtp-Source: AA+uWPzJjOtHmMCCepYDBpc2pdj1MWph3b5chrBdcP6xjh26c1ZoInYIUf7zHsxK+8oSqsb0NEBVUaQQpSjvNIO3HE0=
X-Received: by 2002:a0c:f883:: with SMTP id u3-v6mr15954417qvn.28.1534180335332;
 Mon, 13 Aug 2018 10:12:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 10:12:14
 -0700 (PDT)
In-Reply-To: <20180813131723.GC28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com> <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com> <20180813131723.GC28360@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 13 Aug 2018 10:12:14 -0700
Message-ID: <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 08/13, Ravi Bangoria wrote:
>>
>> > But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>> > hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>
>> I'm sorry. I didn't get this.
>
> Sorry for confusion...
>
> I meant, if only exec*( could race with _register(), we could add another uprobe
> hook which updates all (delayed) counters before return to user-mode.
>
>> > Afaics, the really problematic case is dlopen() which can race with _register()
>> > too, right?
>>
>> dlopen() should internally use mmap() right? So what is the problem here? Can
>> you please elaborate.
>
> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
> because dlopen() can race with _register() too, just like exec.
>
> Oleg.
>

How about we do delayed_uprobe_install() per file? Say we keep a list
of delayed_uprobe
in load_elf_binary(). Then we can install delayed_uprobe after loading
all sections of the
file.

Song
