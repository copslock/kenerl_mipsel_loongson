Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2010 20:15:47 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:62267 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492048Ab0JCSPn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Oct 2010 20:15:43 +0200
Received: by wwe15 with SMTP id 15so1404937wwe.24
        for <multiple recipients>; Sun, 03 Oct 2010 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7kaYeLnWNk4mV3KhMb5mIc5FX7CIKUJk6PTjIjK9pQA=;
        b=ir5Cu51+CYPQODTV68NShqT9YKr2DK43St1ol79nsmKESvQuyPnbVH9NN2c2y1hG9/
         puIvpTaq7aAsSwiOuCis2mLrkM0vJF9YuZuTES/DyfXoHTSYpnYlJCTsT0qdtuw4HMdm
         ef/2BqRjpx7qXkhbbPWVcxre9oOHclhoGXuZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WXHm9LqLqhQSWLUxNj8fo+mJjjaJ71Q6nUnXgsIXZes1Fwyo+JRlXosyERsZ/ykJAH
         ITDtLjM0AWvp8HY1VQvjfVA1yvhEmqRSlkH2jTriy+bi3C8pQKBZIL0+exopzRNGoaT+
         airncLhbiivCHigcC4aNlZrV+1Dg0uOU2D0mA=
MIME-Version: 1.0
Received: by 10.227.155.193 with SMTP id t1mr7390912wbw.8.1286129737505; Sun,
 03 Oct 2010 11:15:37 -0700 (PDT)
Received: by 10.227.43.201 with HTTP; Sun, 3 Oct 2010 11:15:37 -0700 (PDT)
In-Reply-To: <1285697432-29244-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285697432-29244-1-git-send-email-ddaney@caviumnetworks.com>
Date:   Sun, 3 Oct 2010 23:45:37 +0530
X-Google-Sender-Auth: kiWWaVS6GTLpwKbUcfxjlYqiG-4
Message-ID: <AANLkTimEJQE3i9Wa1X=Rkw1goJA9c5Sso-iWV=hLG6KF@mail.gmail.com>
Subject: Re: [PATCH] jump label: Add MIPS support.
From:   Rabin Vincent <rabin@rab.in>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        jbaron@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <rabin.vincent@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin@rab.in
Precedence: bulk
X-list: linux-mips

On Tue, Sep 28, 2010 at 11:40 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> +void arch_jump_label_text_poke_early(jump_label_t addr)
> +{
> +       union mips_instruction *insn_p =
> +               (union mips_instruction *)(unsigned long)addr;
> +
> +       insn_p->word = 0; /* nop */
> +       flush_icache_range((unsigned long)insn_p,
> +                          (unsigned long)insn_p + sizeof(*insn_p));
> +}

Can't this function be a no-op on MIPS?  This seems to be
used on x86 to patch in the optimal nop instruction, but
on MIPS the optimal/only nop instruction should already
be in place at build time.  Same thing for the SPARC
implementation.

Rabin
