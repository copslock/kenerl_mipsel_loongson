Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 23:35:45 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:32996
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994604AbeHUVffge82B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 23:35:35 +0200
Received: by mail-qt0-x243.google.com with SMTP id r37-v6so14845259qtc.0;
        Tue, 21 Aug 2018 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WqxfbKjEBaLL6fAjAohQg3BTd5TiG1XOL+M9/BzqUig=;
        b=c0mDhMcewZ7VGVAOsalJz5rHSZDqxrOu+EozcNJoeAhLMPbadczkXk3f1GUAC3Wvr7
         gNAummTWMHhb4iODIfYu9F8mzbq41gJ6FqJnakQe25IUa0UgueW2LuWDBO2XBmV7Dyuv
         c2VTpW67iGW3IDfkJCljQY1kCOhbV5fZmbMMRwjfLCjg8c73tf2GxzZYzpykKpSFPykd
         8eeWV3t2hT/jeI0Zqswwa6uTSJXPvL1hg/UHJs8ksbLKuALk7B0zr6wu63d27D5VTuBj
         IgfIS45Nho4+aKoEcj/yge5myYhl8LRb9ObNDBrsJC5Gybr+DK2hU/s6auUZN8HNbBM3
         p9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WqxfbKjEBaLL6fAjAohQg3BTd5TiG1XOL+M9/BzqUig=;
        b=hx3FgXC1wDEC/z36ODBxD1edIWlvdFgATegZ+RJ2kDUM/0J+NfBx4UVr6ZdrHeOV9U
         5EwybbEWXSTNVDXFwp2p+g2vkNLzpDL9tjfZd9y8+CtukoylGJv0QCrYxmhUPOa24fuT
         pA8oj75MX1XGNQOUG/9lZZu7WNHQkt7Nax9N97Nhd+iovFzJdoYgxOAcyU3iSzL80rP+
         U+Xobo0xKFVxfh2JO/r5RMxZ4E4XvZRgEoy0v7rSu/u+nD/2NqS8sMcyd79sqhddSyWT
         XtK2MO4IO1rY5vuZyGLkbMg54IbqQxMIWtySCvNg0VoGAxEGMEFLY5iZfPqNGJJUYfQa
         FA3g==
X-Gm-Message-State: AOUpUlFjd1YUCyeARhp2Lu+KoA5fvZ9vLwuG4tWaRI2b37dT+FMvisgh
        VyApqqcEhQuEhlxBjHf2WJrkBhQzWfTylqBsI/E=
X-Google-Smtp-Source: AA+uWPx3eGkkorwWKlitGv3fsYWpdik4xBSnuQUChlDZZjGaxBHgUAotryU2QvMkvw2iRoDbnV3ZJkKZfwN0xfCRx00=
X-Received: by 2002:ac8:84a:: with SMTP id x10-v6mr50530692qth.90.1534887329837;
 Tue, 21 Aug 2018 14:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 14:35:29
 -0700 (PDT)
In-Reply-To: <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-3-ravi.bangoria@linux.ibm.com> <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 21 Aug 2018 14:35:29 -0700
Message-ID: <CAPhsuW5DBOuYjYsUyWRZimeRKJhmA=RNM-rpcRhsfXwWfVG6qw@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
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
X-archive-position: 65715
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

On Sun, Aug 19, 2018 at 10:54 PM, Song Liu <liu.song.a23@gmail.com> wrote:
> On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>> We assume to have only one reference counter for one uprobe.
>> Don't allow user to register multiple uprobes having same
>> inode+offset but different reference counter.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
> Reviewed-by: Song Liu <songliubraving@fb.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

>
>> ---
>>  kernel/events/uprobes.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 35065febcb6c..ecee371a59c7 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>>         return u;
>>  }
>>
>> +static void
>> +ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
>> +{
>> +       pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
>> +               "ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
>> +               uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
>> +               (unsigned long long) cur_uprobe->ref_ctr_offset,
>> +               (unsigned long long) uprobe->ref_ctr_offset);
>> +}
>> +
>>  static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>>                                    loff_t ref_ctr_offset)
>>  {
>> @@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>>         cur_uprobe = insert_uprobe(uprobe);
>>         /* a uprobe exists for this inode:offset combination */
>>         if (cur_uprobe) {
>> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
>> +                       ref_ctr_mismatch_warn(cur_uprobe, uprobe);
>> +                       put_uprobe(cur_uprobe);
>> +                       kfree(uprobe);
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>>                 kfree(uprobe);
>>                 uprobe = cur_uprobe;
>>         }
>> @@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>>         uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>>         if (!uprobe)
>>                 return -ENOMEM;
>> +       if (IS_ERR(uprobe))
>> +               return PTR_ERR(uprobe);
>> +
>>         /*
>>          * We can race with uprobe_unregister()->delete_uprobe().
>>          * Check uprobe_is_active() and retry if it is false.
>> --
>> 2.14.4
>>
