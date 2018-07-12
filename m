Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 21:53:28 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:38605
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994243AbeGLTxSbg2jf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2018 21:53:18 +0200
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so58048117oie.5;
        Thu, 12 Jul 2018 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rFH8P876Vl2E94mklJe34lGBbiVYKqYfk0DpwQ0FUK0=;
        b=JKrLjoXI0tbP+SQX/D9NcBYGdkyqVOxyIomy9yvtcSbVyeNbr+bAG9RLoATno8rkfS
         YV/9+lo6wG9AMjI296zN/uy9z8s3GL/jfczF6YclDcpArgOQ3tqVHs8bHygzVhq+VQDy
         bj8yaDOwwIYVwGhpKiIywyTEwfznCC+vtfeUz96F9Y/PeSrt2jtVu6UZF12j9VO+Nync
         ShYgDa/vORnhaVEHtHED2bBISwpfb6ReJBYtD6Q0zW/8vlv2WixLb0/o9v4KgKs44FoD
         yXkWbAyjJJIIyvy+iwI19qBNpx4P5MpYdNJ4R/Cok7q1YhfUrt7Pr82fbsyZKvz2Whbe
         Kj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rFH8P876Vl2E94mklJe34lGBbiVYKqYfk0DpwQ0FUK0=;
        b=curtIOsED4n7P7Qf/8R8a3H0ax5qbMZBahLhH1gN4TGCmumFptjf05dCky4DR6lGp4
         udU8P2LZ6mgZpqPmS4cM4gxqvaeVrHSHtQ2Bsk1Mk45nFBMEPX6F/JwrzIo6tCYfF3wC
         yZpWGnGPkJBsD++quRf+nFJgeMOBQqWWh8PwRjfDc35lJTqKJa5N+yDKEE8Wr9MnRab7
         KF1ClVUVUmF68Ej+IAdz7RX/F8nwO0RiHZmiJOdyMvDSFTVOmdpXZS6uN0CrMOhpnUUg
         wKUSVlRaB5fRGBKR7qmFYc9qwzhMC1cQg8jwtpuGzJ6RNAxkGKbVGCIJQcfO6SDhOZs1
         lLIw==
X-Gm-Message-State: AOUpUlG8n9q7jXoQzwSlMnd99NWkS/2ky8ywUESdCTOPsXXMdUsQOai0
        ivCmHu50HiRnl4xlk4zxbAtfmENGikMkItU4bcA=
X-Google-Smtp-Source: AAOMgpcf0DTWbJP4wZXMlpjHY0oG8Pp/hBgvCt3IpuoFgZDSbMeHt8TebBd/HA1g6p4+OTuy4nj6ieuBiLHnEHlZrRM=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr4047569oia.229.1531425192244;
 Thu, 12 Jul 2018 12:53:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5e0c:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 12:53:11
 -0700 (PDT)
In-Reply-To: <20180712145849.GB15265@redhat.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com> <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com> <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com> <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com> <20180712145849.GB15265@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 12 Jul 2018 12:53:11 -0700
Message-ID: <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64822
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

I guess I got to the party late. I found this thread after I started developing
the same feature...

On Thu, Jul 12, 2018 at 7:58 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/11, Ravi Bangoria wrote:
>>
>> > However, I still think it would be better to avoid uprobe exporting and modifying
>> > set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>> > I'll re-check...
>>
>> Good that you bring this up. Actually, we can implement same logic
>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>> need to pass arch_uprobe object to uprobe_write_opcode().
>
> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
> arg to uprobe_write_opcode(). OK, this is fine.
>
>
>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>> or a consumer property, before posting v6:
>>
>> If we make it a consumer property, the design becomes flexible for
>> user. User will have an option to either depend on kernel to handle
>> reference counter or he can create normal uprobe and manipulate
>> reference counter on his own. This will not require any changes to
>> existing tools. With this approach we need to increment / decrement
>> reference counter for each consumer. But, because of the fact that our
>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>> to keep track of which reference counter have been updated in which
>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>> {uprobe, consumer, mm}.

Is it possible to maintain balanced refcount by modifying callers of
install_breakpoint() and remove_breakpoint()? I am actually working
toward this direction. And I found some imbalance between
     register_for_each_vma(uprobe, uc)
and
     register_for_each_vma(uprobe, NULL)

From reading the thread, I think there are other sources of imbalance.
But I think it is still possible to fix it? Please let me know if this is not
realistic...


About race conditions, I think both install_breakpoint() and remove_breakpoint()
are called with

   down_write(&mm->mmap_sem);


As long as we do the same when modifying the reference counter,
it should be fine, right?

Wait... sometimes we only down_read(). Is this by design?

Thanks,
Song
