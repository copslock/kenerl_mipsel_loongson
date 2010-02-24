Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 08:57:36 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:55671 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491081Ab0BXH5d convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 08:57:33 +0100
Received: by fxm9 with SMTP id 9so4389223fxm.24
        for <multiple recipients>; Tue, 23 Feb 2010 23:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uGFMpDbdZRaN18E8k0xrRyk3nVKkQsYp2F+Q7c/S1fU=;
        b=TfKONCdIAliI/ld+q5MNB4axkpyus85eqcDcES8TPALmiIbLYwtiVxzfQSoFUutopP
         yla7zNe/WH+CUGnrtVE1cvBbbSrWEYC41wMvrlrzfrRynUXHYmnuh0Nul7qmO8EGhYpU
         x55CbvpaBf2psyavgXKC1xqLNlai+xvHvUwmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jEuInILtwud5a3u5ujq7mefSlIrwDpgajdM/WctomZRwaF4fOJBtNVOPsWoUsgZpF4
         0grbRKxm5v8tFjTXspdrROeg2tIZk2yspRj8q3Yn0wk5rld2QpWIuGD68PbLB+JMtOD8
         h7V/9pX9M8Nn1jdoKf2qNh+iZeUkwKT+VzRTI=
MIME-Version: 1.0
Received: by 10.223.100.216 with SMTP id z24mr8117950fan.5.1266998247652; Tue, 
        23 Feb 2010 23:57:27 -0800 (PST)
In-Reply-To: <20100223230618.GD21949@linux-mips.org>
References: <1266956534-24753-1-git-send-email-manuel.lauss@gmail.com>
         <20100223230618.GD21949@linux-mips.org>
Date:   Wed, 24 Feb 2010 08:57:27 +0100
Message-ID: <f861ec6f1002232357l112e2396qd063fd1c1bbdb46@mail.gmail.com>
Subject: Re: [PATCH -queue v2] MIPS: Alchemy: use 36bit addresses for PCMCIA 
        resources.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 12:06 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Feb 23, 2010 at 09:22:14PM +0100, Manuel Lauss wrote:
>
>> On Alchemy the PCMCIA area lies at the end of the chips 36bit system
>> bus area.  Currently, addresses at the far end of the 32bit area
>> are assumed to belong to the PCMCIA area and fixed up to the real
>> 36bit address before being passed to ioremap().
>>
>> A previous commit enabled 64 bit physical size for the resource
>> datatype on Alchemy and this allows to use the correct
>> 36bit addresses when registering the PCMCIA sockets.
>>
>> This patch removes the 32-to-36bit address fixup and registers the
>> Alchemy demoboard pcmcia socket with the correct 36bit physical
>> addresses.
>>
>> Tested on DB1200, with a CF card (ide-cs driver) and a 3c589 pcmcia
>> ethernet card.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Thanks, queued for 2.6.34.

Please drop this one for now, I forgot to change the XXS1500 board
and driver code.  I'll resend an updated version.

Thanks,
     Manuel Lauss
