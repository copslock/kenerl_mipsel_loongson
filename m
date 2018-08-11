Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2018 08:14:11 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:41396
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHKGOIDu777 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2018 08:14:08 +0200
Received: by mail-qt0-x241.google.com with SMTP id e19-v6so12574009qtp.8;
        Fri, 10 Aug 2018 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6VmG1RyVENc8mmnW0eOrrpkUlIOoG8loqawhUUTZdMA=;
        b=vWAY5wcJS1gplO5dSmb3jnOqU5p1fqDcwnhjcbcG5+clI5BQAjufI6qqdz0rPZP4Ls
         JMu8gaak9chBq5nsK4YyrL0aDxDHyXjaMbmdA8x+IAKmGpC3veL3aiZ1PPpvBKjB1MJF
         JpzlNOOCk0sD1GjkIdQ3+n47or8v0/z++0cd4J8lQBSqNZwHB6bWKD1ZwAWPZS2kZP+1
         suSrsrNdv6/aqXJMbXHs7ytmlLRH5lQ1cSd+SeggMsTskM6CnDmG99FsYHCvM8Vm/G4p
         aMOCox6byGlThlUFYjLTQsDH/tFkGvfUIKHdQiVFSjllvTc/36NZ8GktQ3ElwD9t53gP
         s14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6VmG1RyVENc8mmnW0eOrrpkUlIOoG8loqawhUUTZdMA=;
        b=Mq5NvoraH+rh7883IMinCT/+cvJFUUb/iMvbOpUAw+XYOZm6vYVgh/Orw3xNaL0XXE
         t1kqPXpKaLMgheWitKhSq0xSUN33nN2mEi1ty6pahgBMnEVjKAhxHIO9BLd8GLF9jn9D
         bkABEH6eadUOgIfxJiDcmZUSpDyNVmaF0dGs1VvA47SOfgAGuu0eBrR+BpfjCXoci7lC
         qO6iV7CiSnMJlMd+ir7uTWq/Gcmc8Ja1dMC7MWYTwEDDG9OgB+wIT1ALSJlVtrccu8V6
         BpxVJwEBQJOCIaaZKrxsbrKg7S5DuFFP7vz6QRKZtJL8gjVdWfZHlAWoHnoxx/DF9og0
         mKKg==
X-Gm-Message-State: AOUpUlHNd82mGs18eBUlF6PioOQCk0FAVlaqe6JMhet3pLcvtF1OuEAw
        66MUkgS6wxgmCnwf+7X9hMvmyKgy1ipVMr+vszs=
X-Google-Smtp-Source: AA+uWPyUpLiZ6AipTTolAPCfrCvUaxTSZVTmtH0orJ9isZI5hHoFN7u0qwPDXS566j9dVteVJYsJ5nAEHNgAtIP5mwE=
X-Received: by 2002:ac8:1abd:: with SMTP id x58-v6mr9448098qtj.180.1533968041795;
 Fri, 10 Aug 2018 23:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 23:14:01
 -0700 (PDT)
In-Reply-To: <20180810155813.49259913@gandalf.local.home>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <20180809143827.GC22636@redhat.com>
 <20180810155813.49259913@gandalf.local.home>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 10 Aug 2018 23:14:01 -0700
Message-ID: <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, mhiramat@kernel.org,
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
X-archive-position: 65543
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

On Fri, Aug 10, 2018 at 12:58 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 9 Aug 2018 16:38:28 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
>> I need to read this (hopefully final) version carefully. I'll try to do
>> this before next Monday.
>>
>
> Monday may be the opening of the merge window (more likely Sunday). Do
> you think this is good enough for pushing it in this late in the game,
> or do you think we should wait another cycle?
>
> -- Steve

We (Facebook) have use cases in production that would benefit from this work, so
I would rather see this gets in sooner than later. After a brief
review (I will more
careful review before Monday), I think this set is not likely to break
existing uprobes
(those w/o ref_ctr). Therefore, I think it is safe to put it in this cycle.

Thanks,
Song
