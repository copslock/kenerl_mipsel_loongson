Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 14:38:15 +0200 (CEST)
Received: from mail-yh0-f44.google.com ([209.85.213.44]:51239 "EHLO
        mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012115AbaJVMiOINOoz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 14:38:14 +0200
Received: by mail-yh0-f44.google.com with SMTP id i57so3386743yha.3
        for <multiple recipients>; Wed, 22 Oct 2014 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VquJfmGF2MYI8+ApnlwOhUjCWNFg/F/7ia/u/xH3Lb0=;
        b=HVBkXP90KhjxQBcCIGDwQarIbulZfCnrCYYWVje/3Ymn8bRm3csvMaZSLNS50NV8fR
         xoAXNPSALqkq9BRVqMWORPEKeDEEYd4+E8OlDWe96N2RJ55YAtXKfDXs3DGbyD0hnk0z
         pY/pnlc7zSyJJint++q3maQ5Sqsy/RSJT5BoNBJVQihT//QHzX/rxX14iWUXuYGnsoXE
         j48v/Ntl1mFE85yhlRuaFO68X9HYjkppkT/7lXgJtghxfl13l7hGvY0pXQcqWka15p5y
         qTFXx2LqqTrkimTRQbK+thfSQb08IvygfuJWh+oamd8nWYxYrM0enHVWglbFETkISu/J
         72SA==
X-Received: by 10.236.14.97 with SMTP id c61mr4869910yhc.132.1413981487053;
 Wed, 22 Oct 2014 05:38:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Wed, 22 Oct 2014 05:37:46 -0700 (PDT)
In-Reply-To: <20141022121824.GA19113@localhost>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-12-git-send-email-ryazanov.s.a@gmail.com> <20141022121824.GA19113@localhost>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 22 Oct 2014 16:37:46 +0400
Message-ID: <CAHNKnsT4g_yYOA6DnuvmRbR-xbAGUsdzWV8Bik62f+xtt=Vy4g@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] ath5k: revert AHB bus support removing
To:     Bob Copeland <me@bobcopeland.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "open list:ATHEROS ATH5K WIR..." <ath5k-devel@lists.ath5k.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43482
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

2014-10-22 16:18 GMT+04:00 Bob Copeland <me@bobcopeland.com>:
> On Wed, Oct 22, 2014 at 03:03:49AM +0400, Sergey Ryazanov wrote:
>> This reverts commit 093ec3c5337434f40d77c1af06c139da3e5ba6dc.
>>
>> AHB bus code has been removed, since we did not have support Atheros
>> AR231x SoC, required for building the AHB version of ath5k. Now that
>> support WiSoC chips added we can restore functionality back.
>>
>> Singed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>   ^^^^^^
>
> Please keep the patches away from the stove! (SCNR)
>
I will send the healthy patch in v3!

-- 
BR,
Sergey
