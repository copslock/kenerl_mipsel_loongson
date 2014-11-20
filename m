Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 19:09:22 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35461 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014112AbaKTSJUUHtyB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2014 19:09:20 +0100
Received: by mail-pa0-f50.google.com with SMTP id bj1so3003648pad.23
        for <multiple recipients>; Thu, 20 Nov 2014 10:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IfWqSM9caS8smq/9fBnZLUyoekB3lYUij+PfVHYCWo4=;
        b=RW4+TaJufojpeJac9Iq4jWfvVIcllhxpx5Ct+Lh7SsScUvNNrXiOzoX63RVd124g6z
         f1W3aRLOmPgp1Bh0HlOCs3Ge47vodeCA7ktBaTbbC95KjQ7WkT5KxF/N2D5fbpX4Up+0
         OR/DMlgDjv4LuIuXcucgY0KymTZ7xOtpi5Lvb4QlXL42fQeX1JcFZTCkK5hoZq0dDwJN
         w38Q8y0AvEnpX6FHA8VXJpQGNggPJ5oKcehBUGPBX8e9OcyI6Yww26CG15mDgg02h6Wz
         3akepMY0CvtDM5ZjZVNyvuDJaRMywa8oehP37VN4HFb+uUTy01jLYSw3KeXMx6enrRH9
         thKg==
X-Received: by 10.68.234.130 with SMTP id ue2mr9632049pbc.12.1416506953995;
        Thu, 20 Nov 2014 10:09:13 -0800 (PST)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id xf1sm2655606pbb.18.2014.11.20.10.09.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2014 10:09:13 -0800 (PST)
Message-ID: <546E2E3E.5040305@gmail.com>
Date:   Thu, 20 Nov 2014 10:09:02 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 00/22] Multiplatform BMIPS kernel
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com> <20141120030434.GE24364@ld-irv-0074> <CAJiQ=7C8h-MAuRdgzZqx2=bg8bvy7v9pv7e7tGXWmA9ghYJiqQ@mail.gmail.com>
In-Reply-To: <CAJiQ=7C8h-MAuRdgzZqx2=bg8bvy7v9pv7e7tGXWmA9ghYJiqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 11/19/2014 07:55 PM, Kevin Cernekee wrote:
> On Wed, Nov 19, 2014 at 7:04 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> On Sat, Nov 15, 2014 at 04:17:24PM -0800, Kevin Cernekee wrote:
>>> The lack of a reboot handler is annoying; syscon-reboot probably won't work
>>> on STB (because it requires two writes).
>>
>> Can't you reuse drivers/power/reset/brcmstb-reboot.c ?
> 
> Oops, I ran a quick check earlier by grepping for "sun-top-ctrl" and
> looking under drivers/reset, but assumed this driver wasn't merged yet
> when nothing came up in the code.  Thanks for the pointer.
> 
> It looks like the current driver will work for 40nm, but 65nm uses
> different bit positions: RESET_CTRL bit 3 to arm, and SW_RESET bit 31
> to trigger.  I'll add a new "brcm,brcmstb-reboot-65nm" compatible
> string to make this work.
> 
> Also, we'll need to take Guenter Roeck's register_restart_handler()
> patch in order to build on MIPS.

Slightly unrelated, did you also try to use drivers/bus/brcmstb_gisb.c
on these MIPS platforms?

Its usefulness is probably lower on MIPS since we typically get accurate
bus errors to be decoded by the CPU and printed through the exception
handler, but I'd be curious if it works just fine as well.

Thanks!
--
Florian
