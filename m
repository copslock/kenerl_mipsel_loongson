Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 08:42:05 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:39183 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab1CXHmC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Mar 2011 08:42:02 +0100
Received: by wyb28 with SMTP id 28so9365552wyb.36
        for <multiple recipients>; Thu, 24 Mar 2011 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E3I4ml9vtM1INtAatwlgUe5Q8kG4zTO6VPBX2qwMq+w=;
        b=DAjlQs6Ofm5hQDcqJTWvZ/6vRMHBjRf1YR+m8HOoH1M7VrTN+QvQYeSnTn8jXtwwh/
         U61pYf9DsbZTEAvX35JhMj4AW9pCgQ7Cfw4w5S4XO5QWfw0gVyym8oIdi2bKeEnoreql
         7K5TlN3cC2lGBubdV1sgvf9WV1dEY7sCsbVtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RzViNRi00xFqyarmBY9N1vqMujXuTvAlZstSdXuT/WFB80WQmmaf6mDTF7sP3xi5bL
         0/4V/QL6a5EaJINEVepccUtYV+W1kKJhd6iMB85eGCwq+44pt2sjVYc7P/1/QpR9xq+R
         k1k/NwOGoSTmFfA9TDC05EfoFuX0U0qIFuslQ=
MIME-Version: 1.0
Received: by 10.216.79.13 with SMTP id h13mr389551wee.25.1300952516807; Thu,
 24 Mar 2011 00:41:56 -0700 (PDT)
Received: by 10.216.242.142 with HTTP; Thu, 24 Mar 2011 00:41:56 -0700 (PDT)
In-Reply-To: <20110323210534.669706549@linutronix.de>
References: <20110323210437.398062704@linutronix.de>
        <20110323210534.669706549@linutronix.de>
Date:   Thu, 24 Mar 2011 08:41:56 +0100
Message-ID: <AANLkTimkSzuTu6AWij=T_J7W6KTTjB6BBTOyTLcxi_Kq@mail.gmail.com>
Subject: Re: [patch 01/38] mips; Convert alchemy to new irq chip functions
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 23, 2011 at 10:08 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Fix the deadlock in set_type() while at it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/alchemy/common/irq.c     |   98 ++++++++++++++++++-------------------
>  arch/mips/alchemy/devboards/bcsr.c |   18 +++---
>  2 files changed, 59 insertions(+), 57 deletions(-)

Tested on the db1200, works fine.

I'm curious though: could you please elaborate on where the deadlock came from?
Is it not safe to call set_irq_type() at all times?

Thanks!
        Manuel Lauss
