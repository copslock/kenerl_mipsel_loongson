Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 08:48:35 +0200 (CEST)
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36753 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025659AbcDGGsc4ULeC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 08:48:32 +0200
Received: by mail-wm0-f42.google.com with SMTP id v188so45337921wme.1;
        Wed, 06 Apr 2016 23:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gpfzjuT1WX+SDciOG1E7KMqIuMzR6SOhFrftWehbabM=;
        b=okPRwwv5J9aAF1TgTmd8QqUNSsvo1fSOudVLWRWSscKwiCJg84ZU56a7p7TWFS/f/O
         xqkbCuh5vslNdMyJCZz/LThSLltT+TdvweWvdzlFkMiNzx80PpVylKLQhW45ire4Ozhl
         BiDXZyKTG13tboL6k3RHQ3cGJ4BypgjUy28xCW6/58XFuntfYJ4bygwtNJfrZ8uSG7yu
         xvCTTizZ5tgmCkYUtqaHuODCVN/bEDGloggoYl4EHLoDgA7Sk4BJCVCg3/SUjwu1ltN9
         GGsNcxYPDy30Gokf+Ola4wxTTYXxucCL3T5XljRLK53EI1r03JGD5Mx/KrZeMg3afd8q
         xG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gpfzjuT1WX+SDciOG1E7KMqIuMzR6SOhFrftWehbabM=;
        b=cJc7pfq38tpi+ZDNp2pdGsEQ+5N8+omkDOocvYA+tKshpZq+flerYAv4+Bb8kFFnOG
         Sc/h451YZDsYakk1Ys8wHHVDILSmagXi68YyhIDCrZIzg0bknVi4Fln9gZyMu5lmCB73
         TgCn3VyjQ2+mTjW0Diuu+Yw2y+2N9ec61T9Cg5uZTtvxRAhfwp/PD/KDFquhHKCYqz5h
         FFMrFmv6PttUaeuSNcTYwSXwERJda4a3zyv68prE8gpo1m1u8XdCPTEzvTAhW6bnPRM0
         7WlyDGPLC0equfVMgSH0B/wqhSbyAemihza2CnOQFvyO5Cs2CymitZH5wgzdWI8quNXD
         SnJQ==
X-Gm-Message-State: AD7BkJL6q0umqILldOwhcAQtMXrHmaImknNSr6U0YMtmllTJWC//7+qcN29M7RnQzhr6bUAD1j4U2bAzeRYUZA==
X-Received: by 10.28.20.198 with SMTP id 189mr28403175wmu.103.1460011707749;
 Wed, 06 Apr 2016 23:48:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.129.14 with HTTP; Wed, 6 Apr 2016 23:47:47 -0700 (PDT)
In-Reply-To: <20160407064654.GB20863@NP-P-BURTON>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <20160407000658.GA11065@NP-P-BURTON> <CAOLZvyErcw4kyLsLPoqCCBcxoK3L4OPykQLFaWRs6bLrPXK5zg@mail.gmail.com>
 <20160407064654.GB20863@NP-P-BURTON>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 7 Apr 2016 08:47:47 +0200
Message-ID: <CAOLZvyGH4j-KV=bsAT-DsQ1TYFcNrSY=cm02x_KFjusUh3=VvA@mail.gmail.com>
Subject: Re: 4.1: XPA breaks Alchemy
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, Apr 7, 2016 at 8:46 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Thu, Apr 07, 2016 at 08:40:17AM +0200, Manuel Lauss wrote:
>> On Thu, Apr 7, 2016 at 2:06 AM, Paul Burton <paul.burton@imgtec.com> wrote:
>> > git://git.linux-mips.org/pub/scm/paul/linux.git -b v4.6-tlb
>>
>>
>> Hi Paul,
>>
>> This branch does indeed boot again, and PCI/PCMCIA work as well.
>>
>> Thank you for looking at this!
>>       Manuel
>
> Thanks for that Manuel :)
>
> Am I OK to add your Tested-by to the current last patch in that branch
> ("MIPS: Fix MIPS32 36b physical addressing (alchemy, netlogic)")?

Of course, any time.

> Paul
