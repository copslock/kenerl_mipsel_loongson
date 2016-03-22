Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 03:51:32 +0100 (CET)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33557 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014261AbcCVCvbDhi4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 03:51:31 +0100
Received: by mail-pf0-f178.google.com with SMTP id 4so158328809pfd.0
        for <linux-mips@linux-mips.org>; Mon, 21 Mar 2016 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=20tUYjTCIrtphhvt4Vm6HTSoZYazhQG00QBNBxKE/Wk=;
        b=SSkHPYsnwUIIaNBd726zv+fqaR+icHDSWFpQAmYKsYGnvnktgWqo6/6DazQvEkmonA
         zvOOvdqK7pjtcIcae4ahOOEX8E8vEgIFb0/2VK5EeeKi5j9ZoCWLSA8gDrCgsOfJHixy
         C4ss6CY8xLy2Z0zzXMPuDtFGQyhYHI//EqJlFP+VFrR4iINEwG8QS/hgkv6HIWz6QhQK
         9xxPs0mdZZTR9DhZ1AVmhpq0aHkrmEEHvEtyjKngGVSo8bfhmtQxD9fHP2+TfF2YWv9m
         EV2s3WoUcI4baZd3JNIE7jyQJwz36jF14Evyw0+wxMtr/cVUH9ux3wZphw6YC3VdxiXN
         qkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=20tUYjTCIrtphhvt4Vm6HTSoZYazhQG00QBNBxKE/Wk=;
        b=jreuv2R9ZxXxcoGj3TtgCrQq1cGAlFd4O9CVyb2Pc88fRK/mH6A+5ntNg6mqCkUexZ
         6Jsu3wq1XRzakuZ3Y4ITApHuzbobRd5u+uJEkWolblGJIDKiD5ctFVkYw/aXJgdimMAZ
         bWHxJ/4EcHj9cKnCxF8uFICymVTU/oXqd2GsyjvJ2LiVxA/WYfnHLHZJtghRIes44h2j
         piCSk0DNlgl1woqqqFZHinwNr3AYQD3/5e4hG6DlFh5QXYT3MA+sSqoJtLPV1tcr2x4T
         i5YYnI0temBAojgkZpcwv1p8yQiqBqe69iwc7/Y2/ccPG0tcCJ7WTYvVU+bJS/QqrT/B
         oYEw==
X-Gm-Message-State: AD7BkJJMJiJtVTDlVU7e64w4xGwb0qoS0Kpj1cQTogVO0zQOAJyBV7KQtZ1tc0Fgf/X2GA==
X-Received: by 10.98.33.203 with SMTP id o72mr50636258pfj.96.1458615084994;
        Mon, 21 Mar 2016 19:51:24 -0700 (PDT)
Received: from [192.168.1.20] (50-1-116-74.dsl.dynamic.fusionbroadband.com. [50.1.116.74])
        by smtp.gmail.com with ESMTPSA id 3sm43759667pfn.59.2016.03.21.19.51.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 19:51:24 -0700 (PDT)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Matthias Schiffer <mschiffer@universe-factory.net>,
        Greg KH <gregkh@linuxfoundation.org>
References: <56F07DA1.8080404@universe-factory.net>
 <20160321230821.GA17910@kroah.com> <56F0975A.7050609@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, jslaby@suse.com,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F0B329.30506@hurleysoftware.com>
Date:   Mon, 21 Mar 2016 19:51:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F0975A.7050609@universe-factory.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 03/21/2016 05:52 PM, Matthias Schiffer wrote:
> On 03/22/2016 12:08 AM, Greg KH wrote:
>> On Tue, Mar 22, 2016 at 12:02:57AM +0100, Matthias Schiffer wrote:
>>> Hi,
>>> we're experiencing weird nondeterministic hangs during bootconsole/console
>>> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
>>> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
>>> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
>>> QCA953x likewise.
>>
>> Can you try 4.4 or ideally, 4.5?  There's been a lot of console/tty
>> fixes/changes since the obsolete 3.18 kernel you are using...
>>
>> thanks,
>>
>> greg k-h
>>
> 
> With 4.4, I was not able to reproduce this hang, but I have no idea if this
> is caused by an actual bugfix, or just random timing changes hiding the
> bug.

Can you continue testing with 4.4.x and see if it eventually reproduces?


> I suspect the latter might be the case (as I wrote in my first mail,
> even minor differences in kernel images of the same version and the same
> config make the hang more or less probable.) I was not yet able to test
> 4.5, as OpenWrt is a hell of kernel patches...
> 
> On 3.18, I also tried other things like disabling the early console
> altogether, which also made the hang go away, but as even much smaller
> changes hid the bug, this doesn't really say much.

FWIW, printk() is not a small change; takes ~500us @ 115200


> 
> The basic code path during the console handover seems to be the same in
> 3.18 and 4.4, even though a few functions have been moved; the relevant
> part of the log looks the same:
> 
>> [    0.756298] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
>> [    0.766754] console [ttyS0] disabled
>> [    0.790293] serial8250.0: ttyS0 at MMIO 0x18020000 (irq = 11, base_baud = 12500000) is a 16550A
>> [    0.798909] console [ttyS0] enabled
>> [    0.798909] console [ttyS0] enabled
>> [    0.805854] bootconsole [early0] disabled
>> [    0.805854] bootconsole [early0] disabled
> 
> So, in propect of an actual bugfix or backport, this boils down to two
> questions, which I hope the serial or MIPS maintainers can answer me:
> 
> * Is it sane to have two console drivers using the same serial port? In
> particular, is it sane for the early console to use the serial port after
> serial8250_config_port has reset/configured it, but before the rest of the
> setup of uart_configure_port has run? (this would be the case for the
> message "serial8250.0: ttyS0 at MMIO...")
> * Is it possible to get the serial controller into a state in which
> early_printk might wait for THRE forever?

I think I addressed these questions in my other reply; let me know if not.

Regards,
Peter Hurley
