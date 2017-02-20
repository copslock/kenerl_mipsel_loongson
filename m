Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 12:28:52 +0100 (CET)
Received: from mail-yb0-x231.google.com ([IPv6:2607:f8b0:4002:c09::231]:33578
        "EHLO mail-yb0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdBTL2p2ORLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 12:28:45 +0100
Received: by mail-yb0-x231.google.com with SMTP id u130so8476749ybb.0;
        Mon, 20 Feb 2017 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FVknD1LsjlkR5G+tzOFJ3MvN+kQrXrGbtlQWuQZ5bmI=;
        b=q943ieSeU0qAKWpj7e5zKz8qgqm+t0C65n2v2E9o339b+cL0cjD+d0dGTZcsiMsWJx
         MqXLJPBAYscFg9kAfLIlEPj98I8Dkdg/k81e2RDg21CQVJeD9DP/KDFW+zQ7klzSSgY9
         OOX6JD98PN6I1qQhLse++zTw4PqzmuHMQUbY2TUHjST7fOkzgMe/953EDGW+evfQHO2D
         8qn/8JVXKU2XQ/adM3pft6zGKsagi0jDD3Vu0H3tKCTH+iLHbc64zz4AMUkOMFjZa8Ng
         /W0ojmPm7a3JZA/0VsWvrsBZTmlex6cwxdkl8Wi5VV4R4c/D+604ZOvL44S3pRQLFhvl
         fXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FVknD1LsjlkR5G+tzOFJ3MvN+kQrXrGbtlQWuQZ5bmI=;
        b=ORpIs08uPrfOJ46MxVw9ODYK1GiymIoLwY9v7C1y6jvmTuMDpXzbsaAI/W2sKP71HO
         vye5wXJp+PUMyho1ykIqnTWuCQTCqfiTP6A+1RtXRtkaO4FSZ5/S2KS6/qnzQL6xJeH8
         FbTJyN6DRj8KcqWwd0HEYaBbXPTsSsUTcGY8SFA4SUkxTEjfLGHLyjC1h3qDo8RLGeuc
         8ARy+/Iwl62xrdRUtYzVbQhnty1UAa8FH258D1cVG6d/g351ZsyGDlfNfSqmAPZwmTcg
         4rt4JisNUasMVP4C39TZ6t1yeIfbB0++T5zA04F9gupTfBMLexFG+xZtkooJxSV4g2pH
         HjTg==
X-Gm-Message-State: AMke39kLlqIO8wN0IKNjJur1gKCBttRg3zrjOQpZ7oMIfw3wJKm/O6Ob3w9mBYEgyriZ8P/p1I0Sn0wB8sAMKw==
X-Received: by 10.37.50.211 with SMTP id y202mr2571916yby.49.1487590119718;
 Mon, 20 Feb 2017 03:28:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.32.5 with HTTP; Mon, 20 Feb 2017 03:28:39 -0800 (PST)
In-Reply-To: <50640771-abc2-dd9a-7418-7393afe23cd5@gmail.com>
References: <1486147623.22276.70.camel@perches.com> <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
 <1486148236.22276.72.camel@perches.com> <20170203203609.GA14271@kroah.com> <50640771-abc2-dd9a-7418-7393afe23cd5@gmail.com>
From:   "Jayachandran C." <c.jayachandran@gmail.com>
Date:   Mon, 20 Feb 2017 16:58:39 +0530
Message-ID: <CA+7sy7BpkOS1zGo17NkrQtukT5jKh3+EB9BXQLGnunV1HSs9oA@mail.gmail.com>
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <c.jayachandran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.jayachandran@gmail.com
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

On Sat, Feb 4, 2017 at 2:08 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 02/03/2017 12:36 PM, Greg KH wrote:
>> On Fri, Feb 03, 2017 at 10:57:16AM -0800, Joe Perches wrote:
>>> On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
>>>> (with JC's other email)
>>>
>>> And now with Greg's proper email too
>>>
>>>> On 02/03/2017 10:47 AM, Joe Perches wrote:
>>>>> 64 bit stats isn't implemented, but is that really necessary?
>>>>> Anything else?
>>>>
>>>> Joe, do you have such hardware that you are interested in getting
>>>> supported, or was that just to reduce the amount of drivers in staging?
>>>> I am really not clear about what happened to that entire product line,
>>>> and whether there is any interest in having anything supported these days...
>>>
>>> No hardware.  Just to reduce staging driver count.
>>
>> Without hardware or a "real" maintainer, it shouldn't be moved.
>>
>> Heck, if no one has the hardware, let's just delete the thing.
>
> I do have one, and other colleagues have some too, but I am not heavily
> using it, nor do I have many cycles to spend on that... sounds like we
> could keep it in staging for another 6 months and see what happens then?

Unfortunately, I am no longer with Broadcom and don't have access to these
boards anymore. This driver is for XLR, the next generation SoC called XLP
has a different on-chip network accelerator - and that driver is not available
publicly other than in FreeBSD[1]

JC.
[1] https://svnweb.freebsd.org/base/head/sys/mips/nlm/dev/net/
