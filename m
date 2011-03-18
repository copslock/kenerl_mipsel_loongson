Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 10:01:10 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:1320 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491116Ab1CRJBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 10:01:06 +0100
X-TM-IMSS-Message-ID: <2e3d47930001a26f@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 2e3d47930001a26f ; Fri, 18 Mar 2011 02:00:56 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 18 Mar 2011 02:01:17 -0700
Date:   Fri, 18 Mar 2011 14:36:32 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Support for Netlogic XLR/XLS processors
Message-ID: <20110318090631.GA8628@jayachandranc.netlogicmicro.com>
References: <20110312182714.GC2217@jayachandranc.netlogicmicro.com>
 <AANLkTime__o2bGyUn1-CsY4O=VhniN14u_fHYYxYz=VQ@mail.gmail.com>
 <20110314142927.GA18480@jayachandranc.netlogicmicro.com>
 <AANLkTi=5-zOAXUr95S-KS3kT4Nm2F8H=6Y9AKGg09iv=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTi=5-zOAXUr95S-KS3kT4Nm2F8H=6Y9AKGg09iv=@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 18 Mar 2011 09:01:17.0396 (UTC) FILETIME=[0AA31940:01CBE54B]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Fri, Mar 18, 2011 at 11:26:05AM +0800, wu zhangjin wrote:
> On Mon, Mar 14, 2011 at 10:29 PM, Jayachandran C.
> <jayachandranc@netlogicmicro.com> wrote:
> > On Mon, Mar 14, 2011 at 08:19:22PM +0800, wilbur.chan wrote:
> >> Will kexec be supported on XLS/XLR/XLP ?
> >
> > The patches I have does not support it. I haven't really looked at what
> > is needed in XLR platform code to support kexec, so I'm not sure what it
> > takes to support it for XLR either. Any pointers?
> 
> You can get some information here:
> 
> http://dev.lemote.com/code/linux-loongson-community/wiki/kexec-loongson
> 
> And here:
> 
> http://patchwork.linux-mips.org/project/linux-mips/list/?q=kexec

Will look at this.

> BTW: what about the cpu hotplug support for XL{R, S, P} ?

Not right now. My intial goal for Linux/MIPS is hardware support, i.e.
processor support and then drivers. I can start thinking of feature support
once we have reasonable hardware support in the kernel...
-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
