Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 22:11:19 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:62485 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903748Ab2CWVLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 22:11:02 +0100
Received: by werp11 with SMTP id p11so3622162wer.36
        for <multiple recipients>; Fri, 23 Mar 2012 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=bv3GxlnqXeP0EIoH7wmcIhKFwkBIBMPmqr22KQ+6rKA=;
        b=uWnZEAoqhAhae9cRhq2ABfMrLQ/8PHxn0Y12AJN2I9FUo2zoJAr9N1d9o/3Nr8YAOK
         V42akXBuBshFx7CXTOghO6OSXzllXvvtuLWPmmS8gayt+QRhF64RMp4VOR4NmLuJES/g
         hEv7dZkzIN5E0Bmk8WQOv8kMt2YgLZNvdReS/Tb3kB7+XWGVgTWdC7af+dkKS9kBFW9B
         VEXaCKbU1FrAum7ZuZFjY7YeHD4YLAFZfHCG9mNdT40veAGEs5J2Z9c/DOy1zPo+2N0f
         EONGsmmd/EDanIKO7x50ftrHkRKctiuA2RO6i6FyYSuXrBQWf6OpTV4YkTnjcQ+noLri
         NtuQ==
Received: by 10.180.80.104 with SMTP id q8mr232024wix.14.1332537056840; Fri,
 23 Mar 2012 14:10:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.180.103.163 with HTTP; Fri, 23 Mar 2012 14:10:36 -0700 (PDT)
In-Reply-To: <CAE9FiQV96Uz9fU=v4=eBbAogOeehuBM3eHgSr0QW_C68ceADcQ@mail.gmail.com>
References: <20120322144817.796e3a8a@jbarnes-desktop> <CAE9FiQV96Uz9fU=v4=eBbAogOeehuBM3eHgSr0QW_C68ceADcQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Mar 2012 14:10:36 -0700
X-Google-Sender-Auth: ffOhPBmVWUEJmaWNqXMms9mvhqo
Message-ID: <CA+55aFx+dXoJ=MGmpyzepDjBDv8LpXqdxUBCbdrakMKBsKpmTw@mail.gmail.com>
Subject: Re: [git pull] PCI changes (including maintainer change)
To:     Yinghai Lu <yinghai@kernel.org>
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
X-archive-position: 32741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Mar 23, 2012 at 12:58 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> There are some merge conflicts. Hope attached patch could help Linus a
> little bit.

Hmm. My merge does not agree with yours at all in the MIPS
pcibios_fixup_bus() area.

Your patch re-introduces the device resource fixup that Bjorn removed,
for example.

I think my merge is correct, but hey, people should double-check.

                       Linus
