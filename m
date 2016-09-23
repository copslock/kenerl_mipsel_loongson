Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 09:10:55 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33467 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991894AbcIWHKsHE9sz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 09:10:48 +0200
Received: by mail-wm0-f65.google.com with SMTP id w84so1201536wmg.0
        for <linux-mips@linux-mips.org>; Fri, 23 Sep 2016 00:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=T9meSfK6AlhxKENPuqgB4OAWZD4iX9AaI/RgT5TQw2U=;
        b=R4gxHH6lebdiQZdCU5qR8slO+kBYIQ7YXjW8I4jctY7iXfLqbuygY+lmRKpZ0Y99tq
         9y/MTyWeGIKyoEVn15dUqAdKcTLqdNsushllDxNIseZ4PYGp2N5j4oeCegN0853C3Frx
         hLFjf6BaN8AVWyMCa3JQwLQ+GK5eUddr47t6jNZrUb9md/qphf9zRuMTqJrrfrFYA9cg
         q4plArNRQah5fSUCP+907vaLWhHNvgY/1miYyoy4wUQXzkjApgn8Xr/DNKpVOAPFWQdG
         SmmH+E/liIm7yb7O805e1LzKJopiKq7Q+U4uq4IEkeXE4Q724AIQ2HeveWTv3MW3Pjte
         VtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=T9meSfK6AlhxKENPuqgB4OAWZD4iX9AaI/RgT5TQw2U=;
        b=BsV+Ivue4PwMTf7t62Q4p6a8Q84TuAfqw6FwScHpr0nBeAMyoobRIrX+m0kLJM3shi
         OPn9e5z992+AwNHk2jXWT1G3eMrQ8gPFQUl+gtE/AqsptaOE2sOvRTuyB19GPcIjFTJK
         AtZiYh9JN6UpQxpBx/5PqdEXd2yU0N4M5GSLHh0yRI1JQQfvj3SIXwEFQ/brHhZqIJiV
         T4bYg+ttQRzP3JmUGv4gxrmzxlEUbRgDVhSDNSXecGTEi97WTelP8xoF//eBeSBvssip
         UpoHFZSgI6ZyIMFmGFS34WzL5f+Ab6QUfl+/xACQpCcLm6Fbe4846DSMzSOve3cNwdSd
         klOw==
X-Gm-Message-State: AA6/9RkWV2BFBfCLYe0pLwu6FANtuDAyDmmDMlmINaXEpeuASp3sIyeoC3OgOAJtgZWEXg==
X-Received: by 10.28.185.71 with SMTP id j68mr1169781wmf.116.1474614642508;
        Fri, 23 Sep 2016 00:10:42 -0700 (PDT)
Received: from gollum (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id gg10sm5745770wjd.4.2016.09.23.00.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 00:10:41 -0700 (PDT)
In-Reply-To: <57E45ADD.6000202@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <0d915756776de050b8a92b5bb5d4e7ffbe784d66.1472747205.git-series.james.hogan@imgtec.com> <20160921132656.GF14137@linux-mips.org> <57E2CE5B.8020406@imgtec.com> <20160922211527.GB7352@jhogan-linux.le.imgtec.org> <57E44F59.5050600@imgtec.com> <7C466D41-C786-48E0-9BFB-1024D6F9AFFC@imgtec.com> <57E45ADD.6000202@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 7/9] MIPS: uprobes: Flush icache via kernel address
From:   James Hogan <james.hogan@imgtec.com>
Date:   Fri, 23 Sep 2016 08:10:42 +0100
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <ECCA6C77-B94C-44DC-B397-B6016607F8B8@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 22 September 2016 23:27:41 BST, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
>On 09/22/2016 03:13 PM, James Hogan wrote:
>> well it'll do a protected dcache flush (i.e. using CACHEE with EVA).
>Would kmap/kunmap or variants (fixed to work with aliasing dcache) be
>able to take care of colouring / further flushing?
>
>We should flush kernel D-cache and user I-cache in any cache aliasing 
>system. I was wrong - a fixed HIGHMEM doesn't do any difference 
>actually, because page may be located in directly addressed memory (all
>
>HIGHMEM stuff is irrelevant in this case, kmap returns a lowmem
>address).

Maybe there'd need to be other flush calls too that do the right thing for aliasing.

>
>>
>> In any case, simply changing to the user_ one is a no-op compared to
>leaving as is where patch 9 would probably break it on EVA by making it
>operate only on kernel addresses.
>
>EVA or not has no difference here - kernel address can still be a 
>different color to user address.

i'm ignoring aliasing here. If the code doesn't already handle it then this patchset doesn't care. The goal is not to fix aliasing but to prevent any new breakage due to change in semantics in patch 9 to accommodate eva.

EVA does make a difference if left as is, as flush_icache_range will operate on kernel addresses only after patch 9, so the cache op could literally not happen on the right address (irrespective of aliasing, and not a problem without eva).

it also means the ops won't be protected, so failed page fault would i guess cause kernel oops instead of being ignored (maybe impossible to hit in this case, and definitely the exceptional rather than common case) 

>
>And keeping kernel I-cache flush does break it really, not EVA.

Right, but mainly because on eva user/kernel icache flushes will start to actually differ in what they do after patch 9 .

--
James Hogan
