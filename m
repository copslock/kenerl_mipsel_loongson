Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2014 10:40:13 +0200 (CEST)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56117 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008645AbaIJIkLWLJKZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2014 10:40:11 +0200
Received: by mail-ob0-f169.google.com with SMTP id wp18so3802430obc.14
        for <linux-mips@linux-mips.org>; Wed, 10 Sep 2014 01:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qyRhOlSKqcn4C0hBADI05iyWh9gSYhPRs7BpEefDnlk=;
        b=FpLnFVnJpPU5Y3u1O7zLFy2PvpFtLoNZYczXC0+TBaWBqOEtyd2oJdVfoTDlHVVV7F
         s87ik6le0krWsO2jTuni8PkoT/Hqt+Rmp0WJezZx1lLI5EaDKTbqo2+AYTBwGwHHoLou
         a+REtP/l4LEfm+vv16HVN+Alyz2kUkJCPIBl+1edR5wpkDVXpXUOTjn0hf5w/NTajMqZ
         906xIRx0mYzIxEOi2CqGPaG5TpAf0ltwMEn/Q5C/eHD02cgOulKue9Z+rKIFC0sQNR2m
         LnoiAGkMvnBtkFGuyJntkPmJl5rkPXg+beU9WkDxwovuYArRYpNLEQv3K777MTP+uA5R
         G1tQ==
X-Received: by 10.60.118.8 with SMTP id ki8mr44868782oeb.29.1410338405062;
 Wed, 10 Sep 2014 01:40:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.102.6 with HTTP; Wed, 10 Sep 2014 01:39:45 -0700 (PDT)
In-Reply-To: <54100AE5.6050401@imgtec.com>
References: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
 <20140909191736.GA7467@kroah.com> <54100AE5.6050401@imgtec.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 10 Sep 2014 10:39:45 +0200
Message-ID: <CAPybu_128PsDN7wywntyTuCCfenBWTiS60P2g6_Hk68EMQc1CQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485 definitions
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Greg KH <greg@kroah.com>, linux-mips@linux-mips.org,
        linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <ricardo.ribalda@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricardo.ribalda@gmail.com
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

Hello Greg

Sorry, Probably my bad :). I did resend a new patch using the _IO*
macros, that has been now merged to tty-next

Regards!

On Wed, Sep 10, 2014 at 10:25 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 09/09/2014 08:17 PM, Greg KH wrote:
>> On Tue, Sep 09, 2014 at 12:52:55PM +0100, Markos Chandras wrote:
>>> Commit e676253b19b2d269cccf67fdb1592120a0cd0676
>>> (serial/8250: Add support for RS485 IOCTLs) added cases for the
>>> TIOC{S,G}RS485 commands but this broke the build for MIPS:
>>>
>>> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
>>> drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
>>> (first use in this function)
>>> drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
>>> (first use in this function)
>>>
>>> This patch adds these missing definitions
>>>
>>> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>>> Cc: <linux-next@vger.kernel.org>
>>> Cc: <linux-kernel@vger.kernel.org>
>>> Cc: <linux-serial@vger.kernel.org>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>  arch/mips/include/uapi/asm/ioctls.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
>>> index b1e637757fe3..34050cb6b631 100644
>>> --- a/arch/mips/include/uapi/asm/ioctls.h
>>> +++ b/arch/mips/include/uapi/asm/ioctls.h
>>> @@ -76,6 +76,8 @@
>>>
>>>  #define TIOCSBRK    0x5427  /* BSD compatibility */
>>>  #define TIOCCBRK    0x5428  /* BSD compatibility */
>>> +#define TIOCGRS485  0x542E
>>> +#define TIOCSRS485  0x542F
>>
>> Any reason you aren't using the _IOR() type macros here?
>>
>> thanks,
>>
>> greg k-h
>>
> Hi Greg,
>
> Not really. I am being consistent with what
> include/uapi/asm-generic/ioctls.h is using, and with the xtensa patch
> that was posted yesterday
>
> https://lkml.org/lkml/2014/9/9/27
>
> --
> markos



-- 
Ricardo Ribalda
