Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 10:48:47 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:47215 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492031Ab0KIJsk convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 10:48:40 +0100
Received: by wwb31 with SMTP id 31so679017wwb.24
        for <multiple recipients>; Tue, 09 Nov 2010 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s8vCMx5meCHvTAnPiEWEPxirybPRF0Lbt3zw408zF1U=;
        b=q+FNxMJ9G0TYIXZkQ6Dq76C1qfxPWi1kbByAW2N86xELIh+xHtTNqaUINx2MxOl0qo
         DhqWd33iKhRnegfqtmP3s0uXtFCgCKsXOCCenqnzJ+TKUYbzEiAiIDA9gsbXBfq7HEVo
         SOVLhowta9mFT8oXaX+0eQ/Oitx+BfWoWXWmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kf9+GSF8dGj7a0gp6mUYPvgdTRF6A+puFBSxBNSbMSgbDRD9uT38P/itM88b+MnkMP
         2KdecqYFUt/IaUw/RF1m9iKlxTf6QxoZd5Kr1q5vhgeSTSu0Hx38G/1u8I5z6ztYUg2u
         yUxgX9mg6T27G4Tg8021E/bB2/DZjsVcFRtls=
MIME-Version: 1.0
Received: by 10.216.51.21 with SMTP id a21mr6552244wec.50.1289296114315; Tue,
 09 Nov 2010 01:48:34 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Tue, 9 Nov 2010 01:48:34 -0800 (PST)
In-Reply-To: <AANLkTi=HjVCbghbH3LYHQfzh=qAPBV-0q_JnfkGPXyS1@mail.gmail.com>
References: <1289133059.1547.0@thorin>
        <4CD84BEA.6010607@caviumnetworks.com>
        <AANLkTikCD_HjshMiP0ubyYZkPDoRb8nkFScUPE3GB2F4@mail.gmail.com>
        <4CD87EC3.2060405@caviumnetworks.com>
        <AANLkTi=HjVCbghbH3LYHQfzh=qAPBV-0q_JnfkGPXyS1@mail.gmail.com>
Date:   Tue, 9 Nov 2010 17:48:34 +0800
Message-ID: <AANLkTimbPpVmbrk13+KSF_DbBmfwjpeuzr2i7DMAKHbO@mail.gmail.com>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Robert Millan <rmh@gnu.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Robert

On Tue, Nov 9, 2010 at 7:02 AM, Robert Millan <rmh@gnu.org> wrote:
> 2010/11/8 David Daney <ddaney@caviumnetworks.com>:
>> Look at the description of the register in this document:
>>
>> http://dev.lemote.com/files/resource/documents/Loongson/ls2e/godson2e.user.manual.pdf
>>
>> On page 49, it says that bits 0-3 contain the minor version number and bits
>> 4-7 are the major version number (according to a workmate that reads
>> Chinese).
>>
>> I don't know for certain, but it seems plausible that the 2E and 2F will
>> differ in bits 4-7, and bits 0-3 can be ignored.
>
> Thanks for investigating, but ignoring bits 0-3 doesn't
> really change anything.  Our problem was that bits 0-7
> are the same on 2E and 2F (0x02).  If we ignore bits 0-3,
> then our problem is that bits 4-7 are the same on 2E
> and 2F (0x2).

Just rechecked this with a friend from Lemote, in reality, the
revision id of Loongson-2F is 0x3, so, my old code should be a
reference for you:

arch/mips/loongson/common/platform.c

PRID_REV_LOONGSON2F and PRID_REV_LOONGSON2E has already been defined
in arch/mips/include/asm/cpu.h

So, the manual is buggy, perhaps the editors of the manuals did copy
and paste for I have found the title of the 2F manual is the same as
the 2E manual ;-)

Best Regards,
Wu Zhangjin
