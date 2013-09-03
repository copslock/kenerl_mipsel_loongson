Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 03:06:13 +0200 (CEST)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:59215 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827352Ab3ICBGI0x8cZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Sep 2013 03:06:08 +0200
Received: by mail-lb0-f181.google.com with SMTP id u14so4464113lbd.12
        for <multiple recipients>; Mon, 02 Sep 2013 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gvKrqdIE91oXJ9l0g7HSGAVXRVNgMyFSQwB7ydQ6vbk=;
        b=zfcH6++8U0tYGl+TZ67ThIwSVQuqQDuqnR4tKDxA61sXNHu8fQj5xdvi5RCkGDFtF8
         ThyASnAXrgxzB64s1n//Y/B5JCh7alucVnB8cTxv/1xDO9/rgd4WtBQMVGe2Fb1lkZeD
         HeFiDzoAGsya10yPMigz3ehf0/r3kiilvvM46sjtMw2B5KD3M6uzOkUQUf7a7SSxK76s
         fH3pIGDkbDPNxAmlGfi/DMn1d/eOl1mVYSI0VK11WcXoPhuVOFaSGRRzv4YP7VBGOcJZ
         6vRGazhL4Cej4DFdL7BhB1ewBMrOBSuVFBKQki22PGpIOf+pnsOm2Qw/H1vLfe68CrYN
         KPmg==
MIME-Version: 1.0
X-Received: by 10.112.42.68 with SMTP id m4mr23418742lbl.4.1378170362690; Mon,
 02 Sep 2013 18:06:02 -0700 (PDT)
Received: by 10.152.124.179 with HTTP; Mon, 2 Sep 2013 18:06:02 -0700 (PDT)
In-Reply-To: <CAF1ivSaRL91Xi0zianDp5C6XrwKp5N88dBEzLmtiDPqbdURFAw@mail.gmail.com>
References: <CAF1ivSaRL91Xi0zianDp5C6XrwKp5N88dBEzLmtiDPqbdURFAw@mail.gmail.com>
Date:   Tue, 3 Sep 2013 09:06:02 +0800
Message-ID: <CAF1ivSY5=if051Wx4dEYHYYo+Gij637HWG84viXDF_L_A8B1-w@mail.gmail.com>
Subject: Re: Question: how could stack pointer overflow to high address?
From:   Lin Ming <minggr@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minggr@gmail.com
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

On Thu, Aug 29, 2013 at 12:59 PM, Lin Ming <minggr@gmail.com> wrote:
> Hi list,
>
> An application segmentation faults, as below.
> The stack pointer($29) at: 0x7ffcbd60
> The stack memory is:
> 7f86b000-7f880000 rwxp 00000000 00:00 0          [stack]
>
> I can understand stack overflow to low address, for example, due to
> very deep recursive call.
>
> But in this case, 0x7ffcbd60 > 0x7f880000
> The stack overflow to high address. How could it be possible?

Hi Ralf,

Any help on this question?

Thanks,
Lin Ming

>
> =====
>
> ssk/340: potentially unexpected fatal signal 11.
>
> Cpu 1
> $ 0   : 00000000 10008d00 00000001 00000001
> $ 4   : 00000001 ffffffff 00000000 7ffcbd84
> $ 8   : 00000007 00000002 00000020 fffffffc
> $12   : 00000807 00000800 00000400 00000008
> $16   : 2ace3466 7ffcbf10 0000000a 0000000a
> $20   : 004040b0 7ffcbda0 7ffcc7c8 7ffcbd84
> $24   : 00000000 2b070200
> $28   : 2b0b2560 7ffcbd60 7ffcbe20 2b069438
> Hi    : 00000000
> Lo    : 00000000
> epc   : 2b07023c 0x2b07023c
>     Tainted: P
> ra    : 2b069438 0x2b069438
> Status: 00008d13    USER EXL IE
> Cause : 80000008
> BadVA : 00000001
> PrId  : 0002a080 (Broadcom4350)
>
> Thanks,
> Lin Ming
