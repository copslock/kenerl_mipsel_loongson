Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 11:21:54 +0200 (CEST)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:34749
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdJFJVp18aXo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 11:21:45 +0200
Received: by mail-ua0-x244.google.com with SMTP id 88so4289749uar.1;
        Fri, 06 Oct 2017 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r4YpHl9znaw/ZBRVhYnY0y63BxF9sAIvPNPeP5gq0FM=;
        b=pLLITWPot3xjWAhAw+RqLpvdULrjiZ394oC/bXzijDAjjdjkGq+EOG7nfJMIe+Tih4
         EoHTK0fmYmlCGF9xa/BfBkGEnD1lgUgoavOuRD8V6IM/eLIuWM7W/31/+nVa5hPFRnsV
         hzGHX1oVWNZdZK42OqvGJMM9YYsezzvwvc9u3gHo+dkIpi1WlrKS828vE6RgZl7kCJbY
         aSlwFKx6HVexNJkIdPP30rYlzdltVDl2M00K6gS4jlGRFq2yRkuxI9RTOZpytWhVGVfz
         NFWI5ghO+lYqqCVO9OSkvatEh019DvIq7H/VkLEjiVuvr/dn3HO1s3xcYDAfLy6R7ume
         xGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r4YpHl9znaw/ZBRVhYnY0y63BxF9sAIvPNPeP5gq0FM=;
        b=nrhvXAuFD5rAmRBM3iP+1e1TwJjCXP/pWM0EdgZF1fR8PFG81flKjx2Au5wpOisRqQ
         vfsgEi/jnEIYmpKD2yJjUzC7slr4kDuAqh5gXPDQw5WJ4b18oh4rXcUJJyn53wRYF49c
         MoboKY3L/tWploJs6aPimZ3CWZP4zdkDG73QkZSdEPa9GN177YcnmRtFloDWXIvcRdg5
         k+3k/fkghX8gdQ0V3MM2kCup6fq7P1pjzJ1oIW8dddDiFmMojY0kzzGZEa5OwPvZY7Yc
         hrKTsSS58SXvPFwT6RZpyw1e5ecUkMEpFi90HwKVVX2Y1IQHb9q0PZ36iFql6866xhrx
         74Sg==
X-Gm-Message-State: AMCzsaVaUYLi+NHNPcPjgm/d1Ii49YhcPPu4ZRkDcwzBZ73EmAhI29lC
        /6SWrvs41tBd5t6MU9TuGqa5glZs3r5WJRIgIxU=
X-Google-Smtp-Source: AOwi7QCgpXfbigYs2dl65fvBEqQDTzfhXrDfrGIYYcZGFpTlvLuG53omw0zfucaExSWzgsFAvyudYIb4iBMOZteAmsE=
X-Received: by 10.176.8.24 with SMTP id a24mr665985uaf.17.1507281699205; Fri,
 06 Oct 2017 02:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.65.199 with HTTP; Fri, 6 Oct 2017 02:21:18 -0700 (PDT)
In-Reply-To: <20171006091806.GA17988@kroah.com>
References: <20171006083840.743659740@linuxfoundation.org> <20171006083842.248091756@linuxfoundation.org>
 <CA+7wUszpNtwje0kPs07nDD2aSeYafSuW1dpX8+Z5HKOBSNC0eA@mail.gmail.com> <20171006091806.GA17988@kroah.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 6 Oct 2017 11:21:18 +0200
X-Google-Sender-Auth: bn4S9ENQI59cOIY6SCDz6bQKe6Y
Message-ID: <CA+7wUsyJMPeTD0Mm=wkshU01fyS=Qa6iZKLJN9==vTWeSjk2Pg@mail.gmail.com>
Subject: Re: [PATCH 4.9 010/104] MIPS: fix mem=X@Y commandline processing
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60310
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

On Fri, Oct 6, 2017 at 11:18 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Oct 06, 2017 at 11:10:11AM +0200, Mathieu Malaterre wrote:
>> Hi Greg,
>>
>> Please do not apply to stable.
>>
>> See: https://patchwork.linux-mips.org/patch/17235/
>
> Ah, so will you send this and that one for 4.9 when it hits Linus's
> tree?
>
> I'll go drop this one now, thanks.

Sorry I meant to say do not apply to '4.9 stable branch'. For the
other stable branches, I suspect this is just a matter of days before
Ralf sends the updated fix.

-M
