Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jan 2011 17:35:32 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:56328 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493222Ab1APQf3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jan 2011 17:35:29 +0100
Received: by wwi17 with SMTP id 17so4273385wwi.24
        for <linux-mips@linux-mips.org>; Sun, 16 Jan 2011 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jfc8klZss2VbcQ24IF1t6Pjw0lq39PWSTxLq89P2wgQ=;
        b=Jt/7cx3iaLSzvMfvbBXEV9blZcmUXkwRViX0XKx4GS4kzTzzibjIvWjvZ3Ns3QI6/P
         i8Sq4bGP5Z+4ogWQikQ/Syyd3XAWxqp0mHvkUqPEbnK1sV5iavehqZXKu3l3qQOaWsiq
         PWqJMdANlyvUGTNXLNphYHvqlYwQb5PXmxng8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nQh0eHVOr0qGXtp1BR+2j9dLHFC4u0y1D08K7XeFRQt5DH2S/jsny8iAWipM4vErbC
         rM+DjOr+0rUiR1gKECoulYRyw1QtUwAmw+tZ0dmgogR4UVyUQggLwq2JWaY2kzlcWl1Q
         Km341Iet0C4JIXYBJxvQX4dA7NXpfcYbRQiwg=
MIME-Version: 1.0
Received: by 10.216.164.14 with SMTP id b14mr2910735wel.33.1295195663683; Sun,
 16 Jan 2011 08:34:23 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Sun, 16 Jan 2011 08:34:23 -0800 (PST)
In-Reply-To: <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
        <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
        <AANLkTikpUBtg2zz8tcbcz2rcG-O+fTFwb_pTi88uZe0h@mail.gmail.com>
Date:   Mon, 17 Jan 2011 00:34:23 +0800
Message-ID: <AANLkTinz0GKr0Thy6mqK06-B6c6_22c8Jboos6QsVEX-@mail.gmail.com>
Subject: Re: about udelay in mips
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Jan 16, 2011 at 10:38 PM, loody <miloody@gmail.com> wrote:
[...]
> (us  *   0x000010c7   *   HZ   *   lpj   )) >> 32)
> I cannot figure out why we need to multiply 0x10c7, and what lpj mean?
> Does lpj mean if jiffies increase 1, how many "subu    %0, 1" may need?

Yep, lpj is calculated in init/calibrate.c

> Regards,
> miloody
>
>
