Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 02:18:45 +0200 (CEST)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43379 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010794AbaJHASoEU78l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 02:18:44 +0200
Received: by mail-oi0-f49.google.com with SMTP id a3so3091837oib.36
        for <multiple recipients>; Tue, 07 Oct 2014 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p//SS1sSJLegOM3uA3MJHF3qWzCQ+QoHx+/3sP1RZj4=;
        b=DqctSjdw+iciKUglgYH8D8dO9ZvBgQYa6grEcL9FUlKFoftaYIK4VQM/JB/bwwPmum
         sUbO9uwajCrV5Kk89HkQIUPzzykItusUG3Ovn7CjCFZc7ZaGC0alvwZEGcxlViekStOc
         beA4n13SehCSDncmGqzcLEiCzSESKq1csGKXDjD4dNtd/ozwFIGJOaWuGLQDCL/ufepT
         FxeGZWEhHX5HREIjXpNoYF2FHv6YBqnIzxOiAZbEiOTHlJ/qYtxt5Fyjo4IbHOyZsg7T
         MCx75z0qVDMoPPBilS7wAY6g0RU4kNekF+ltDsLVBelBBGPRz+irybeAdlDse9HM2qiT
         Z50g==
X-Received: by 10.182.104.104 with SMTP id gd8mr7968830obb.17.1412727517345;
        Tue, 07 Oct 2014 17:18:37 -0700 (PDT)
Received: from as ([159.118.19.211])
        by mx.google.com with ESMTPSA id e7sm12976901oen.17.2014.10.07.17.18.36
        for <multiple recipients>
        (version=SSLv3 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Oct 2014 17:18:36 -0700 (PDT)
Date:   Tue, 7 Oct 2014 19:18:33 -0500
From:   Chuck Ebbert <cebbert.lkml@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Rich Felker <dalias@libc.org>,
        David Daney <ddaney.cavm@gmail.com>,
        <libc-alpha@sourceware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Message-ID: <20141007191833.4d625472@as>
In-Reply-To: <54347E47.1080809@caviumnetworks.com>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
        <20141006205459.GZ23797@brightrain.aerifal.cx>
        <5433071B.4050606@caviumnetworks.com>
        <20141007232019.GA30470@linux-mips.org>
        <54347E47.1080809@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <cebbert.lkml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cebbert.lkml@gmail.com
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

On Tue, 7 Oct 2014 16:59:03 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> On 10/07/2014 04:20 PM, Ralf Baechle wrote:
> > On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
> >
> >>> As an alternative, if the space of possible instruction with a delay
> >>> slot is sufficiently small, all such instructions could be mapped as
> >>> immutable code in a shared mapping, each at a fixed offset in the
> >>> mapping. I suspect this would be borderline-impractical (multiple
> >>> megabytes?), but it is the cleanest solution otherwise.
> >>>
> >>
> >> Yes, there are 2^32 possible instructions.  Each one is 4 bytes, plus you
> >> need a way to exit after the instruction has executed, which would require
> >> another instruction.  So you would need 32GB of memory to hold all those
> >> instructions, larger than the 32-bit virtual address space.
> >
> > Plus errata support for some older CPUs requires no other instructions
> > that might cause an exception to be present in the same cache line inflating
> > the size to 32 bytes per instruction.
> >
> > I've contemplated a full emulation - but that would require an emulator that
> > is capable of most of the instruction set.  With all the random ASEs around
> > that would be hard to implement while the FPU emulator trampoline as currently
> > used has the advantage of automatically supporting ASEs, known and unknown.
> > So it's a huge bonus for maintenance.
> >
> 
> Unfortunatly it breaks when our friends at Imgtec introduce their PC 
> relative instructions in mipsr6, so an emulator may be unavoidable.
> 

The x86 kprobes code deals with executing relocated insns with
PC-relative offsets by adjusting the offset in a relocated instruction
before executing it.

See arch/x86/kernel/kprobes/core.c::__copy_instruction()
