Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 06:32:02 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:45049 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492849Ab1ANFb7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jan 2011 06:31:59 +0100
Received: by wwi17 with SMTP id 17so2400903wwi.24
        for <linux-mips@linux-mips.org>; Thu, 13 Jan 2011 21:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K3Z7DEtAVk9nWhTFSVDm7wSlNfdkKG2by7iWIcrTTic=;
        b=m6qvQTrV7Lp5oAmq9W5BLyUAr29afEAchCr29iuBFTlOsDbll6qD8+shS/hvoPV7Uw
         CnUiut9wkAEtpw3nmhSTWOwB8Tvr16KCsFNH4S9m6lzmAISJtujfrmzICjn146jwdfYB
         xg3budnhXigs0nR4uhv5RMMEtBDZ3QwGmECx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kr293CIei+6xzC4e1XLPDaK2uumzvcSK7GC5PFv5V6v1d62vPQNdOCBnGyBXCETy3k
         BZ4Oyc05bZjGC7KyRrE8pI/eC0I0Z1VvB/3VIZWzhbjckq9+SMr+GFhtE/KJPlzrRPvN
         TEJ3lPxaJ1LE9uePZzjQecv4v5RMRJvr5FezI=
MIME-Version: 1.0
Received: by 10.216.166.130 with SMTP id g2mr286662wel.3.1294983113055; Thu,
 13 Jan 2011 21:31:53 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Thu, 13 Jan 2011 21:31:53 -0800 (PST)
In-Reply-To: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
References: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
Date:   Fri, 14 Jan 2011 13:31:53 +0800
Message-ID: <AANLkTik8hQfd8cvNj=qeq5U=6zpQHw33a9hfK-q8+x1Z@mail.gmail.com>
Subject: Re: about udelay in mips
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 13, 2011 at 6:02 PM, loody <miloody@gmail.com> wrote:
> hi all:
> If i trace source in the correct place, I found udelay(100) is
> implemented as a loop which decrease 1 per iteration until the count,
> 100, as 0.
> What makes me confused is since the speed of cpus are different and
> that will make udelay not precise on different platform, right?

Yeah, it may be not precise, so, some processors, like Cavium octeon
have added their own timestamp register based delay functions, please
refer to:

arch/mips/cavium-octeon/csrc-octeon.c

The delay_tsc() for X86 defined in arch/x86/lib/delay.c is similar.

But both of them are 64bit timestamp registers.

We can also apply similar method to add the precise delays for the
other CPUs, but we may need to take extra notice:

1. If the CPU only provides 32bit timestamp registers(e.g R4K MIPS),
overflow should be considered.
2. If the CPU support dynamic CPU frequency and the frequency of the
timestamp binds to the CPU's frequency, the scaled down timestamp
should be converted to the real timestamp.

Regards,
Wu Zhangjin

>
> --
> Regards,
> miloody
>
>
