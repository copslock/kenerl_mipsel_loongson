Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2014 15:46:07 +0100 (CET)
Received: from mail-bk0-f47.google.com ([209.85.214.47]:42655 "EHLO
        mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816642AbaBOOqBSw30I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Feb 2014 15:46:01 +0100
Received: by mail-bk0-f47.google.com with SMTP id d7so3709889bkh.6
        for <multiple recipients>; Sat, 15 Feb 2014 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dK/mfhJszHCe6sJUbIY/6bk5abg7q2KzjliwGjwOzNg=;
        b=do3T/EZUYNhgHxEz9g8GeGlvPavFqV4R9Q4jZX8GduRg9biUBcEAUisyPhLgNw2TJE
         NjoSeMi4byPEriuvgpZho9HQlp9Uc24EzQfptYGUUVtYUodNvrK7Ng6/v59ds3Da90O3
         Q9J+ulz6flElpGpVLHdi/mbhDwHEw6deXg1HAO4IYXW+zbcIo7ornB+cPwEqDBHHrHuN
         DH7baLTAXXKimylk8VAxuVmgKPcALbnepf3TshXP89yTQWJ6zyWa4E057PnyAbI5O5mY
         phLvFL/zJECMtvmN8BWmaix9Ku3dQg0aIMESXNL4Ws9/vpBNePkp7Y8x2cUDRBREruFa
         jwKQ==
MIME-Version: 1.0
X-Received: by 10.204.62.205 with SMTP id y13mr8908394bkh.19.1392475555593;
 Sat, 15 Feb 2014 06:45:55 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Sat, 15 Feb 2014 06:45:55 -0800 (PST)
In-Reply-To: <20140209194501.GD573@drone.musicnaut.iki.fi>
References: <1391952745.25424.6.camel@x220>
        <CAOiHx=mi3sW7C0ZGwAhobRryikMs=Hj0UL19ENuUMECqk0EW5g@mail.gmail.com>
        <20140209194501.GD573@drone.musicnaut.iki.fi>
Date:   Sat, 15 Feb 2014 22:45:55 +0800
Message-ID: <CAAhV-H6f5BqYPyyn6dZHCpOJJK5ZyM=WHaJKeRVk3wgdk82i6w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Jonas Gorski <jogo@openwrt.org>, Paul Bolle <pebolle@tiscali.nl>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

I think Paul Bolle's patch is correct and my first patch is not
enough. So it needn't to make a separate patch, just take Paul's patch
and my second patch is enough.

On Mon, Feb 10, 2014 at 3:45 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Sun, Feb 09, 2014 at 05:26:59PM +0100, Jonas Gorski wrote:
>> On Sun, Feb 9, 2014 at 2:32 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> > Commit 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
>> > introduced references to two undefined Kconfig macros. CONFIG_MIPS32_R2
>> > should clearly be replaced with CONFIG_CPU_MIPS32_R2. And CONFIG_MIPS64
>> > should apparently be replaced with CONFIG_64BIT.
>>
>> While I agree about the CONFIG_MIPS64 => CONFIG_64BIT replacement, I
>> wonder if CONFIG_MIPS32_R2 shouldn't rather be CONFIG_CPU_MIPSR2
>> (maybe even the existing CONFIG_CPU_MIPS32_R2 are wrong here).
>
> FYI, the 64BIT part is already fixed by
> <http://patchwork.linux-mips.org/patch/6506/>. I guess these two changes
> could be separate patches.
>
> A.
>
