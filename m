Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 22:51:24 +0200 (CEST)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34316 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012621AbbEOUvXSINYj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 22:51:23 +0200
Received: by ieczm2 with SMTP id zm2so57934276iec.1;
        Fri, 15 May 2015 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=disposition-notification-to:return-receipt-to:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type:subject:from:date:to:cc:message-id;
        bh=RvjWFsimTkufis3v2dNnTIlYdF4VQBSGZ2lQmxMilho=;
        b=wbn9UIbriwpAVG8dlAlVwtLMkN3UXnWK8opMMSD8gFYiwQqEA7KFU+ZwoDOmHaktEw
         211OIeRd2LfZ6L0IisUFaS5MFActkdUGUGVUuyU98M+iLocIhrNXCEjJ0FSP0HT8lJAw
         0IQc9n9Hkc7akLKgoMwX/AAJjXdnnEVQZA4K0VW4PIMwYrr9kluVOHbFsX5wxuSOChaL
         ZVtdpfYTo0GIMzXykDNtreGyx83S9tE2gtj0izvslo+PyTI+DdJDO1SGkuYrzeo4Po9x
         uU78/0PM6cZdfY1S9aBdMwdMcpIEDEEacQ+JI6ibKhPJEZzoxW96zAjMeU06H0bW5H9l
         b5YA==
X-Received: by 10.42.103.196 with SMTP id n4mr23703399ico.31.1431723079143;
        Fri, 15 May 2015 13:51:19 -0700 (PDT)
Received: from [192.168.0.10] (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id g12sm1916636ioe.28.2015.05.15.13.51.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 May 2015 13:51:18 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20150515204546.GH2322@linux-mips.org>
References: <1431613217-2517-1-git-send-email-xerofoify@gmail.com> <20150515201044.GG2322@linux-mips.org> <5556543B.1010406@gmail.com> <20150515204546.GH2322@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH RESEND] mips:Fix build error for ip32_defconfig configuration
From:   Nicholas Krause <xerofoify@gmail.com>
Date:   Fri, 15 May 2015 16:51:43 -0400
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     akpm@linux-foundation.org, kumba@gentoo.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Message-ID: <97052E66-F758-4D28-ABD7-8564E26CB9FF@gmail.com>
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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



On May 15, 2015 4:45:46 PM EDT, Ralf Baechle <ralf@linux-mips.org> wrote:
>On Fri, May 15, 2015 at 04:16:59PM -0400, nick wrote:
>
>> On 2015-05-15 04:10 PM, Ralf Baechle wrote:
>> > On Thu, May 14, 2015 at 10:20:17AM -0400, Nicholas Krause wrote:
>> > 
>> >> This fixes the make error when building the ip32_defconfig
>> >> configuration due to using sgio2_cmos_devinit rather then
>> >> the correct function,sgio2_rtc_devinit in a device_initcall
>> >> below this function's definition.
>> > 
>> > I've already applied Joshua Kinard's 
>> > https://patchwork.linux-mips.org/patch/9787/ with a minor cosmetic
>> > touchup.
>> > 
>> >   Ralf
>> > 
>> Ralf,
>> As you may already known my rep with the other kernel developers is
>pretty bad.
>> Based off this work can you try(time permitting) to put it a good
>word that I am
>> improving.
>
>The kernel world is a meritocracy.  Which means your status will depend
>on the value of your contributions.  So I think there's not much I
>could
>or should do but to let your merrits aka patches speak for themselves.
>
>  Ralf
Very well then thanks anyway. 
Nick 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
