Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 08:07:20 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47345 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006827AbaH0GHTrdaC5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Aug 2014 08:07:19 +0200
Received: by mail-ie0-f173.google.com with SMTP id tr6so12901095ieb.18
        for <linux-mips@linux-mips.org>; Tue, 26 Aug 2014 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LYotHcb3zBD9latHxQC9Il00BpAhgwvhvW8FBU6rUTY=;
        b=Z74XLkqW34idjeZGK5JVKBXLIYrJlPE4sPa1RD038+wGLTC9RY9HLyoOfeQNbdBc00
         3ef2qsZkwHA3nj/EazHnz6n1AZgV0o5br2yH65AUaMog/uvJzoACTyjXiEs1R7iZ4/wQ
         HVpJeiZIW0hbgf4ERuYrXE6Rer5yCq25SRo+tdP0BjuK55gCA0NciGiFXE0KCE3TxAd3
         szeZ4Uj+OhDwVfa+m3YNK4VeFrLxzp5SP9br7knk0zl4Q68UvVhK09l/jdhMkD3VBR2W
         vwM04VPsReH6KRXzr4JthhH2TlNfrswVZl7WWoMEOdxbEHRtMqfQM4tjt43O8dOri8X9
         +8Yg==
MIME-Version: 1.0
X-Received: by 10.51.17.2 with SMTP id ga2mr27876279igd.2.1409119633856; Tue,
 26 Aug 2014 23:07:13 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Tue, 26 Aug 2014 23:07:13 -0700 (PDT)
In-Reply-To: <53FCEECA.8090308@hauke-m.de>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <53FCEECA.8090308@hauke-m.de>
Date:   Wed, 27 Aug 2014 08:07:13 +0200
Message-ID: <CACna6ryS=Tr7FsF6NMJOHZax1zXpGxYfOt-GprNM1WHi2tJhkA@mail.gmail.com>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42274
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

On 26 August 2014 22:32, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 08/26/2014 06:42 PM, Rafał Miłecki wrote:
>> 3) Above change (point 2) would require some small change in bcma. We
>> would need 2-stages init: detecting (with kmalloc!) bus cores,
>> registering cores. This is required, because we can't register cores
>> too early, device_add (and the underlying kobject) would oops/WARN in
>> kobject_get.
>>
>
> This sound good to me, but I still have some questions.
>
> Do you also want to change ssb registration?
> Is it worth the effort? I think MIPS bcm47xx will be EOL and replaced by
> the ARM versions completely in the next years. (I do not have any
> private information about Broadcom product politics)

ssb has its own hacks like having "struct device" static (I think it
was a big "no" from Greg when introducing bcma). ssb is already smart
enough to detect early boot phase and don't register devices then. I
think we won't need to modify ssb at all.
On the other hand I care about bcma, as it's used by PCIe devices and
will still be used on ARM SoCs.


> I think this will be reduce the number of hacks a little bit, but you
> still need a 2 stage init of bcma for mips SoCs, and I do not know how
> to prevent this.

I'm OK with two separated calls to the bcma to register it fully. Not
a big deal. We could also think about sth like a ssb_is_early_boot,
not sure about this yet.

-- 
Rafał
