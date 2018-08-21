Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 06:55:50 +0200 (CEST)
Received: from mail-qt0-x234.google.com ([IPv6:2607:f8b0:400d:c0d::234]:33142
        "EHLO mail-qt0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbeHUEzqpGuHN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 06:55:46 +0200
Received: by mail-qt0-x234.google.com with SMTP id r37-v6so11597048qtc.0;
        Mon, 20 Aug 2018 21:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S/M7KTeZpkAJf6OUt4/CSxp0s4dYx9ldyRPwUvhY+1M=;
        b=HUIFPXxQ8jTNnmCgkFcmc4wcWsYJ9QvvKO1oe9wPNCAFnMRmKViwb8H008A0JvPiiD
         Lz2ADcq+cZ2w8IQUOya+MYL+G7KrCdV2sshUVq9psC/3KBQvvVpv5XNt9PkiVPnmY23e
         n1O7wbeqsZSMfqaPDTh/M7lF5fI0rQqlk2EqZsz8KQIBFlbtvL6MSjKLyw9qbsXL9+6L
         RmXbgd+XvwPq+JnU3s3l1kJWWyTGqcBpqMUfnm1oeFwhvxOvbWMj32OrfHAn5Yp/Q7NB
         G8bEV/ghquO99sKyqQi8p5pBsnAT6YPLKfWC2PKndjAq25MSl3kyGCV27dB6dZFFHM8n
         zq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S/M7KTeZpkAJf6OUt4/CSxp0s4dYx9ldyRPwUvhY+1M=;
        b=rwZovr/rKIIuC2Si0KTh/gMUE/XvktmJZoGSMiKnYoP73ODLkNpOOwJ6QhKXQmw39n
         VbU6u/S6lev2EaGv7yEVvIxGwDMQpdqxHT75x4TSCdwX81fz1aLB+5d2T5ypRsMGTRWz
         cPUygPCTjhDPlk+WIluxgFAmtVztrAiwLFErUEgKmWHkRXIJHRGYWyetr8oVG8ZRiQfB
         /wDxSicHARr5NWruvoHVHvi2nkDfLoK9qqc5WOVcFKGyPZ0HEBVA7DAipQiem+6v37yg
         4/mF9TUypxxJuCx3D3u0wo2peyII+aYSAzsVFVohrXd8gSh+mj2X7Dm3eGuBC9VGk9vt
         067Q==
X-Gm-Message-State: AOUpUlFluTrnYCEqo/4TV9Dt8X5RhfaTZYsbkmBYU32tcPjfRCTjs5MU
        TKldeZX3UyZksVPXFuNLVQ02eX5/NzOAwPXm418=
X-Google-Smtp-Source: AA+uWPzMyIcwAGJCFfE4S3ZO2DaOF8y5IJHEAd1cnt+LXIg7f/ZqQ8iX7lKGogPZVqYk3ACudo0bsgvPQPOAx2edYcQ=
X-Received: by 2002:a0c:8441:: with SMTP id l59-v6mr44227233qva.5.1534827339478;
 Mon, 20 Aug 2018 21:55:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 21:55:38
 -0700 (PDT)
In-Reply-To: <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com> <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 20 Aug 2018 21:55:38 -0700
Message-ID: <CAPhsuW4SQA+uu9=a2jT+KW0Yq=yCyWqe13KtsB_ATTMiNzCXkQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
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
X-archive-position: 65673
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

On Mon, Aug 20, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
>> root@virt-test:~# ~/a.out
>> 11
>> semaphore 0
>> semaphore 0
>> semaphore 2      <<<  when the uprobe is enabled
>
> Yes, this happens when multiple vmas points to the same file portion.
> Can you check /proc/`pgrep a.out`/maps.
>
> Logic is simple. If we are going to patch an instruction, increment the
> reference counter. If we are going to unpatch an instruction, decrement
> the reference counter. In this case, we patched instruction twice and
> thus incremented reference counter twice as well.

Yes, this makes sense.

Song

>
> Ravi
>
