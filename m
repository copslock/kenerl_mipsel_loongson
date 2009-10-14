Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 13:17:30 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44758 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492384AbZJNLRY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 13:17:24 +0200
Received: by fxm21 with SMTP id 21so9299879fxm.33
        for <multiple recipients>; Wed, 14 Oct 2009 04:17:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QCcnVCVBY+Y30cDAW5KRuzbV4qKDIwPaUCwOTZwfOR0=;
        b=pbp/DQasVxHhC867G1nHDyP7Bf7TE+gZ90NIJHd7PaoXVUZ0wk5HthyjbwuUz6rYzf
         zCNusRsocNmpbOM9xS0f+w/28WgrR1d5OrRXDfATtPvx6LCrNcXmvBfFVyBswHvn6PZV
         YNTOOPVJMkb7zjbBsFEjj1pWZjiDjGH7PcpNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nVRo8dSIw9IPW0Zsr9P6mXXP5MWZbr6vWDqIxmZ5rhqRlDgZPm17Lz6iIwoj/fYFX5
         TFQLOjVZiClfaBmZt1ncRh6nWis3oZArXdV4J77oSJ6wKEC5B8mSeebeyF9kIM9hGNPq
         U2Smyycaj+8g1fPUc0t4KGlVASe2hNIbS5p4c=
MIME-Version: 1.0
Received: by 10.223.4.84 with SMTP id 20mr2103042faq.97.1255519038348; Wed, 14 
	Oct 2009 04:17:18 -0700 (PDT)
In-Reply-To: <1255518712-14666-1-git-send-email-wuzhangjin@gmail.com>
References: <1255518712-14666-1-git-send-email-wuzhangjin@gmail.com>
Date:	Wed, 14 Oct 2009 13:17:18 +0200
Message-ID: <f861ec6f0910140417k5ce4a7e8tbe3ca64c0c0e0aeb@mail.gmail.com>
Subject: Re: [PATCH] MIPS: zboot: make the vmlinuz be fresh all the time
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 1:11 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> Manuel Lauss have reported:
>
> "when I change the compression type in a built tree, the compressed/ directoryy
> doesn't get rebuilt and a stale vmlinuz remains"
>
> This patch fixes it.

Works perfectly, thank you!
     Manuel Lauss
