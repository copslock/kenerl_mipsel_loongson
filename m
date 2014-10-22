Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 00:18:37 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:52008 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012176AbaJVWSfzdK4z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 00:18:35 +0200
Received: by mail-ig0-f179.google.com with SMTP id h18so352666igc.6
        for <multiple recipients>; Wed, 22 Oct 2014 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q6zfRP1pyD1eE0Z0pdmUvSu7lv56qZF+hcFuGVr12fg=;
        b=j3/mF685l3aBexbuf+trnpuQbNK0j2l/HHclmNSgxUDaIHQ42vvBxGhAtgzQQXYmJJ
         xNyBZ0bbnmmkGKUOaH5swQkXUt9itATRbWpo+aQpiBafAHDDiaKNqH13567FG/KrctGD
         vqhyZw6vNjyJPNcBlGD+7uUhvMF7qbpgHJt/lVtjwxK3qd6f3Xpzsa0x6qY1iIRAp440
         E0bvEPprWP4tIchT9Ye2hAtrDVfl2IB3d+8c2tsduwPnndA3FNW7hYqP+DyagDelFrw8
         NACoWlJBICq+5RukER6Zsyt4gqoPatuPFF5PBtWjLVEz14TWTEAjSNfRlQjNTFmqFGW6
         9Bdg==
X-Received: by 10.50.143.65 with SMTP id sc1mr37918129igb.27.1414016309390;
        Wed, 22 Oct 2014 15:18:29 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v2sm269230igs.11.2014.10.22.15.18.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 15:18:28 -0700 (PDT)
Message-ID: <54482D33.9020101@gmail.com>
Date:   Wed, 22 Oct 2014 15:18:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org> <5447EFB5.4090009@gmail.com> <20141022190515.GC12502@linux-mips.org> <alpine.LFD.2.11.1410222010280.21390@eddie.linux-mips.org> <20141022204209.GE12502@linux-mips.org> <20141022215313.GC12296@jhogan-linux.le.imgtec.org>
In-Reply-To: <20141022215313.GC12296@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/22/2014 02:53 PM, James Hogan wrote:
> Hi,
>
> On Wed, Oct 22, 2014 at 10:42:09PM +0200, Ralf Baechle wrote:
>> On Wed, Oct 22, 2014 at 08:19:07PM +0100, Maciej W. Rozycki wrote:
>>>   Wouldn't it make sense to make a unified kernel virtually mapped?  That
>>> would avoid the issue with RAM being present at different locations across
>>> systems and also if big pages were used, that I believe are available
>>> almost universally across the MIPS family, any performance hit would be
>>> minimal.  There would be hardly any increase in the binary image size too.
>>> Run-time mappings such as `kmalloc' or `ioremap' could continue using
>>> unmapped segments.
>
>> Otoh the mapped kernel certainly would have the lowest size overhead.
>> I have faint memories of restrictions for TLB instructions or was it
>> TLB exception handlers into mapped space, would have to do some rtfming
>> on that topic.
>
> Yeh, KVM puts all tlb handling in arch/mips/kvm/tlb.c, which is built
> statically rather than being included in the kvm kernel module, exactly
> for this reason, so that it resides in unmapped memory space.
>
> You'd have to guarantee not to get a TLB exception while the TLB
> registers contain important values, since they'll get clobbered by the
> taking of the exception itself (e.g. EntryHi gets set to failing
> address, EntryLo* undefined), or the TLB entry pointed to by CP0_Index
> may be replaced.
>
> There's always CP0_Wired - its use in the kernel is a bit of a mess atm
> IIRC.
>

The current kernel.org kernel respects CP0_Wired.  We use a single TLB 
entry (index 0) to map the entire kernel, and set CP0_Wired accordingly. 
  Everything works.

EBase still points to an unmapped address, so exception handlers still 
work as before, except they may have to use more code to directly call 
into the kernel due to the 256MB jump range thing.  The general 
exception handler looks up the addresses in a table to that is not 
effected, only if you have a dedicated interrupt vector, do you have to 
use an indirect jump to reach the kernel.

David Daney
