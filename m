Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 18:30:44 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:54165 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827444Ab3DRQanAE3m1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 18:30:43 +0200
Received: by mail-lb0-f173.google.com with SMTP id w20so2896629lbh.18
        for <multiple recipients>; Thu, 18 Apr 2013 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SapgNZX3amjHs0GSt8tL52cGPDSl/tVo74OQ1WL0mkU=;
        b=KvbDmpmadYAfeBVht37WUzGWWRoL/rphGGhSciP5Ec/NU0LxLLeEkOF/wjsCofLiYw
         6p2p0Zy2Iwqi0Us7wfLSf8ljyn5s23huoHCcFFjMS+gysfHDSmOyWjfY4besaOxU1Xph
         b7kyRwcxGMKGOHxT8zmWijSXheshdDJPts7yUx5Ga84N/ROBn+FN/a/tM2e3d5REE9Ms
         wfXDriJiz3XRNSUPRgvVySrr85L+2LpnN9sGxOffpbTN4m3BJQDSPcNZrVkvOj5uYRzf
         2D41yc6C/1xyj7cm93IEKNWvJM0e/kcNzS87jHcsXHMJCq2ZGqtsLT8ETF1/6eigPQzg
         7TbQ==
MIME-Version: 1.0
X-Received: by 10.112.4.233 with SMTP id n9mr6267353lbn.63.1366302637350; Thu,
 18 Apr 2013 09:30:37 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 18 Apr 2013 09:30:37 -0700 (PDT)
In-Reply-To: <20130418124455.GA16655@linux-mips.org>
References: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
        <20130418124455.GA16655@linux-mips.org>
Date:   Thu, 18 Apr 2013 12:30:37 -0400
Message-ID: <CAF1ivSZ7SxC7UF-u93TH23b21UN=8KqWOKoBRYepuk2JJV3R6g@mail.gmail.com>
Subject: Re: hard lockup problem
From:   Lin Ming <minggr@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36269
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

On Thu, Apr 18, 2013 at 8:44 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Apr 18, 2013 at 03:13:55PM +0800, Lin Ming wrote:
>
>> I encounter a problem that cpu stuck with irq disabled, which is known
>> as hard lockup.
>> I know there is NMI hard lockup detector for x86, which can dump the
>> back trace of the hard lockup.
>>
>> Is there any similar feature for MIPS?
>
> No, there isn't, unfortunately.
>
> This is because on MIPS an NMI is very different from for example x86.
> An NMI goes straight to a firmware address and most firmware implementations
> don't provided a suitable hook for an OS to gain control back from an NMI.
>
> Generally on MIPS NMIs are used to signal catastrophic problems, things
> like a machine check exception but external to the CPU.
>
> One of the notable exceptions is Octeon where (see the Octeon watchdog
> driver) an OS can regain control after an NMI.  Malta and SGI IP27 also
> have somewhat useful NMIs.

Thanks for the explanation.

Since no NMI available, what I am trying to do is:

- reserve some boot memory
- write a ftrace tracer, save ftrace functions to the reserved memory
- when hard lockup happens, hardware watch dog will reboot the board
- get the functions from the reserved memory, see what it was doing
when hard lockup happened.

Or any other hints to debug such kind of hard lockup on MIPS?

Thanks,
Lin Ming

>
>   Ralf
