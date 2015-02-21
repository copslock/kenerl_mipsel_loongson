Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 21:53:37 +0100 (CET)
Received: from mail-qa0-f50.google.com ([209.85.216.50]:41958 "EHLO
        mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006732AbbBUUxfXC1IP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 21:53:35 +0100
Received: by mail-qa0-f50.google.com with SMTP id f12so17319352qad.9
        for <linux-mips@linux-mips.org>; Sat, 21 Feb 2015 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FZimygjK3BkybRBSnq+FNksRmQbLZLd1CwWjuA0+nwg=;
        b=nHWntYtE2t+g4dkIrrIrwBdfzP9V7wX6aD4KA5NQIccm/Kn4DCynSUB8q6Wjn7BYge
         PvRODcTC/dQto5aCzIkOtbg7h4mx9nF28u7FnTFLgvfot9jQZIo+bAXUkJcmOsmMTxPF
         hBtn3dH4OvYGQrFscgKWejP8iVVRHbvkqg2ZsPPMjI1cNU8MuUXKz5h04tKvDKt/qtbe
         98vIb1NNg+Mp+x7RKJwd6+0d1Ty33D7N7Z6EPT5kdxZ82LM11aYYHF/R5X2UJojsZ/IL
         WDjvZkFtPxdEHKuw0hbADEkAXRs47yoRATou9yMQcvXNAL0ZsvviTsoIiHSjTCTuGar2
         oACA==
X-Received: by 10.140.192.133 with SMTP id n127mr9419916qha.1.1424552009997;
 Sat, 21 Feb 2015 12:53:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.36.210 with HTTP; Sat, 21 Feb 2015 12:53:09 -0800 (PST)
In-Reply-To: <CACxGe6uifCPz6RM59MVODWo2WGoVBMWSFzmL9Uz3AVJ0C9-hig@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca> <20141125173859.GA27287@kroah.com>
 <20141125211116.GA9997@kroah.com> <CACxGe6uifCPz6RM59MVODWo2WGoVBMWSFzmL9Uz3AVJ0C9-hig@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Sat, 21 Feb 2015 12:53:09 -0800
Message-ID: <CAJiQ=7AMG44h7d2Fuw_ZLynPP62EcD++_kttBymqZgcKK=V8Ug@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Nov 26, 2014 at 5:14 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Tue, Nov 25, 2014 at 9:11 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Tue, Nov 25, 2014 at 09:38:59AM -0800, Greg KH wrote:
>>> On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
>>> > On Mon, 24 Nov 2014 15:36:15 -0800
>>> > , Kevin Cernekee <cernekee@gmail.com>
>>> >  wrote:
>>> > > My last submission attempted to work around serial driver coexistence
>>> > > problems on multiplatform kernels.  Since there are still questions
>>> > > surrounding the best way to solve that problem, this patch series
>>> > > will focus on the narrower topic of big endian MMIO support on serial.
>>> > >
>>> > >
>>> > > V2->V3:
>>> > >
>>> > >  - Document the new DT properties.
>>> > >
>>> > >  - Add libfdt-based wrapper, to complement the "struct device_node" based
>>> > >    version.
>>> > >
>>> > >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>>> > >    temporary variable, so it is easy to add more of_setup_earlycon()
>>> > >    properties later.
>>> > >
>>> > >  - Make of_serial and serial8250 honor the new "big-endian" property.
>>> > >
>>> > >
>>> > > This series applies cleanly to:
>>> > >
>>> > > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
>>> > >
>>> > > but was tested on the mips-for-linux-next branch because my BE platform
>>> > > isn't supported in mainline yet.
>>> >
>>> > For the whole series:
>>> > Acked-by: Grant Likely <grant.likely@linaro.org>
>>> >
>>> > Greg, which tree do you want to merge this through? My DT tree, or the
>>> > tty tree?
>>>
>>> I can take these through my tty tree, thanks.
>>
>> I take that back, it doesn't apply to my tty tree due to changes in the
>> of codebase.  So feel free to take all of these through your DT tree
>> please:
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Applied all 7 patches. Thanks.

Hi guys,

I don't see these patches in devicetree-next or mainline.  Would you
like me to rebase + resend?

Thanks.
