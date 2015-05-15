Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 16:18:38 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36281 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012469AbbEOOSg56zG6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 16:18:36 +0200
Received: by igbpi8 with SMTP id pi8so221650427igb.1;
        Fri, 15 May 2015 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=q5N0J12+ReCP+7L9+sFJr+EvWNqkujupWfKHqmD0aG0=;
        b=GQyHAQB2wxXoKgQexxZC2xf2ykluHW8D15hphpPJDL31isFPzqV6lLLvvXRaRpO7Pw
         NH8er+FL4sZU47hmdVlPtoMCEHPauHTm8HJimKn6x0Mc1ZVxtM60P4DEuJwcuFIsUk3S
         0u0nEQEE9YoE5fEBlFr448mAwn7JNJGMx+a0cPQ1VZ+Vk+GFveOh9Go8CGLe1kQw/8Gk
         0gMcXh/A9gXAqyb8Q0tMeS8M48/JyhTxBh1r4dNft/bJ2fLS7OrsAGQHCGawtgBtXdAL
         r8YIMBjhZE49970e8iGdX13nD9sdcCRsF3tAuFTjFlSUaG0cDke51QkXe6nOZHGzrw/y
         Z9ng==
MIME-Version: 1.0
X-Received: by 10.107.158.15 with SMTP id h15mr9913353ioe.14.1431699512928;
 Fri, 15 May 2015 07:18:32 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Fri, 15 May 2015 07:18:32 -0700 (PDT)
In-Reply-To: <20150515141228.GA2322@linux-mips.org>
References: <1431589370-30147-1-git-send-email-zajec5@gmail.com>
        <5554625C.4070403@imgtec.com>
        <CACna6ryk3AYUeh738nPmcOh1BLcn+VzaZ6p4hYJSZppWr=Ts2A@mail.gmail.com>
        <20150515141228.GA2322@linux-mips.org>
Date:   Fri, 15 May 2015 16:18:32 +0200
Message-ID: <CACna6rxb7Fwp8Hmqc-i-7EoOxuPmiM002conCh=VzovtpcFeXw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix regression in reading WiFi SoC SPROM
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 15 May 2015 at 16:12, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, May 14, 2015 at 11:18:57AM +0200, Rafał Miłecki wrote:
>
>> On 14 May 2015 at 10:52, Markos Chandras <Markos.Chandras@imgtec.com> wrote:
>> > On 05/14/2015 08:42 AM, Rafał Miłecki wrote:
>> >> In the recent SPROM commit:
>> >> MIPS: BCM47xx: Read board info for all bcma buses
>> >> a proper handling of "fallback" argument has been dropped. Restore it.
>> >>
>> >> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> >> ---
>> > if the "MIPS: BCM47xx: Read board info for all bcma buses" is not
>> > upstream yet (I can't see it) it might make sense to fold this fix into
>> > it and repost it as v2.
>>
>> It's not upstream in Linus's tree, but it was already pushed by Ralf
>> to his tree:
>> http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=c6d94e9354139e8a0ef3bd3286b2a5ac30f8f6aa
>>
>> I'll just let Ralf decide if he wants to rebase.
>
> I've folded this patch into the original commit.  I put the original
> and now the combined patch into my 4.2 queue so it won't go to Linus
> for another few weeks anyway.  If this should go upstream for 4.1,
> please lemme know.

Thanks a lot. Everything I posted is for next (4.2).

-- 
Rafał
