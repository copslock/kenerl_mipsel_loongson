Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 15:53:42 +0100 (CET)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:39887
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeBMOxfNWe3X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 15:53:35 +0100
Received: by mail-ua0-x243.google.com with SMTP id r4so11715690uak.6;
        Tue, 13 Feb 2018 06:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0O7cIMKFrMbDs5s4nCNu+isYGySTudKjdMVrnsX/3Gc=;
        b=t3QObF0RvHes3xhVBMHIjoP+/zoF4yBoFhV129ADOBX6qg5BflI9T9mF1DqPphex+M
         o53Tsdy8yRCbe8Sifk7L1/1og+PHrwYhC+uxDrDccv4c/hMY9a26qmQOhA1oY4Rhujot
         RiPZDirmjaBMjmksPybyh1zpvOsnFQhR+K8nGOjYXZ63Lmtjn2pEhoNnFOsDo4BSGVAV
         Ldw8tWyay/R03VesHF1tU4v9TsXDyoJAuLu6JHWSlj7RDkm8R26USMH9MVObR06BzN+H
         7yFSdZkppIVLMlcbSQk4PPnZJtJYUPJOqo11c9znCILu70XUhUlzbMrAJMye+c2EA/pJ
         dZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0O7cIMKFrMbDs5s4nCNu+isYGySTudKjdMVrnsX/3Gc=;
        b=hmOHQj9KsVvBDXPRKqVujgWo7LJEeVLP58HnbEh4YAui2k3BxhhR5sFy5dsry0vazo
         cI3GfERcHTncsIEWRTUDwjfOjp691FvMcFq2qFdCzn1LYAWa01qoTX322LFhYCrn4gPc
         OGgzLONCujrsBVX//3U4/xi3t1nBoKKB5nEJf8aO7rJYh9+GOm3iMmADVhWM3y6IHbwX
         Vdp92oIrmAWYCieYf9lI7SQ4lA1GTubBQ3HeHJ61j20QkeDLlJM5+f53eS19dpGn4+7n
         v/9DWdIkE8bCzdH2fmu3DqxI/8UC2+Xai9Hw+E0/rRZDhdUs1n2rJYqs4zx7lhyyMcA1
         Azaw==
X-Gm-Message-State: APf1xPA12Ah3INyTSvqfAm3WKpsF5T2QQtAqjs5B/lbsBVCuGrooTR79
        /EFqIVSp6FxRX/XX2P7cH6rRxqH0+xgLVFs2bII=
X-Google-Smtp-Source: AH8x226el3R7xI6Abw7av4jKf4pZf+FRlyHeXib8BiiVs2SDoFUvoja5vnvjnUp9s8iG3ZasTh7SL4KSVdRZhEdUKoQ=
X-Received: by 10.176.19.243 with SMTP id n48mr1388419uae.14.1518533608813;
 Tue, 13 Feb 2018 06:53:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.38.193 with HTTP; Tue, 13 Feb 2018 06:53:08 -0800 (PST)
In-Reply-To: <20180213143239.GE4290@saruman>
References: <20180201113721.24776-1-marcin.nowakowski@mips.com>
 <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
 <CA+7wUszerm6VQsboY9hhgzEZejFOyKZtoh+eCpAESho-xdmQXw@mail.gmail.com>
 <20180213133832.GD4290@saruman> <CA+7wUswyQjRvY1=4g785jNBnfAAqSUbyYSWh3qKHieJVhmbxSg@mail.gmail.com>
 <20180213143239.GE4290@saruman>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 13 Feb 2018 15:53:08 +0100
X-Google-Sender-Auth: Rab9j9XZSOHwk4PME60myT4C1BI
Message-ID: <CA+7wUszvYS4zHZD+m3gRO0GeZ8dUmYRPmqfZR+EkkRb7MuUoRg@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        linux-mips@linux-mips.org, "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Hi,

On Tue, Feb 13, 2018 at 3:32 PM, James Hogan <jhogan@kernel.org> wrote:
> On Tue, Feb 13, 2018 at 03:03:24PM +0100, Mathieu Malaterre wrote:
>> James,
>>
>> On Tue, Feb 13, 2018 at 2:38 PM, James Hogan <jhogan@kernel.org> wrote:
>> > On Tue, Feb 13, 2018 at 01:14:29PM +0100, Mathieu Malaterre wrote:
>> >> Could you please review the patch v3 ?
>> >
>> > Yes, looks good to me, and Ralf had applied to his test branch so I
>> > presume he's happy with it too. I'll apply for 4.16.
>>
>> Hum, just to be sure I understand the process. Which branch are you
>> talking about:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git
>
> I was referring to upstream-sfr.git branch=mips-next-test
> https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/log/?h=mips-next-test
>
> (The mips-next branch there is what Ralf puts into linux-next)
>
> I've applied the patch to my mips-fixes branch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
>
> Sorry it seems a bit haphazard with multiple trees in use.

I see it now, sorry for the noise. I was not looking at the right location.

Anyway if that answer earlier question 4.11 should be correct, since I
asked Greg to not backport the earlier patch:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1505915.html
