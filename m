Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 20:44:58 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38659 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008511AbbCPTo5MpjxH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 20:44:57 +0100
Received: by igbue6 with SMTP id ue6so52827392igb.1
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=flKVKqK0OpAbl/iUTYFzK/dH+UaGTwQDF7LhPfUPY5I=;
        b=OVJIydOLbPlWb6Klhxiev/mYySfFQxEkrfsJoBjG1Hw1maWCOOtsHqDWPLIZs0Z9BB
         B7Y5kX1XcPJirTN3gCZj4FZmkxNw4uSr88hG+qQlLY9nr8BFXvh+ErAVnHwQTVMCZTW/
         3EzfS0ZFLj8DQ5RcMEKYP8gsnzXvyXojpfqxO1RLS4Dkfv5Oe1KpfHKAH+lIIPn4S1ae
         e2kmbrZcA8AAh5dJuItgXLVhuoGGWZQxeMVAIMFoMQLIVbl7+/Ox6SGQ1EAQVt+q0nR5
         zMBPSnY0wNm0AR/WoJqzYcpa9yAT2D3f7gUf8BnBsOACxzGUfJKVQPvsIdiWfdCcz4hI
         2Mmg==
X-Received: by 10.107.132.39 with SMTP id g39mr90484499iod.62.1426535092244;
        Mon, 16 Mar 2015 12:44:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id s86sm7274474ioe.35.2015.03.16.12.44.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Mar 2015 12:44:51 -0700 (PDT)
Message-ID: <550732B2.6020104@gmail.com>
Date:   Mon, 16 Mar 2015 12:44:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: OCTEON: Patches to enable Little Endian
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk> <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi> <20150316103939.GA28205@paulmartin.codethink.co.uk> <20150316192704.GC586@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150316192704.GC586@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46416
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

On 03/16/2015 12:27 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Mar 16, 2015 at 10:39:40AM +0000, Paul Martin wrote:
>> On Fri, Mar 13, 2015 at 08:52:58PM +0200, Aaro Koskinen wrote:
>>> Hi,
>>>
>>> On Fri, Mar 13, 2015 at 05:34:52PM +0000, Paul Martin wrote:
>>>> Octeon II CPUs can switch from Big Endian to Little Endian freely
>>>> even in kernel/supervisor mode.
>>>
>>> You are enabling it on all OCTEONS. Is that valid? At least octeon-usb
>>> still needs to be fixed for little-endian mode.
>>
>> The USB works perfectly with the patches that were posted to this list
>> over the last couple of months.
>
> I was referring to driver for OCTEON+ USB controller in staging.
> ERPro uses EHCI, so it's different. Anyway, I can try to fix the most
> obvious issues myself e.g. bitfields.
>

OCTEON Plus CPUs (i.e. those with afore mentioned USB controller) don't 
really support Little-Endian operation, so it may not be worth doing 
anything with that driver.

There are several problems:

1) The system bootloader (u-boot) must have support for booting 
Little-Endian.  EdgeRouter LITE doesn't have the proper support.  In 
theory you could write a LE booting shim, but I am too lazy to explain 
what it must do...

2) The bootbus controller doesn't work in LittleEndian mode on OCTEON-Plus.

3) It has never been tested due to #2 being somewhat of a show stopper.



David Daney


> A.
>
>
>
