Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 22:29:55 +0100 (CET)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:56340 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903748Ab2CWV3j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 22:29:39 +0100
Received: by vbbfo1 with SMTP id fo1so2260636vbb.36
        for <multiple recipients>; Fri, 23 Mar 2012 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=CU5X3Ay4gdK02VrAIUN1asiBr9Y/isbdfMLArQBBMgU=;
        b=DzdfYis4n0fnyhxu36KLUsVqqPhhecN3M2QWzqBA5xM1o5bbSX7X2zmfSi+FksSRfZ
         qe5Y7ZwKt0JPQrqM6CkbSPCILyVX/VNy3B0jd0GUa3eEI8oMJVS3ZW2WXLxYhHM7StSh
         0AFk5u4OncpVbcd4+94H1OwcJr1Cp2vbLoBxf2NS1ky2RUGBVoAr8OtVqH85c5oxXR4i
         L9jK1rF1LgnFH3fovqPmE4P+iyxow97AhVUT/a+VJsI/NxAHC5/kplTnl8F17jwTGrEQ
         y6vqeKzjNkwEbtw4krV5SXmRb97TgG9Bx7QaHVkGr7I5Dy7oSTlN6XY5eN5b3fB5H/cP
         CBBw==
MIME-Version: 1.0
Received: by 10.52.176.198 with SMTP id ck6mr5137320vdc.0.1332538173562; Fri,
 23 Mar 2012 14:29:33 -0700 (PDT)
Received: by 10.52.111.137 with HTTP; Fri, 23 Mar 2012 14:29:33 -0700 (PDT)
In-Reply-To: <CA+55aFx+dXoJ=MGmpyzepDjBDv8LpXqdxUBCbdrakMKBsKpmTw@mail.gmail.com>
References: <20120322144817.796e3a8a@jbarnes-desktop>
        <CAE9FiQV96Uz9fU=v4=eBbAogOeehuBM3eHgSr0QW_C68ceADcQ@mail.gmail.com>
        <CA+55aFx+dXoJ=MGmpyzepDjBDv8LpXqdxUBCbdrakMKBsKpmTw@mail.gmail.com>
Date:   Fri, 23 Mar 2012 14:29:33 -0700
X-Google-Sender-Auth: owgF0ten7fO3bLW7IR2TMkQ2F9Q
Message-ID: <CAE9FiQVs5+BVmn46xeXR_GwOYBkYy73-aSKYHQUv3EoTTiUtYQ@mail.gmail.com>
Subject: Re: [git pull] PCI changes (including maintainer change)
From:   Yinghai Lu <yinghai@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jesse Barnes <jbarnes@virtuousgeek.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yinghai@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Mar 23, 2012 at 2:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 23, 2012 at 12:58 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> There are some merge conflicts. Hope attached patch could help Linus a
>> little bit.
>
> Hmm. My merge does not agree with yours at all in the MIPS
> pcibios_fixup_bus() area.
>
> Your patch re-introduces the device resource fixup that Bjorn removed,
> for example.
>
> I think my merge is correct, but hey, people should double-check.

yes, you are right.

Yinghai
