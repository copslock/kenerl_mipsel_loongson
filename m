Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 17:47:57 +0200 (CEST)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33629 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007756AbbFCPrxFdSCt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 17:47:53 +0200
Received: by qcmi9 with SMTP id i9so5777215qcm.0
        for <linux-mips@linux-mips.org>; Wed, 03 Jun 2015 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6wrq2Wqlv/lsRTwRYiErGIXknp5kPZs/gEmaZQ2BgK4=;
        b=hb4YNwDXNyDET8nDu/j+cb4tMCP5DLbzJrRpregPiEI+cepsqzkU6PeEmyLQwz2l5J
         a6cUSy2SGoIwp8JTqjJbp+glsfthU1MG6GEbu4YLJerDJC4B9zlJNYJB7c4tijNmKwYX
         aD6rQIQS6wUIlGi38LOzt5uO6kqMedxCQO1t3S+spdAhJQHTLdFsfoWGmvWF0Fv9XCPo
         H5T0ufjLgteUkx83gHKBlYp4FHSMBpb0MkqUzLRn6NopGUQcQkBTWRzOf04Wbe6o8s8j
         KPfQp6DN+YptKvHBhDc7qHIcBcPBIemjLtM8Gqn6km1b5Lx7ScGSldnn008lkDgowqqB
         rJqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6wrq2Wqlv/lsRTwRYiErGIXknp5kPZs/gEmaZQ2BgK4=;
        b=IMY9zwKYWfdDk+zBnFuLOz3RWQxLViEmJ7qWJmETGscIlWH8S2CAok671+1RPbA+rF
         H5W2Uyi+7Hrt3k3JErXUOBqKyFsYTBq9HnLtOwSVZ/ff0jsKMlkduzKAeSeAT+mkLbuJ
         gfYy84A4xaH3ZpF6hk6LkCAPqbO0Hd55jeZOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6wrq2Wqlv/lsRTwRYiErGIXknp5kPZs/gEmaZQ2BgK4=;
        b=O17/BMreNvory53bfQxTSxfb9nUBb0Sj2odBwZsXt3bS1sMAdezYNK4SgkZdqfnp6Q
         LlB/opWOwrYiOyKzSZYLXIHGdirpfs9A3kioXAvtrd2bTEBRv2MsvSYmt/QySFZo0YzV
         jh5CAV5fLQvVQLpzpdlU+0ynqgDfdA4+MTRB33XFRifjj3gzkAuoflCyfV/o2soJGxVX
         0hyW9pRWP+y+aujMlWhtqUTxvpVeTrbckXOYi1dCh8iZc3h6wmyuSIGUI44PqJI6ircE
         G2fi0gpmUbjgYZl6VZf8b9t0i86mJmIGTn82bFzTz0WSbayV4/Bopp86a94dwkwUmYZ0
         ma1Q==
X-Gm-Message-State: ALoCoQlaac1mXXZ1LXWt/fZC0fWjZsv3YNbngmS5uwuLd3R4Fx2l/KCMh4zC1s42H6dK+TZsBdO5
MIME-Version: 1.0
X-Received: by 10.55.41.17 with SMTP id p17mr60193326qkh.86.1433346467353;
 Wed, 03 Jun 2015 08:47:47 -0700 (PDT)
Received: by 10.140.19.17 with HTTP; Wed, 3 Jun 2015 08:47:47 -0700 (PDT)
In-Reply-To: <CAL1qeaFdcqUoivOkBjbGEtMovDow08_j68k+Z7mxrY==OAhAWA@mail.gmail.com>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
        <CAL1qeaE0+aMLBgk8SKgJ3fXm==M2-Z_yEPYNVZ0yxSee-p7YOw@mail.gmail.com>
        <5549083F.8080505@imgtec.com>
        <5550C06D.2010409@ti.com>
        <556E99B4.6090307@ti.com>
        <CAL1qeaFdcqUoivOkBjbGEtMovDow08_j68k+Z7mxrY==OAhAWA@mail.gmail.com>
Date:   Wed, 3 Jun 2015 08:47:47 -0700
X-Google-Sender-Auth: l5sBiBl7O6T-5oSMHuNe1Xr6NFo
Message-ID: <CAL1qeaGr9b3O-aqO+i=301wPsv9eYPmTM+xz15-wqaL8xNPwmQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Pistachio USB2.0 PHY
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Wed, Jun 3, 2015 at 8:44 AM, Andrew Bresticker <abrestic@chromium.org> wrote:
> On Tue, Jun 2, 2015 at 11:07 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>>
>> On Monday 11 May 2015 08:15 PM, Kishon Vijay Abraham I wrote:
>>>
>>>
>>>
>>> On Tuesday 05 May 2015 11:43 PM, Ezequiel Garcia wrote:
>>>>
>>>> Hi Kishon,
>>>>
>>>>>
>>>>> This series adds support for the USB2.0 PHY present on the IMG Pistachio
>>>>> SoC.
>>>>>
>>>>> Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If
>>>>> possible,
>>>>> I'd like this to go through the MIPS tree with Kishon's ACK.
>>>>>
>>>>
>>>> Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>>>
>>>> Can we have your Ack for this series so Ralf can pick it?
>>>
>>>
>>> sure..
>>>
>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>>
>> I'm not sure if this has been merged yet. But this will cause conflicts with
>> other PHY patches in Makefile and Kconfig when linus merges to his tree. I'd
>> prefer the phy patches go in PHY tree itself.
>
> It doesn't look like Ralf has picked these up, so if you want to take
> them through your tree, that would be great.

Actually I take that back, looks like Ralf just picked them up.
