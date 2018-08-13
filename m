Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 18:27:45 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:42135
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHMQ1mogRiF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2018 18:27:42 +0200
Received: by mail-qt0-x243.google.com with SMTP id z8-v6so18005859qto.9;
        Mon, 13 Aug 2018 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uC8monHxjKqVjpXWcdlPRgoEs2V7pkwvVylPOwryAYM=;
        b=S9l1hy+Z2e5Q2m4c7sfs/sMuJNbg3zVC02Hn/cikLvB5p0ukrrI2lXVhM/vNaoE0hC
         Cm5veF2CpnFpSWrb7Db5Qh0Cec3NAdz0Q21unE+eIkwSnTHDKuN69R0rWvq40dDKm5is
         85oYpaJJDFdny/gmUYb+FUjmQRdXTe6XrwaLiY9M5Kr2X6wP15vIfNTk+e+AVkEcTX/0
         OR4YFQ9TXeYR6/tRZ8cFtSxQFq4oITJntTHiJ9GyJtp+ZjG95dfPgOvWPNu2yNxA5W53
         qkwlsgWdPAux9pH4JcehFM7p/GH2rHYeBHr+PGpVzs8thAxLjyUrIePJK6N0RvkU2pTq
         IMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uC8monHxjKqVjpXWcdlPRgoEs2V7pkwvVylPOwryAYM=;
        b=X6utsfBCPC2MSbzYyYHl0x3O3H1Ulb1Y6vtf2o9oTRq2yvyLFEFqION9ALq999JJ17
         t0LW7x5FaYDHw1KU3bPHSYqnZenFEilMVczQhqtsLI6YRmm6KhQ1cMU49bLw8Ej38+tQ
         XxZmH596H9+wR++qAltJtFy5tONG9CuW78zT9kWOKgxxKL4AygCSJUZFJjUZDpBH190j
         qBSP/vyJrGLtk78CXg/ai6hOFLWJyiQUM92x5Aeet0lwKxEznrWU59btbT/4+Ph3XD/K
         a19WJTGOAJ03PzTvdNJftBHfjnqx+a3rt4kneD94F70W8eCzmd7Qes4l0AbDYHCHP4Ac
         lrJQ==
X-Gm-Message-State: AOUpUlE6ccFJ2mn9oVbhxYeCHjMSMgLL92rROC0hhVCOA4RG/Sy6MLcj
        7vWtEQOOiUGvjuh61yj53NySxqv8JDCUxC823/E=
X-Google-Smtp-Source: AA+uWPynQU823Uc7kPp0ZqGRtEa3NhsmMyN6W4urnaKAHvdBPdlAeg4bfEkpUru3kudcrNhCnAsLZHtBmn/FEsLfGac=
X-Received: by 2002:aed:3688:: with SMTP id f8-v6mr17954184qtb.276.1534177656589;
 Mon, 13 Aug 2018 09:27:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:27:36
 -0700 (PDT)
In-Reply-To: <20180813084922.GB44470@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-6-ravi.bangoria@linux.ibm.com> <CAPhsuW5g1dOnceA=kqfpC+rR6EguJaR+wPwY9nSWLbGSSj5XjQ@mail.gmail.com>
 <66f84261-aa3e-4692-a124-09537fda4312@linux.ibm.com> <20180813084922.GB44470@linux.vnet.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 13 Aug 2018 09:27:36 -0700
Message-ID: <CAPhsuW4Vo0Py9EmiAx64v1ExwH49NuPaXYWr9Hmm6mLFewbHog@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
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
X-archive-position: 65569
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

On Mon, Aug 13, 2018 at 1:49 AM, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-13 13:49:44]:
>
>> Hi Song,
>>
>> On 08/11/2018 01:42 PM, Song Liu wrote:
>> > Do we really need this given we already have PATCH 4/6?
>> > uprobe_regsiter() can be called
>> > out of trace_uprobe, this patch won't catch all conflicts anyway.
>>
>> Right but it, at least, catch all conflicts happening via trace_uprobe.
>>
>> I don't mind in removing this patch but I would like to get an opinion of
>> Oleg/Srikar/Steven/Masami.
>>
>
> I would suggest to keep it, atleast it can ctah conflicts happening via
> trace_uprobe.
>

Yeah, that makes sense.

Reviewed-by: Song Liu <songliubraving@fb.com>
