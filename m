Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 22:12:36 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:36283
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbdFAUM2wU2bZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 22:12:28 +0200
Received: by mail-qt0-x242.google.com with SMTP id j13so7092491qta.3
        for <linux-mips@linux-mips.org>; Thu, 01 Jun 2017 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/G0rPEhB+CCPgI0rXPLmT5Qwkw+LnImMW2feqffCV/U=;
        b=Lsq1f10RCcwOPXbJK7jst9kimnrGd6chEhFyqjWdJREX8KpxbdkyaOPOFD6wN+ppsc
         MA/Vve+Fus9nBmdMtFn1kPhCNtNAF483aHnfnREdBuqx0L1e4DUHaLOP/xlIaMaehB/C
         LhVLj5DWjtmzSA9v5HMiMofPS/a9sVN7CcEyd9Kw4svjmK3bn3ewvEkAM7wNUMhP0cfw
         Nmc7TN84fw22cCBBhigEq4Duqkm7p7geAH9XFenIDZGNnTLmsBJVkS7nyi287Hi5PzEg
         QPyT49ldoSop0xcfQVYIOVM/8Z+SAxZEcWmQAOEFyO2+9qlV/WmmNR5LjLpWt4m50alv
         ELFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/G0rPEhB+CCPgI0rXPLmT5Qwkw+LnImMW2feqffCV/U=;
        b=ElVF8A9OiMUS+Ie+g9kX239+NLvE3SZO6e4famA19GQPdtxXSI0scM0hIeahhqJtw2
         OXoIs7FHh9FmpdXiMmWkIU+gIOG+ziGkpGNSzcqXkVo7O9QDSiUns4BNac6JYkxvUlpM
         pUL0vmsW2lmk/F54wTvu7JF/Y5R+at1076vh8x0dGNzruVyGoiUxByR7o0aE9l/8UmNI
         L7qvq/Q+WX4wP1OioxRWEZdX1zkYfzdxvuANBCPCfypedON64i0r6ZLgV9wjrnxsNd3B
         L0/tOS56gz2AzM7OjhhHnisIFzOGz5wVwQzfpJUlcruUe4Rs4V365ktXjU2lBSaYpURy
         Ozeg==
X-Gm-Message-State: AODbwcDXWjDzCuGlW++XiZBdQMpwzk9PrwMe1lafSNJyp/Lk/EQKTTmD
        aPWM5R081uAYCQ==
X-Received: by 10.200.55.98 with SMTP id p31mr4077395qtb.64.1496347943110;
        Thu, 01 Jun 2017 13:12:23 -0700 (PDT)
Received: from bigtime.twiddle.net (cpe-98-155-27-246.hawaii.res.rr.com. [98.155.27.246])
        by smtp.googlemail.com with ESMTPSA id w205sm7851057qka.67.2017.06.01.13.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 13:12:22 -0700 (PDT)
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
To:     Aleksa Sarai <asarai@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
References: <20170601173803.8698-1-asarai@suse.de>
 <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
 <a0671efc-4c4e-bbdc-c9d8-a7bdc22b872a@suse.de>
From:   Richard Henderson <rth@twiddle.net>
Message-ID: <4e16e83b-8fb7-c9b6-2f06-ee48499a67db@twiddle.net>
Date:   Thu, 1 Jun 2017 13:12:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <a0671efc-4c4e-bbdc-c9d8-a7bdc22b872a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rth7680@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
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

On 06/01/2017 01:00 PM, Aleksa Sarai wrote:
>>> --- a/arch/alpha/include/uapi/asm/ioctls.h
>>> +++ b/arch/alpha/include/uapi/asm/ioctls.h
>>> @@ -94,6 +94,7 @@
>>>   #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>>>   #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
>>> pty-mux device) */
>>>   #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
>>> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */
>>
>> Shouldn't the list of definitions be kept sorted, by hex number?
>> (everywhere)
> 
> Probably. The reason I put it here is because it logically is very similar to 
> TIOCGPTN and TIOSPTLCK, but I can move it if the hex order is more important 
> for maintainence.
> 

Yes please.


r~
