Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:18:52 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:47320 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492096Ab0KWSSn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 19:18:43 +0100
Received: by pzk30 with SMTP id 30so174545pzk.36
        for <multiple recipients>; Tue, 23 Nov 2010 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=nju9qKTnHQrNnbjC48N17DBLOPZOpO6rLULwgj69KI8=;
        b=YXoE5452Rh0WP98IDCEZtziR6+CRaEj+2ZWOVcaY5FVfzo4oOtaqo7IHyOQTHM67mW
         poKTTL6FYiGIrFlUsReL0YfHhKv/6x+1TQvsDzJSFsxEsdfDrr6xL04/eJ1V65s4ijm9
         REdusfh+MP4A2ZKDTqOxcZomdbPcFaykPtE+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g4cX6e3MO1i+GAIMf8nFFU1hrz24x6/asRzutUpKI96rXpMrAbXAk3UgE51msWxy9v
         qWJKhoRD90arkh28Bs6BAVuzSBx+hjcK6WzS/1B3yTl79cLefyqm0AKeyiiVONEJi7jn
         PKcruG3nTmswUy3ogSwpStW8JkWcTJIGTcxi0=
MIME-Version: 1.0
Received: by 10.229.80.77 with SMTP id s13mr6604951qck.186.1290536312845; Tue,
 23 Nov 2010 10:18:32 -0800 (PST)
Received: by 10.229.182.3 with HTTP; Tue, 23 Nov 2010 10:18:32 -0800 (PST)
In-Reply-To: <AANLkTi=qvMHZu7xZz8Rjr2TcKZj0rNKsKZz6D8Re0_0T@mail.gmail.com>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
        <AANLkTi=qvMHZu7xZz8Rjr2TcKZj0rNKsKZz6D8Re0_0T@mail.gmail.com>
Date:   Tue, 23 Nov 2010 13:18:32 -0500
Message-ID: <AANLkTinTC9_XteCb-ojRwAmeaRyvTYVr6Phfxj4vXcUV@mail.gmail.com>
Subject: Re: [PATCH 00/18] MIPS: initial support for the Atheros
 AR71XX/AR724X/AR913X SoCs
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <lacombar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, Nov 23, 2010 at 1:16 PM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> Hi,
>
> On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
>> This patch set contains initial support for the
>> Atheros AR71XX/AR724X/AR913X SoCs.
>>
> Could you maybe describe what changed between the first submission and
> this serie ? AFAIK, there has been private review/discussions going
> on, so this would give a hit of the evolution.
>
Please forget about that, it's included in each patch :)

 - Arnaud
