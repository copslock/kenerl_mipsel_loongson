Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 21:34:09 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:45894 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903657Ab2CFUdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2012 21:33:53 +0100
Received: by ghbf11 with SMTP id f11so2765612ghb.36
        for <multiple recipients>; Tue, 06 Mar 2012 12:33:47 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.60.4.106 as permitted sender) client-ip=10.60.4.106;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.60.4.106 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.60.4.106])
        by 10.60.4.106 with SMTP id j10mr9743044oej.47.1331066027145 (num_hops = 1);
        Tue, 06 Mar 2012 12:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5ABuA5uQ3aS3SpgjTH4heFBWxsxfvaTPNSJAg3xjWYg=;
        b=nbHIo2Wig7ojbruPhzlNGXgtIVfN8dWhhuCWxVr/IF/8EXnfPJ4repAaonxE/275zE
         io63HM+huhCRHQtR7EUucvE8zO+coAu3SnypJiYP2yLMP7LxEZ4ADpgweFXhJVSFw4/3
         4Nf4zu4YQSfDmQf4ThBVVhTDAcvru9/S1LATyZF/ofC3DcwowBVoZquP3isEPZQRi+pS
         MpzoR04LPVMsCLXut5N9MVTomq3VZw84cYa7OrLSiTHOToAW6OvvDyOZ4QkkBSjXVtYs
         3sc8TUK39YiyDhAThgu62ewnE62uHY/FIbo9W7JVl8gBEEY6CilChsZC+i2YpQHBxsu3
         pGEA==
Received: by 10.60.4.106 with SMTP id j10mr8581465oej.47.1331066027111;
        Tue, 06 Mar 2012 12:33:47 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id n1sm1088988oen.8.2012.03.06.12.33.45
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 12:33:46 -0800 (PST)
Message-ID: <4F5674A8.3040605@gmail.com>
Date:   Tue, 06 Mar 2012 12:33:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Florian Fainelli <ffainelli@freebox.fr>, loody <miloody@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some questions about mips timer
References: <CANudz+ugY7NfCSGh-_kS4pzC91p02ZtYpxXMdCOKsM+spAt37g@mail.gmail.com> <160192556.459513.1331042510355.JavaMail.root@zmc> <20120306202712.GM4519@linux-mips.org>
In-Reply-To: <20120306202712.GM4519@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/06/2012 12:27 PM, Ralf Baechle wrote:
> On Tue, Mar 06, 2012 at 03:01:50PM +0100, Florian Fainelli wrote:
>
>>> hi all:
>>> I have some questions about mips_hpt_frequency:
>>> 1. is mips_hpt_frequency == mips cpu frequency?
>>
>> No, it is usually cpu frequency / 2.
>
> The architecture specification leaves the counter clock rate up up to the
> implementation and only says the clock rate is a function of the pipeline
> clock.  In all reality this means the counter is running at the full or
> half frequency.  Just don't build on it,
>
>    clock := pipeline_clock * next_weeks_lottery_number % 42
>
> would by compliant ;-)
>
> On some CPUs the frequency can even be selected through a configuration
> bitstream at reset time so you can't always count on a fixed relation
> between CPU clock and count rate.
>
> Some older CPU manuals contain a confusing wording saying the counter
> increments at half (or full) instruction issue rate.  That just means the
> pipeline clock, no reason to be confused.
>

If you have a v2 or later ISA, you can use 'rdhwr x, $3' to find the 
ratio between the clock rate and the increment rate of the timer.

David Daney
