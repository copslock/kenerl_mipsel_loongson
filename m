Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 13:10:39 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:38395
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990588AbeC3LKcuyGwc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 13:10:32 +0200
Received: by mail-lf0-x241.google.com with SMTP id u3-v6so12148277lff.5;
        Fri, 30 Mar 2018 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DMv1OHAJmnEuxAnHztpCW3t3RuKwa0Ou1+EXusdSHqQ=;
        b=c6OeY3LG3/SmGB2/VJasz3Jj1Hl1qs0qDK02ShrL9GqU7fI0AEKmpelcTMKCO85SMQ
         gtPSuao6g/t6hVKuBSTvL6NzEa5UKjxGQYwtxpI8N621RaKLGW1gjaUBl4VmxhR1VaCK
         5u81T57afjTslrmEOAyZfWWa/xMhaWkcfKLeJ7adeGpJplpq6REV/Oqg05kn+j511X6k
         ugbrSRQqCvRyHe9AvD/1SqZamn/VJUqI61Z4dJJ+ZTiiR2nChbu7ug4phF/lPNYmFQFY
         tfjd1OqikW7SJCpbz8CCSxvJvKRs0bq5yLp0i2NYZYtoPUz0R+CYfFsnaF8fpOWUD/ws
         tkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DMv1OHAJmnEuxAnHztpCW3t3RuKwa0Ou1+EXusdSHqQ=;
        b=PUXhr76M7uSZsPqTNlEijkRaIGXGP/SYzEkM8DtpjeqlJ7qz8Li11e0C6KqYH33bUJ
         cfrZTEM6WNeX89EsqOOuiPLJARbdmNpNn0BhuplnxBoBMxr6NX1s7aAudwvQhpYdPGqk
         bWQGsITmD1roarTQ49NrA4DMKZqhGkIijMK2L1PT6ca0wIDqZrqK9YAycdD1sH21ssil
         2dKo5+sSX9uygei01E1uOFwQhZZ1sDzZ+sYOgrqr+SsIVad7oeqz+FwJ0BbEpVj3iNgz
         VGjOVuAuLCdDOFNTnwo3jwbHstcZYGhZOlcGqo8I+sG1HB4nfi9T2TvIryZ0Mnb/rgf0
         Y3wg==
X-Gm-Message-State: AElRT7G7a/JGMtCgEqa6dmvHzdDjudN+y5R+BJZT0u51rAoo5wxBru3t
        09Os6LeoBQMco126Fby5AjM=
X-Google-Smtp-Source: AIpwx4+dzpT91FvaFhoZ3xkzYjDGaqjJ1sxmduVWasDti8HbRZkC+lXIRBvsYzSdr/NnlAoBmc9Y8g==
X-Received: by 10.46.135.139 with SMTP id n11mr8188891lji.65.1522408224891;
        Fri, 30 Mar 2018 04:10:24 -0700 (PDT)
Received: from [10.0.36.208] ([31.44.93.2])
        by smtp.gmail.com with ESMTPSA id q28-v6sm1622452lfb.84.2018.03.30.04.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 04:10:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180330095735.GA15641@amd>
Date:   Fri, 30 Mar 2018 14:10:21 +0300
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk,
        arnd@arndb.de, gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Michal Hocko <mhocko@suse.com>, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4F529F89-6595-4DE9-87C2-C3D971C76658@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180330075508.GA21798@amd> <95EECC28-7349-4FB4-88BF-26E4CF087A0B@gmail.com>
 <20180330095735.GA15641@amd>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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


> On 30 Mar 2018, at 12:57, Pavel Machek <pavel@ucw.cz> wrote:
> 
> On Fri 2018-03-30 12:07:58, Ilya Smith wrote:
>> Hi
>> 
>>> On 30 Mar 2018, at 10:55, Pavel Machek <pavel@ucw.cz> wrote:
>>> 
>>> Hi!
>>> 
>>>> Current implementation doesn't randomize address returned by mmap.
>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>> creation. After that mmap build very predictable layout of address
>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>> randomization of address on any mmap call.
>>> 
>>> How will this interact with people debugging their application, and
>>> getting different behaviours based on memory layout?
>>> 
>>> strace, strace again, get different results?
>>> 
>> 
>> Honestly I’m confused about your question. If the only one way for debugging 
>> application is to use predictable mmap behaviour, then something went wrong in 
>> this live and we should stop using computers at all.
> 
> I'm not saying "only way". I'm saying one way, and you are breaking
> that. There's advanced stuff like debuggers going "back in time".
> 

Correct me if I wrong, when you run gdb for instance and try to debug some 
application, gdb will disable randomization. This behaviour works with gdb 
command: set disable-randomization on. As I know, gdb remove flag PF_RANDOMIZE 
from current personality thats how it disables ASLR for debugging process. 
According to my patch, flag PF_RANDOMIZE is checked before calling 
unmapped_area_random. So I don’t breaking debugging. If you talking about the 
case, when your application crashes under customer environment and you want to
debug it; in this case layout of memory is what you don’t control at all and 
you have to understand what is where. So for debugging memory process layout is
not what you should care of.

Thanks,
Ilya
