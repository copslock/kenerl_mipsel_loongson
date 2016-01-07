Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 09:13:16 +0100 (CET)
Received: from mail-io0-f177.google.com ([209.85.223.177]:33291 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007617AbcAGINOaEY24 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 09:13:14 +0100
Received: by mail-io0-f177.google.com with SMTP id q21so244488400iod.0
        for <linux-mips@linux-mips.org>; Thu, 07 Jan 2016 00:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pH9EswX0wA2CupfZ894K/qx/rxseCf5jOivXvlNrmXw=;
        b=glU4b7tmvFt9MLnRh9VFe2AbgIA5ML+jckS9mUfnv/kp8Fw8zw8PwBDGXYdG0kgMPG
         IkYorCVsRghtbNAvdJ/eVLCBVJRv/vOQTA7NW94IqDL3JOSwmrdTxH2OyHuPqwdwm4sc
         O+mHoFAxuoGxf7xtZqM934riP8Z//SAaOBTDs68uaK2V822cTrEk18O/85tquXZnqcIe
         BBzYjPWuLtbCzegOIpNutYGl0Pnppjp/9E3Vc/KP0FVBH3Pa959gPl2HPe87IJ06kLAg
         2oAsfVnCG1HfHDLizHEAflTO8h9nMSoWq0EvclKvlzYtlOKEKHNe8f124om0H5RUgaoF
         Ds4A==
X-Received: by 10.107.41.142 with SMTP id p136mr78538401iop.70.1452154388822;
 Thu, 07 Jan 2016 00:13:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.125.69 with HTTP; Thu, 7 Jan 2016 00:12:39 -0800 (PST)
In-Reply-To: <1452106523-11556-4-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com> <1452106523-11556-4-git-send-email-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Thu, 7 Jan 2016 00:12:39 -0800
Message-ID: <CADtm3G4QLBmuawKz+Ri+e-hHEzi74yqMRbhKix55Yfmfh4YNYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: brcmstb: Allow building driver for BMIPS_GENERIC
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        jaedon.shin@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

On Wed, Jan 6, 2016 at 10:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> BMIPS_GENERIC (arch/mips/bmips) is the Kconfig symbol associated with
> Broadcom MIPS-based STB chips. Since this driver is perfectly usable on
> these platforms as well, allow using it.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

I never did get to test this out myself on big-endian bmips.  Glad it
worked after the bus endianness fix in patch 2/3.
