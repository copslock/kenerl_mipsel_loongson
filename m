Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 09:56:43 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:57848 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491044Ab0IWH4k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 09:56:40 +0200
Received: by qyk34 with SMTP id 34so2182852qyk.15
        for <multiple recipients>; Thu, 23 Sep 2010 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hC7dxC8GWn7nxnUv+8v6jdbc8XjJFOA9KC4BfMFoJ3w=;
        b=k2R++S1KOWNaiGtqQ2XBr4c92GGf3GH94LekSO+O/POvT1i7JBLO/0Xc2Yk847S43D
         +i849HjO6MkVp2jYqS0Gg3r6TQ1b3t7lax27bffLRDlbfGb7utk/p5Zr95+je2/Huaj3
         HCj9/DtgyGVtQ24VaFkl6T/dTKmRUfNwB9oyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XzWqtNyEfJuGPNyMJw+YGbwgrOxLjR+fdgOfQlZ0ouxREnO6D6xMVnYNDWJO1GkE4z
         Y7wNGDZx37WN5ar8qfCW2e0c2MyjoT39F5TMWH1NaEeQ3J6WZ7xTD2wao6Ol67L4JNFc
         yN8gCKq7PuKzSFvizOcApxU4q+YuGNQ/5q6EY=
MIME-Version: 1.0
Received: by 10.229.236.74 with SMTP id kj10mr999450qcb.221.1285228593837;
 Thu, 23 Sep 2010 00:56:33 -0700 (PDT)
Received: by 10.229.25.208 with HTTP; Thu, 23 Sep 2010 00:56:33 -0700 (PDT)
In-Reply-To: <20100922123221.GA16333@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
        <1276058130-25851-8-git-send-email-dengcheng.zhu@gmail.com>
        <20100922123221.GA16333@console-pimps.org>
Date:   Thu, 23 Sep 2010 15:56:33 +0800
Message-ID: <AANLkTik1_pTgODLoFQ01_45is5L5Z02N7=jwyQK8zNCM@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] MIPS: define local_xchg from xchg_local to atomic_long_xchg
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18051

Yes, it's here only to pass the compiling (coz the Perf core had evolved
since the v5 of this patchset). Since the file it touches is stand-alone,
it can be applied earlier than the rest (like the patch #2).


Deng-Cheng


2010/9/22 Matt Fleming <matt@console-pimps.org>:
> On Wed, Jun 09, 2010 at 12:35:30PM +0800, Deng-Cheng Zhu wrote:
>> Perf-events is now using local_t helper functions internally. There is a
>> use of local_xchg(). On MIPS, this is defined to xchg_local() which is
>> missing in asm/system.h. This patch re-defines local_xchg() in asm/local.h
>> to atomic_long_xchg(). Then Perf-events can pass the build.
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
>
> Is this a separate issue from the rest of this patch series? In any
> event, it's probably worth moving this earlier in the patch series so
> as not to break bisect.
>
