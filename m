Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:44:16 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:39154 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493483AbZKCPoK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:44:10 +0100
Received: by bwz21 with SMTP id 21so7688305bwz.24
        for <linux-mips@linux-mips.org>; Tue, 03 Nov 2009 07:44:04 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BPnXrtba1op9PgX6J67aioR/EHyQACTTM+I2iV5SZlk=;
        b=Ix2jOsgZygauOCmMmd1m4uiCzFFekGg+nLfdwglUiXvoqblkiVa+hACMDXfz+Mk5kT
         wT6vpMPf/pWz8vg9yosK17MKv90VYBznBJUEY4zQh7eEcA9NJxisGYnpJYXDeIZ+S/mp
         AtyxFHBjyPv5jf9wrZNhdy/W3am7hSfIt4ct4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IEgSi5c2artJgbcOtNuvNdMPlxuKmqAuVt2x/X3If5G7ljO3oOdl/0mqkXKbQlZXyE
         E7SMyrb1kHqxLUn+pPZi6ZYxL0zdeWMGftlV0gemLKy5hf4I7aPDob8ozNMHtDozM9q+
         +DOGP0HtoISZp00wdcJUX0pV+8TGuVYooQtwk=
MIME-Version: 1.0
Received: by 10.223.161.212 with SMTP id s20mr27413fax.2.1257263044844; Tue, 
	03 Nov 2009 07:44:04 -0800 (PST)
In-Reply-To: <1257262863.29642.8.camel@localhost>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	 <1257262863.29642.8.camel@localhost>
Date:	Tue, 3 Nov 2009 16:44:04 +0100
Message-ID: <f861ec6f0911030744j13fa9487p857c49a68d43adfe@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] MIPS: Alchemy: extended DB1200 board support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Kevin Hickey <khickey@netlogicmicro.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 3, 2009 at 4:41 PM, Kevin Hickey <khickey@netlogicmicro.com> wrote:
> On Mon, 2009-11-02 at 21:21 +0100, Manuel Lauss wrote:
>> Create own directory for DB1200 code and update it with new features.
>>
>> - SPI support:
>>   - tmp121 temperature sensor
>>   - SPI flash on DB1200
>> - I2C support
>>   - NE1619 sensor
>>   - AT24 eeprom
>> - I2C/SPI can be selected at boot time via switch S6.8
>> - Carddetect IRQs for SD cards.
>> - gen_nand based NAND support.
>> - hexleds count sleep/wake transitions.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>
> The code in this patch all looks good to me.  I don't understand how
> much value is added by using the hex LEDs for counting sleep/wake
> transitions.  In our internal builds, we use the hex LEDs for displaying
> the last interrupt serviced (useful on hangs/crashes and for getting a
> general sense of what the hardware is working on), the dots blink on
> timer ticks (often every 100 or 1000 depending on the clock) and the
> Idle state is shown on LED0.  I don't really have any strong attachment
> to those usages, but they've served us well.

I admit it has limited value.. I initially used it to find out how many wakeups
per second are happening with and without high-speed usb devices attached.
I left it in because I couldn't come up with any other uses.  Please feel free
to change it any time.

Manuel
