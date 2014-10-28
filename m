Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 08:08:33 +0100 (CET)
Received: from mail-yh0-f43.google.com ([209.85.213.43]:40052 "EHLO
        mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011464AbaJ1HIaunBMx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 08:08:30 +0100
Received: by mail-yh0-f43.google.com with SMTP id z6so25030yhz.30
        for <multiple recipients>; Tue, 28 Oct 2014 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ulxz9SI7g/FSs39Mq3FEAIaL6zlw4m0qQ3Fl18WHd0k=;
        b=dJ+IquuXM57mXFP8HzJp1crQ1u3sB5CjMxxtLj0DIsLsRqBhXFoUnVuCVNAOr39gLB
         UGMdE0pY+sZSjWYsSEM+3X5S+z3npUKEw/RIS7rWkqnBJ7qTJ6tEHPENnSyhdnefc658
         HBzp//SH/rKURdw7sROPm3wB7hePnrHonD+0bhAX5TXrI9BfYJduHnKlioOz5kpGUcfI
         iZn/N4zAZ2mfphDJHOytVU68zwtJxnKRWw2SQPT6OGVvIuGawJp/1uU5/eQnLuwa7Kq7
         gjl1CVrdfe2MgKWpI6aew55RPsi/b2st0aevzQjTk/GngDT0TUWAbCjjTze1kz/flB5w
         nrXg==
X-Received: by 10.236.14.97 with SMTP id c61mr1179582yhc.132.1414480104578;
 Tue, 28 Oct 2014 00:08:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Tue, 28 Oct 2014 00:08:04 -0700 (PDT)
In-Reply-To: <20141027180436.GE28300@tuxdriver.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-12-git-send-email-ryazanov.s.a@gmail.com> <20141027180436.GE28300@tuxdriver.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 28 Oct 2014 11:08:04 +0400
Message-ID: <CAHNKnsTWvZy=-TBv-KPjCOD-vhwcxUUGv61doYUm0F77if-pqw@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] ath5k: revert AHB bus support removing
To:     "John W. Linville" <linville@tuxdriver.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath5k-devel@venema.h4ckr.net
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43614
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

2014-10-27 21:04 GMT+03:00 John W. Linville <linville@tuxdriver.com>:
> On Wed, Oct 22, 2014 at 03:03:49AM +0400, Sergey Ryazanov wrote:
>> This reverts commit 093ec3c5337434f40d77c1af06c139da3e5ba6dc.
>>
>> AHB bus code has been removed, since we did not have support Atheros
>> AR231x SoC, required for building the AHB version of ath5k. Now that
>> support WiSoC chips added we can restore functionality back.
>>
>> Singed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Jiri Slaby <jirislaby@gmail.com>
>> Cc: Nick Kossifidis <mickflemm@gmail.com>
>> Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: ath5k-devel@lists.ath5k.org
>
> Acked-by: John W. Linville <linville@tuxdriver.com>
>
John, should I include these two patches in v3 or you already merge
them in your tree?

-- 
BR,
Sergey
