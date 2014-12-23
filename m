Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 17:41:31 +0100 (CET)
Received: from mail-vc0-f175.google.com ([209.85.220.175]:38248 "EHLO
        mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009654AbaLWQl3eTcVv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 17:41:29 +0100
Received: by mail-vc0-f175.google.com with SMTP id hy10so2412823vcb.20
        for <linux-mips@linux-mips.org>; Tue, 23 Dec 2014 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7i46ZY41qTtvyvqiwpk0PHquHjwrhMOmS1sLZb2zO98=;
        b=SxxvBmRIihzZIdhKEbL4iWycxmq39l4JhkEGZnj5qfAI+JnqP6rP1B8CTBdtK2xQ76
         gIC+2gw1pym0tYuCIldtAdooDPaX0TFS9KonZxO7Ezy44V7lRCII1DR/ZTRf7tI6ubbv
         y2UD/XdT85gY87itwWnHbiixIMm4H+LDm9wmWh8FRf9WlLc3ThaBCBPUotkkoCG+/uyw
         DfU4NGXPtz9Tmf1u07rR6zzevo4nyxekc6dUnXSw/LJTTY5w9WhmhtKWuWckuFiT8sKV
         cFchEv5d0yk6iuxwJPzARtV75DvQZlb1AAkHX2WZNwRNGIzQfIEBW3/rEkUI3OJH7uHN
         XGXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7i46ZY41qTtvyvqiwpk0PHquHjwrhMOmS1sLZb2zO98=;
        b=EOmlqob+Rp637+MDkQhxmbs9+NoPZ+RpTtoIpYFieSrVzQWvnXVD0IwONF+H01Q2Qf
         2+8tu+EsP6Fvf/FxMNL26cCR6Lg3eV445ZuudW/lZYwIpVbCaHMjwRPQbob+hyIcAQgZ
         StOFbIB29Jc1oeoXQYiUjnC0LOFwqGGCF2i+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7i46ZY41qTtvyvqiwpk0PHquHjwrhMOmS1sLZb2zO98=;
        b=A1F8xRD5SIRtuog8pIeXjaKcNjF8MU1R5x4M/AArJRo3yf7wufXa1jp0ZGkQW/MEau
         +gtZMfTXCAP5xXxLfXOwt7eH0vrDBu2EZRWutTZ0Xt9trkZ5101CBkfsHPPGw6z5zG/y
         jaayPNXRzXOKlwwOW90wf7JfNzLTBWiXlKVB8tAl+KbsEcN9lN+hIkxEM4TZtnszqaP+
         8F5rNLnuj463wHc4ytAV+jJ5LQFLbCmT1UXgFAP0gehUMEVxd7/5yZtPVbFSpPpCdA3s
         SD86KFAMpE7SrD6yJlR0b5S9CCDPlMbqwwz/4AOEqbpZx55AZMDEMyvd+G1pA39Wxapb
         EF2A==
X-Gm-Message-State: ALoCoQm3dOtTyFiKiA9L7o4CSAc791sU16GXl9hTp6EdTVKFkcc+oR4JEkn1D9ixnlepry3hchyF
MIME-Version: 1.0
X-Received: by 10.220.69.68 with SMTP id y4mr10811949vci.21.1419352883740;
 Tue, 23 Dec 2014 08:41:23 -0800 (PST)
Received: by 10.52.98.135 with HTTP; Tue, 23 Dec 2014 08:41:23 -0800 (PST)
In-Reply-To: <CAJiQ=7A0ZrNr0+mbHs1xJNDHEJMiG7v69XhEtCyWTYrBtX1zpw@mail.gmail.com>
References: <1419290863-19788-1-git-send-email-abrestic@chromium.org>
        <CAGVrzcZPODEbQBF8Z+_r-6H3A_S-4Mi=1ALBf87ZmEngWzDpyw@mail.gmail.com>
        <CAJiQ=7A0ZrNr0+mbHs1xJNDHEJMiG7v69XhEtCyWTYrBtX1zpw@mail.gmail.com>
Date:   Tue, 23 Dec 2014 08:41:23 -0800
X-Google-Sender-Auth: QlS3OHr9bGN1_JoKnptf2YF-kAE
Message-ID: <CAL1qeaH6d5DSU9UgnS4eGvFcAJXEw2iXX8czkCFd8ogdNDLEvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Move device-trees into vendor sub-directories
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Dec 23, 2014 at 8:20 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Tue, Dec 23, 2014 at 8:07 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> 2014-12-22 15:27 GMT-08:00 Andrew Bresticker <abrestic@chromium.org>:
>>> Move the MIPS device-trees into the appropriate vendor sub-directories.
>>>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> ---
>>>  arch/mips/Makefile                                 |  2 +-
>>>  arch/mips/boot/dts/Makefile                        | 33 ++++++++--------------
>>>  arch/mips/boot/dts/bcm/Makefile                    |  9 ++++++
>>>  arch/mips/boot/dts/{ => bcm}/bcm3384.dtsi          |  0
>>>  arch/mips/boot/dts/{ => bcm}/bcm93384wvg.dts       |  0
>>
>> Let's use brcm here, which is the DT vendor prefix, or go full name
>> with broadcom, there has been enough debate in the past about this ;)
>
> IOW we want to see:
>
> arch/mips/boot/dts/brcm/bcm3384.dtsi
> arch/mips/boot/dts/brcm/bcm93384wvg.dts
>
> right?  "brcm" for the vendor name, "bcmXXXX[X[X]]" for the chip
> names, just like the compatible strings.

Ok, I've renamed the "bcm" directory to "brcm" as you've described above.

> BTW, this will again create an ordering dependency with respect to my
> Generic BMIPS patch series.  If Ralf can take Andrew's updated patches
> ASAP (since they're straightforward renamings) it will make it easier
> to add/rename platforms without having to fix up merge conflicts.

Yes, I'd like to get these in -next ASAP as I have work based on them
as well.  V2 incoming...
