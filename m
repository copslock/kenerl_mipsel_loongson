Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 23:19:12 +0100 (CET)
Received: from mail-we0-f169.google.com ([74.125.82.169]:38466 "EHLO
        mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006732AbbBUWTKB4B7R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 23:19:10 +0100
Received: by wesw55 with SMTP id w55so11559151wes.5
        for <linux-mips@linux-mips.org>; Sat, 21 Feb 2015 14:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9k38tloY0gwpc+0Z9fZ3e9lVqCym2SnfxaKHxahBQ88=;
        b=BxKpzdAJ/363pbmxcR9gcahIbJ9VZkV5NLeOgTvQLyLdZz6fMTaXuyBaFFWjXXWslm
         lWDlAk6Y2HJPfa6CLA6lc4l1CIHE+U0grwJxlCz4tvoZv90zgjrP/lxHvDCpxwcxV0Jl
         CwVevt+SG5uFbQsvxs9FedhWDz+RD3fK5J3wg+m1NvVkj+Q0yEiXarudW6Dz/aogsb1K
         1XRGqo8u/nXm46HfPozNqr8C783h5vy1JoOQj7ERy6tPPku7ti47Gtr7uAnrhoO48ypU
         17Z2C2/zLEwIFDNoHm0KDPgnGQdCf+HkSdIpO/MHR9zcKRE0h7iXUfQWH7mfDxlWuZYV
         wvew==
X-Received: by 10.194.78.231 with SMTP id e7mr7921376wjx.33.1424557145145;
 Sat, 21 Feb 2015 14:19:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.139.146 with HTTP; Sat, 21 Feb 2015 14:18:44 -0800 (PST)
In-Reply-To: <CAJiQ=7AMG44h7d2Fuw_ZLynPP62EcD++_kttBymqZgcKK=V8Ug@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca> <20141125173859.GA27287@kroah.com>
 <20141125211116.GA9997@kroah.com> <CACxGe6uifCPz6RM59MVODWo2WGoVBMWSFzmL9Uz3AVJ0C9-hig@mail.gmail.com>
 <CAJiQ=7AMG44h7d2Fuw_ZLynPP62EcD++_kttBymqZgcKK=V8Ug@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 21 Feb 2015 16:18:44 -0600
X-Google-Sender-Auth: UG8klPO9_GF15eZ7Tv8Ratnzrbk
Message-ID: <CAL_JsqKCnD2-=pepcnianeVCw=Knn5Audt_EL0sHVszmTVc8KA@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sat, Feb 21, 2015 at 2:53 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Wed, Nov 26, 2014 at 5:14 AM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Tue, Nov 25, 2014 at 9:11 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Tue, Nov 25, 2014 at 09:38:59AM -0800, Greg KH wrote:
>>>> On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
>>>> > On Mon, 24 Nov 2014 15:36:15 -0800
>>>> > , Kevin Cernekee <cernekee@gmail.com>
>>>> >  wrote:
>>>> > > My last submission attempted to work around serial driver coexistence
>>>> > > problems on multiplatform kernels.  Since there are still questions
>>>> > > surrounding the best way to solve that problem, this patch series
>>>> > > will focus on the narrower topic of big endian MMIO support on serial.
>>>> > >
>>>> > >
>>>> > > V2->V3:
>>>> > >
>>>> > >  - Document the new DT properties.
>>>> > >
>>>> > >  - Add libfdt-based wrapper, to complement the "struct device_node" based
>>>> > >    version.
>>>> > >
>>>> > >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>>>> > >    temporary variable, so it is easy to add more of_setup_earlycon()
>>>> > >    properties later.
>>>> > >
>>>> > >  - Make of_serial and serial8250 honor the new "big-endian" property.
>>>> > >
>>>> > >
>>>> > > This series applies cleanly to:
>>>> > >
>>>> > > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
>>>> > >
>>>> > > but was tested on the mips-for-linux-next branch because my BE platform
>>>> > > isn't supported in mainline yet.
>>>> >
>>>> > For the whole series:
>>>> > Acked-by: Grant Likely <grant.likely@linaro.org>
>>>> >
>>>> > Greg, which tree do you want to merge this through? My DT tree, or the
>>>> > tty tree?
>>>>
>>>> I can take these through my tty tree, thanks.
>>>
>>> I take that back, it doesn't apply to my tty tree due to changes in the
>>> of codebase.  So feel free to take all of these through your DT tree
>>> please:
>>>
>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Applied all 7 patches. Thanks.
>
> Hi guys,
>
> I don't see these patches in devicetree-next or mainline.  Would you
> like me to rebase + resend?

Not sure what happened there, but since they conflicted for Greg, it's
probably best to rebase to 3.20-rc and resend them.

Rob
