Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 19:43:13 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:63483 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491876Ab0KDSnK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Nov 2010 19:43:10 +0100
Received: by iwn8 with SMTP id 8so1636268iwn.36
        for <multiple recipients>; Thu, 04 Nov 2010 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=MqwrLWR/RP2KyKNgJBo8btO05YQs+f0OejXSwDZyay4=;
        b=hCUl/HOPRa9yxNCrjpAbY+loNYSw2mwi5rsVW/9qxFOQ8xMJl+f9M8JXIGE9uP6dkz
         7NWkriVO4EQcWN92itE+rFKSxenPe+dY8AYKYFv+EyI2i5j0wb1wGsdSK3VrXh/e8H5x
         TzszpOo0p39Tx6Wg5m6qjLh/TqJGQaMIsAM4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=HdKjJ9k5xevNUHqbDRqEM16kfaxzuPIPa0+z/TF+9RtC08mV9hBkPzfiHLRyzDavVv
         7jcW2KdRHRy8GZTum41vHEsEHp4RC1LTZuq4hEiyMANSiChgENYDeCQ4jPoXhl09T2u4
         NPKgxztg+018fWrEmPLeYegXZcfi/woOtW+Jc=
MIME-Version: 1.0
Received: by 10.231.14.74 with SMTP id f10mr895344iba.185.1288896188394; Thu,
 04 Nov 2010 11:43:08 -0700 (PDT)
Received: by 10.231.170.70 with HTTP; Thu, 4 Nov 2010 11:43:08 -0700 (PDT)
In-Reply-To: <4CD2EE64.5060404@aurel32.net>
References: <1288873119.12965.1@thorin>
        <4CD2E2F7.4090701@caviumnetworks.com>
        <4CD2EE64.5060404@aurel32.net>
Date:   Thu, 4 Nov 2010 19:43:08 +0100
X-Google-Sender-Auth: rK2MWbYORQ1uzP74w3hbb-j-Re4
Message-ID: <AANLkTik3SH8EmhcgY9HNQLLk9Np+E6LGo8jVoGQiQCx4@mail.gmail.com>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
From:   Robert Millan <rmh@gnu.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

Hi!

David Daney a écrit :
> You are claiming that all loongson2 are loongson-2f.  Is that really
> true?  Or are there other types of loongson2 that are not loongson-2f?
>
> You need to be very careful here.  This is part of the userspace ABI, so
> if you get it wrong, you are stuck with it forever.

I'll figure out how to distinguish them and send a new patch.

> One question you didn't address is why userspace would care that it is
> running on exactly "loongson-2f" instead of just mips4.

I think Aurelien answered this.

> The __elf_platform gets converted to a directory name by ld.so, so you
> may want to choose a value without '-' in it.

Well I appreciate consistency with GCC flag names, so I'd rather keep
the dash, but then again it's not my decision to make.  In any case,
whoever commits this can adjust the name to his/her liking.

-- 
Robert Millan
