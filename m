Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 13:27:48 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:40437 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491152Ab1FUL1p convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2011 13:27:45 +0200
Received: by pvh11 with SMTP id 11so3827774pvh.36
        for <linux-mips@linux-mips.org>; Tue, 21 Jun 2011 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F82Ke0wU7JWkYSI1Ehq5DJbNDj1RBbN+pdbxuN/p2po=;
        b=IbMNXwJWhKrJO/Y5rv28v8TlI+15CBPUzpqgstz7DT1wCCq+kqzju48iOnM9w9Vo/h
         /MU4aIO6QUyVg4Th4uV+Y1TRcsQg5mQpIgAZHw2lOfyQUcxwpmDpzfsr2WoKeGdYwAx2
         2Cul2tCgX5+idQcM38nDDhxVI2OYURjaO4Gy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Idpn1tMNyd5pZgEwRPKJU+OC8HkE9MU826H8iu57vdvjH6F2e27vnuL92vDcCojJjQ
         c784J+BCiWZE/ukW1sYMRAMGQys6ePQWTeK7olvRRPcpkk8DHvV0uTfzupJjA6DOvSru
         aiT4NTP84yw5Zmieso8C8IAixIxbSQsD2RH3M=
MIME-Version: 1.0
Received: by 10.68.52.4 with SMTP id p4mr2606055pbo.127.1308655658419; Tue, 21
 Jun 2011 04:27:38 -0700 (PDT)
Received: by 10.68.46.194 with HTTP; Tue, 21 Jun 2011 04:27:38 -0700 (PDT)
In-Reply-To: <4DFFBB6D.4030607@hauke-m.de>
References: <1308520209-668-1-git-send-email-hauke@hauke-m.de>
        <BANLkTim5R1ukc5OJQRRpF6EsmzeoL=SUoA@mail.gmail.com>
        <4DFFBB6D.4030607@hauke-m.de>
Date:   Tue, 21 Jun 2011 13:27:38 +0200
Message-ID: <BANLkTimaSJB6a2Y5DxHiLm3QLWSfsXJiNQ@mail.gmail.com>
Subject: Re: [RFC v2 00/12] bcma: add support for embedded devices like bcm4716
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17083

W dniu 20 czerwca 2011 23:28 użytkownik Hauke Mehrtens
<hauke@hauke-m.de> napisał:
> On 06/20/2011 02:41 AM, Rafał Miłecki wrote:
>> Hey Hauke,
>>
>> 2011/6/19 Hauke Mehrtens <hauke@hauke-m.de>:
>>> This patch series adds support for embedded devices like bcm47xx to
>>> bcma. Bcma is used on bcm4716 and bcm4718 SoCs. With these patches my
>>> bcm4716 device boots up till it tries to access the flash, because the
>>> serial flash chip is unsupported for now, this will be my next task.
>>> This adds support for MIPS cores, interrupt configuration and the
>>> serial console.
>>>
>>> These patches are based on ssb code, some patches by George Kashperko
>>> and Bernhard Loos and parts of the source code release by ASUS and
>>> Netgear for their devices.
>>>
>>> This was tested on a Netgear WNDR3400, but did not work fully because
>>> of serial flash.
>>>
>>> This is bases on linux-next next-20110616, to which subsystem
>>> maintainer should I send these patches later, as it is based on the
>>> most recent version of bcma and bcm47xx?
>>> I do not have any normal PCIe based wireless device using this bus, so
>>> I have not tested it with such a device, it will be nice to hear if it
>>> is still working on them.
>>> The parallel flash should work so it could be that it will boot on an
>>> Asus rt-n16, I have not tested that.
>>
>> I'm glad you are still working on it!
>> Unfortunately it's really late right now and I'm leaving tomorrow
>> (well, today as we passed midnight) for the whole week :( I'm not sure
>> if I'll get a chance to review this, not to mention testing against
>> any of my PCIe card.
>
> No problem have a look at it when you find some time for it. There are
> still some todos and the serial flash chip is also on my list, so I will
> not run out of stuff to do. ;-)
>
>>
>>> An Ethernet driver is not included because the Braodcom source code
>>> available is not licensed under a GPL compatible license and building a
>>> new driver on that based is not possible.
>>
>> I wonder if you could write specs for that core, so I could write
>> GPL/any driver for it? Is that driver really big?
>>
> Now I think this will be the fastest solution. Henry Ptasinski from
> Broadcom wanted to make it possible for us to use the Braodcom driver
> directly as a base, but talking to all the lawyers and managers at
> Braodcom to make this possible takes a lot of time and is not promising.
> After this and flash support is in the kernel I will work on the
> Ethernet driver.

They are looking for releasing firmware for other PHYs for months now, so... ;)

-- 
Rafał
