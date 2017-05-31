Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 15:35:12 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:33130
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993419AbdEaNfEvimjH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 15:35:04 +0200
Received: by mail-oi0-x242.google.com with SMTP id h4so1910791oib.0
        for <linux-mips@linux-mips.org>; Wed, 31 May 2017 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=heLU9AwQvV9BozV0kLTYMhdsNtSvL8kKN2WB8Fei7hc=;
        b=TzzNLinUmSH4PCQwGb83GXi8VP6ZqFAJI+iQV4w2sB+6rrRUX4wy4HSf9JsuPJgBfg
         ILJYB1B7Na1ix//V6tdlOQiqyQQpfh7YaqbrTYXZ74mhcemSjxZcxek98uU7HGlv1mD8
         P5NOs/LnP3hjue+1JlvaQJtZsU7Am4ZsZft18aZdHwr1UNPj7hzp2Si3F4w1mIO4xL5e
         TQssyNn6hIyZK3vpbiLVSlmHG8FdfJ/251MHL+waiCzDU8WjwZZlMq+010P8UfQ1YS61
         0FVWDUTBpnZNlZ7rqneALLUbuh90FNHWK2UWae3m607jUfK32MU7ctePqCl7i7SD/fNA
         Iw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=heLU9AwQvV9BozV0kLTYMhdsNtSvL8kKN2WB8Fei7hc=;
        b=akrDqVPTBhMBhOHunkX3xlrjEV7k6Xu+4Qy/LA+AXJPx34f7boCdwKuOGU9GC+WAg3
         41vheMMsT8ZNSBs6ei8ZvtAFe7s0PbTkLyn7TlHL5a2T8dDD5W/ofwDzoOiAu/Akg4aJ
         Fei9XtStwPk/AE1bclgycAnAzo+fblrq7wv20mlDgQZe30Wh+kcBOm1dssgIQpf0lulo
         jv7ZAoh4SHm8OVTe62PPrSH9ImQoTeJmHGCNrBiiPDfJ4eoT/584BNdgO/Xfs78cZpIq
         VrNuvEKKUWxDOmOdSIisC3s8JJ0HNS9VNwFd2RO9536+mLbL0TanM7KLI4S2X6jtwK63
         05fg==
X-Gm-Message-State: AODbwcAZfgVAVCTTtY3/LkHo9yBVYaaDQl3fCSK3ehZM/lMATNJMXffR
        r1zMriSdzP9vm8dw4E0SJ8UFxRxW+w==
X-Received: by 10.202.72.17 with SMTP id v17mr12187254oia.78.1496237698209;
 Wed, 31 May 2017 06:34:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.139 with HTTP; Wed, 31 May 2017 06:34:57 -0700 (PDT)
In-Reply-To: <20170531131216.GJ3956@linux.vnet.ibm.com>
References: <20170530112027.3983554-1-arnd@arndb.de> <7b6903a2-ce54-44f9-18ed-a14bd32069ce@broadcom.com>
 <CAK8P3a2-kO==gMDm3E6U8CR-zhwmZGztRy7Trcezf8oZxgn01g@mail.gmail.com> <20170531131216.GJ3956@linux.vnet.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 May 2017 15:34:57 +0200
X-Google-Sender-Auth: aukbVrHlFcfkPclEjQyx2FllEwg
Message-ID: <CAK8P3a1wcVC1+dPbtAgn=2RbToV_ai+dGc2tJxdQ4r1s+nxAFg@mail.gmail.com>
Subject: Re: [PATCH] bcm47xx: fix build regression
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, May 31, 2017 at 3:12 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Wed, May 31, 2017 at 12:21:10PM +0200, Arnd Bergmann wrote:
>> On Wed, May 31, 2017 at 11:43 AM, Arend van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>> > On 5/30/2017 1:20 PM, Arnd Bergmann wrote:
>> >>
>> >> An unknown change in the kernel headers caused a build regression
>> >> in an MTD partition driver:
>> >>
>> >> In file included from drivers/mtd/bcm47xxpart.c:12:0:
>> >> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
>> >> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first
>> >> use in this function)
>> >>
>> >> Clearly we want to include linux/errno.h here.
>> >
>> >
>> > unfortunate that you did not find the commit that caused this build
>> > regression. You could produce preprocessor output when it was working to see
>> > where errno.h got implicitly included and start looking there for git
>> > history.
>>
>> I did a 'git bisect run make drivers/mtd/bcm47xxpart.o' now, which pointed to
>> 0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h").
>>
>> That commit seems reasonable, it was just bad luck that it caused this
>> regression. The commit is currently in the rcu/rcu/next branch of tip.git,
>> so Paul could merge the patch there.
>
> Apologies for the inconvenience, not sure why 0day test robot didn't
> find this.  Probably because it cannot test each and every driver.  ;-)

No worries.

> This patch, correct?
>
>         https://lkml.org/lkml/2017/5/30/348

Right, I should have included the link.

      Arnd
