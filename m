Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 21:07:51 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:32951
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993041AbeH1THr03rh2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2018 21:07:47 +0200
Received: by mail-qk0-x243.google.com with SMTP id z78-v6so1764489qka.0;
        Tue, 28 Aug 2018 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrG++dNAmHDZYW8FIp4IhppBHJeFmzrcJhyRZz1Cp3g=;
        b=pK+ZeXi4Vgx+8b+yObennPmslWs4AYWpAzf/BJFKfoKi+csFxBvDn4LbGofRLb8E4Q
         CGW9L7FTeN3K3LDQXoOmcwNWD864HOvw7+A4Fj4HJjapheoEAxdm4c8nvIen3VyF/3lY
         AZLbGFVpBwKymbradg3sUVOusSm1EKuoVXP3+dLV37tkdcEp5C1uW5yRVPqjqN88z7ws
         1a4Eoc6Gm/l6Jy+9t8ahX/Z/usnA5EgOttfGuABide6sEnkGXcW2LNmJ1OIJEHJ1FlH4
         iIhuNOvBA7YDCC9gQZVd9g3N6XCJ84fQX4DtMnAA45FK+s5JiiCiUrrs4EA9UxgV4tnU
         rmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrG++dNAmHDZYW8FIp4IhppBHJeFmzrcJhyRZz1Cp3g=;
        b=gTwuRld/2ejxm0j/VcZDYdzrEURk+g9MmakCcIxp2W216Kak0WO/XIHbU6r1wuSOJ0
         nzTnAInlTW6u64fGvk7rknZRh3Dh4hBUWTqhz1Z63hwVPy4hN2m96qPPIyjgqE2lfBjF
         QeNzyLXl3jwHFAOH6e6p8PlzMdQcNlsPOn0cbZbyr7ShZb/a3275Kx+H5NvIq7WKG844
         LHCkZpJYvH/siuT341iIdRAad8QNWjBJm+it06UPCW7vLA63ZIsEuttyOc1ZTXvIluNA
         XmvYMQpPWFwVDHwgz++BgDJgn16/PkB8GFNCvcWu3sj1uA3FHdv6rAyJeHWW00G7NMjZ
         NM9A==
X-Gm-Message-State: APzg51BE1ySbCD/s7A3k6Y3lwIcCvGCSqv/WmgvaNFF6fCyEqYa/N6Me
        f/+QhQpo81myB38quObqcuZDQzJ6q+XK+a+kjKU=
X-Google-Smtp-Source: ANB0VdYIf/fkm/DdyAek7H8loBL5Z75NbAwlmGo+EVIw3mHFKMNNYMXGv7kr0IQT9/PBixOTXml4HMsY4g/mnKDgvZg=
X-Received: by 2002:a37:dd56:: with SMTP id n83-v6mr2989136qki.5.1535483261265;
 Tue, 28 Aug 2018 12:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-2-ravi.bangoria@linux.ibm.com> <20180822123943.GD2080@linux.vnet.ibm.com>
In-Reply-To: <20180822123943.GD2080@linux.vnet.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 28 Aug 2018 12:07:30 -0700
Message-ID: <CAPhsuW55gYH2oFg5qEYLW_5hjEOVKvmQvsNPZO4=S=VGdbL6hQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] Uprobes: Support SDT markers having reference
 count (semaphore)
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
X-archive-position: 65769
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

Hi all,

What's our plan with this work? Will this be routed via Steven's tree?

Thanks,
Song

On Wed, Aug 22, 2018 at 5:39 AM Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-20 10:12:47]:
>
> > Userspace Statically Defined Tracepoints[1] are dtrace style markers
> > inside userspace applications. Applications like PostgreSQL, MySQL,
> > Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> > have these markers embedded in them. These markers are added by developer
> > at important places in the code. Each marker source expands to a single
> > nop instruction in the compiled code but there may be additional
> > overhead for computing the marker arguments which expands to couple of
> > instructions. In case the overhead is more, execution of it can be
> > omitted by runtime if() condition when no one is tracing on the marker:
> >
> >     if (reference_counter > 0) {
> >         Execute marker instructions;
> >     }
> >
> > Default value of reference counter is 0. Tracer has to increment the
> > reference counter before tracing on a marker and decrement it when
> > done with the tracing.
> >
> > Implement the reference counter logic in core uprobe. User will be
> > able to use it from trace_uprobe as well as from kernel module. New
> > trace_uprobe definition with reference counter will now be:
> >
> >     <path>:<offset>[(ref_ctr_offset)]
> >
> > where ref_ctr_offset is an optional field. For kernel module, new
> > variant of uprobe_register() has been introduced:
> >
> >     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> >
> > No new variant for uprobe_unregister() because it's assumed to have
> > only one reference counter for one uprobe.
> >
> > [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> >
> > Note: 'reference counter' is called as 'semaphore' in original Dtrace
> > (or Systemtap, bcc and even in ELF) documentation and code. But the
> > term 'semaphore' is misleading in this context. This is just a counter
> > used to hold number of tracers tracing on a marker. This is not really
> > used for any synchronization. So we are calling it a 'reference counter'
> > in kernel / perf code.
> >
>
>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > [Only trace_uprobe.c]
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > ---
>
