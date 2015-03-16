Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 23:02:52 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33498 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008511AbbCPWCtw0Jrj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 23:02:49 +0100
Received: by ignm3 with SMTP id m3so41435882ign.0
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k14+HuyAiU2u36l/xhqQTOUrthVdrXu6Yv3ibZfnhU8=;
        b=ctVIarvxLmXZeGvebEslvBHt9LnJPVCFGCPZU+LfchOFHAUhC4A3kh4fsZkkMzGme/
         FoTmz9cpoKnoeHm2/IJZItRIQd1iCKaTz/8Kg1NtSpOUjvv+o8PN2DX0511AnxQCwH8D
         Nr0Lg0gE08BCY4DUCbML8vsmOMbGFkJG3xWXIEvwuQYw7ojI6NBxjnzrNHoNB6O+DPjV
         IhSpCvzVyBQGJG3br85YvPa1dp3dQEB1ZSty5VXz71qD8+7Bf6oz5r3Cm+PkZ0WAVNfZ
         KFLuzfZw9FxXw7djrVuoLysJQGjofKTf6PlW7iYawhGlmZhTV4270nvrqf1XG/7TKGBS
         tTQQ==
X-Received: by 10.50.78.9 with SMTP id x9mr139441997igw.44.1426543364950;
        Mon, 16 Mar 2015 15:02:44 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id qd2sm7528532igc.22.2015.03.16.15.02.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Mar 2015 15:02:44 -0700 (PDT)
Message-ID: <55075302.5040904@gmail.com>
Date:   Mon, 16 Mar 2015 15:02:42 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: OCTEON: Patches to enable Little Endian
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk> <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi> <20150316103939.GA28205@paulmartin.codethink.co.uk> <20150316192704.GC586@fuloong-minipc.musicnaut.iki.fi> <550732B2.6020104@gmail.com> <20150316211032.GD586@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150316211032.GD586@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/16/2015 02:10 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Mar 16, 2015 at 12:44:50PM -0700, David Daney wrote:
>> On 03/16/2015 12:27 PM, Aaro Koskinen wrote:
>>> On Mon, Mar 16, 2015 at 10:39:40AM +0000, Paul Martin wrote:
>>>> On Fri, Mar 13, 2015 at 08:52:58PM +0200, Aaro Koskinen wrote:
>>>>> On Fri, Mar 13, 2015 at 05:34:52PM +0000, Paul Martin wrote:
>>>>>> Octeon II CPUs can switch from Big Endian to Little Endian freely
>>>>>> even in kernel/supervisor mode.
>>>>>
>>>>> You are enabling it on all OCTEONS. Is that valid? At least octeon-usb
>>>>> still needs to be fixed for little-endian mode.
>>>>
>>>> The USB works perfectly with the patches that were posted to this list
>>>> over the last couple of months.
>>>
>>> I was referring to driver for OCTEON+ USB controller in staging.
>>> ERPro uses EHCI, so it's different. Anyway, I can try to fix the most
>>> obvious issues myself e.g. bitfields.
>>
>> OCTEON Plus CPUs (i.e. those with afore mentioned USB controller) don't
>> really support Little-Endian operation, so it may not be worth doing
>> anything with that driver.
>>
>> There are several problems:
>>
>> 1) The system bootloader (u-boot) must have support for booting
>> Little-Endian.  EdgeRouter LITE doesn't have the proper support.  In theory
>> you could write a LE booting shim, but I am too lazy to explain what it must
>> do...
>
> Would it be possible to support kexec from BE kernel ==> LE kernel?
>

In theory it would.  This is essentially the LE booting shim idea:

1) Scramble up memory contents and certain data structures normally 
supplied by the boot loader to be in Little Endian access order.

2) Switch CPU to Little Endian mode.

3) Jump to real kernel entry point.

4) Hope all on-chip hardware units work in LE mode, as many haven't been 
tested.  Serial port, I2C, MDIO known to work, boot bus is known not to 
work, haven't tested PCI, Network, or USB.



> A.
>
>
