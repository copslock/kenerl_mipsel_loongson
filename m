Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2012 19:18:50 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55952 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825701Ab2JXRStMAHdg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2012 19:18:49 +0200
Received: by mail-ie0-f177.google.com with SMTP id e14so1018720iej.36
        for <multiple recipients>; Wed, 24 Oct 2012 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UCe/Boi7SleqsA75BBlsStJi9OtlINa3+jn4aVXtiy8=;
        b=o4GE6bF6PPZPHAE0EljTW4eFkSA94yVfJv7KYpqUfALIPklFDOu91LqIPH8/8xkyF3
         9SXgZk3YY8K5QE7N4nDHblquPL1GHaSPqI0GMWr7NIoH8mw3ktbAUX4HeCqbQlPeoyG6
         AlGbIwNmAmjjOOXPx800juf6s1CbP30YIzcZq7QhGrCF1NjpqNAn4k4KGc6KR3KBP9+e
         7IPrY3Nk7ULvGF3o47MuF+sqk6NeodXhdG1QhzUIJmxW9FGBpypjpUZt7LibCD0R1vT+
         mxnr9O+5P6+5w6SEdT7ahp9ADN6PO7cdC1Fk0g0r+vk09c0yWMU04FM63wvLaoviM4n0
         4qiw==
MIME-Version: 1.0
Received: by 10.50.51.194 with SMTP id m2mr3178149igo.53.1351099122508; Wed,
 24 Oct 2012 10:18:42 -0700 (PDT)
Received: by 10.64.13.233 with HTTP; Wed, 24 Oct 2012 10:18:42 -0700 (PDT)
In-Reply-To: <4796718.WhuB0k6pfC@hyperion>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
        <1351014241-3207-12-git-send-email-antonynpavlov@gmail.com>
        <4796718.WhuB0k6pfC@hyperion>
Date:   Wed, 24 Oct 2012 21:18:42 +0400
Message-ID: <CAA4bVAEfSOPA_6ybmch9Sjt8_qYX7rGmbSL77C1fTrYmXOFsVA@mail.gmail.com>
Subject: Re: [RFC 11/13] MIPS: JZ4750D: Add Kbuild files
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Maarten ter Huurne <maarten@treewalker.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 24 October 2012 20:16, Maarten ter Huurne <maarten@treewalker.org> wrote:
> On Tuesday 23 October 2012 21:43:59 Antony Pavlov wrote:
>> Add the Kbuild files for the JZ4750D architecture and adds JZ4750D support
>> to the MIPS Kbuild files.
> [snip]
>> diff --git a/arch/mips/jz4750d/Platform b/arch/mips/jz4750d/Platform
>> new file mode 100644
>> index 0000000..2e4e050
>> --- /dev/null
>> +++ b/arch/mips/jz4750d/Platform
>> @@ -0,0 +1,3 @@
>> +platform-$(CONFIG_MACH_JZ4750D)      += jz4750d/
>> +cflags-$(CONFIG_MACH_JZ4750D)        +=
>> -I$(srctree)/arch/mips/include/asm/mach-jz4750d
>> +load-$(CONFIG_MACH_JZ4750D)  += 0xffffffff80010000
>
> What is the purpose of padding the load address to 64 bits?
>
> The reason I'm asking is that we encountered a bug with that when creating a
> u-boot image on a 32-bit host machine: the mkimage tool will only parse the
> first 8 hex digits and then inserts the wrong load address into the uImage.

I have just copied jz4740/Platform.

I don't use U-Boot, so I have never faced this problem.

-- 
Best regards,
  Antony Pavlov
