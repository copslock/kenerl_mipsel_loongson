Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 16:51:28 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:63999 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492277Ab0GNOvX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jul 2010 16:51:23 +0200
Received: by iwn40 with SMTP id 40so8154892iwn.36
        for <linux-mips@linux-mips.org>; Wed, 14 Jul 2010 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pu+dsbSQ5v0oxZT9ATrYOwSHfziavA9IPn0ecEoRYzE=;
        b=CvVnKnb77YMmDy7zFqOfxD7FDfEioSbojzONmnxPWGmWAiwdToEiAA4jFm/3dbeywC
         5FafCmL9/ldMkpmUxGQs/ahP76/9sIUGmu9tDvSfzpJNPBFiIFpqSxUOXkd6fVBMkQRf
         Aa6jxwizGEY4F0+9l7Uuxnhu99Wj1QJXFFGDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JAHR7qm/rxvybzhzh39YlIxEBOccaE7Y59IPs6GzhyV4ahFVRhd5K4YJlvlC8K7lO5
         8Y63ljcXIKCKsiZXfhPYTCI7ENOBNY2lQlLTf8AZLt6P/Pz+JByDzwHssdLFglY7Aajp
         El0Nw+Yxvsrdxc6D0krWxsR7YrQEH15i8XyGs=
MIME-Version: 1.0
Received: by 10.231.178.103 with SMTP id bl39mr16190985ibb.138.1279119078097; 
        Wed, 14 Jul 2010 07:51:18 -0700 (PDT)
Received: by 10.231.182.207 with HTTP; Wed, 14 Jul 2010 07:51:18 -0700 (PDT)
In-Reply-To: <1279115243-11586-1-git-send-email-wg@grandegger.com>
References: <1279115243-11586-1-git-send-email-wg@grandegger.com>
Date:   Wed, 14 Jul 2010 16:51:18 +0200
Message-ID: <AANLkTilwt8Eh9on0tjXecINx28ix1Bky8GiS-E4QdyIJ@mail.gmail.com>
Subject: Re: [PATCH v2] mips/alchemy: add basic support for the GPR board
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2010 at 3:47 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> diff --git a/arch/mips/alchemy/gpr/board_setup.c b/arch/mips/alchemy/gpr/board_setup.c
> new file mode 100644
> index 0000000..4e68d76
> --- /dev/null
> +++ b/arch/mips/alchemy/gpr/board_setup.c

> +static int __init gpr_init_irq(void)
> +{
> +       return 0;
> +}
> +arch_initcall(gpr_init_irq);

Seems superfluous.  Do you intend to add something here in the future?

Otherwise looks ok to me.

Thank you!
        Manuel Lauss
