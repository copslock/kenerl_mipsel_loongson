Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 23:05:45 +0200 (CEST)
Received: from mail-yh0-f44.google.com ([209.85.213.44]:36668 "EHLO
        mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010113AbaI2VFmuSRFT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 23:05:42 +0200
Received: by mail-yh0-f44.google.com with SMTP id i57so561719yha.31
        for <multiple recipients>; Mon, 29 Sep 2014 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5ILLP25m2uCWbton/2Ddp1nVOWfI06p/PF/ZroozZhc=;
        b=xhAjUwWagCn25WKxeonSxjiGTD6fDrkwIp7qMZJqtPmb/y2z3nV6+IbtoghueRSfv/
         SwZtxMIazACjM1nMtY0v/702l0lyrN/trqxRF/Esur0PDb1eWf9uf2s1QRzGsQ3b0KId
         /1Shc5yLKb9+8NoKXT/b0j96FtaK1d7LuJi36eNmfah0/UO6/9yRewuGghxELXMgvl5y
         f53mbPiRFyojgcHeDUt7PANkl99pDbfv2L4QlR5GrclO4MRIVMDe8hKOj0iVFy5iOzMd
         vqrGawU+ubDZ/PndDR7FlTyzlawUqpEiGyDVDNzwomAS5niF5GaNDO3lfti73x0tMPfn
         NS2g==
X-Received: by 10.236.175.4 with SMTP id y4mr4383yhl.171.1412024736726; Mon,
 29 Sep 2014 14:05:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Mon, 29 Sep 2014 14:05:16 -0700 (PDT)
In-Reply-To: <CAOiHx==vwHX59bbpcRBzj_6-jEiSKOV3qAjsh1WsLfGHh9AL+w@mail.gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-3-git-send-email-ryazanov.s.a@gmail.com> <CAOiHx==vwHX59bbpcRBzj_6-jEiSKOV3qAjsh1WsLfGHh9AL+w@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 30 Sep 2014 01:05:16 +0400
Message-ID: <CAHNKnsTegWQhQAGkJ_Z9xraTJv8cUHzJcg-BqyHV2gWJhd1Muw@mail.gmail.com>
Subject: Re: [PATCH 02/16] MIPS: ar231x: add basic AR5312 SoC support
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-09-29 13:35 GMT+04:00 Jonas Gorski <jogo@openwrt.org>:
> On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>> Add basic support for Atheros AR5312/AR2312 SoCs: registers definition
>> file and initial setup code.
>
> For the whole file: please use the style
>
> do_foo()
> {
>   if (is_ar5312())
>       ar5312_foo();
> }
>
> instead of
>
> do_foo()
> {
>   ar5312_foo();
> }
>
> ar5312_foo()
> {
>   if (!is_ar5312())
>     return;
> }
>
Ok.

> also same comments regarding naming (ar531x instead of ar5312).
>
Seems there are no reasons to change naming approach (see details in
previous patch discussion).

> Regards
> Jonas

-- 
BR,
Sergey
