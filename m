Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 07:54:41 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41341 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006940AbaH0Fykpnyc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 07:54:40 +0200
Received: by mail-ie0-f176.google.com with SMTP id tr6so12879954ieb.21
        for <linux-mips@linux-mips.org>; Tue, 26 Aug 2014 22:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=90e3ZE72kJeX+dASXjFyi+B8B2xU89e47aVqsv0CmzY=;
        b=yc9/rR5FoFdlfxTbeDeRotSGwr4u3/XyIBbYMsOkZBVRiRqOuf6V88VKoCD41vhEjB
         AnOPx8FquABHRN84MswaTK3qN46Fg7WlVM5VRqeeUqrAGkXDKe9Db3fTQLhJ1F66THGO
         stM6fPPHXawViqAA61lS3HTOxIIaZXOPzPzKrkNtB7HXLpPXCznjxGNUXO8CISW69ylt
         rdCXXtR72znTfcV+xp8+t7VUcrEALnAGCfC+hkJa5VKa5IbnkAZPQq3qj/qEcZbnKg9L
         914pJs8ZTqb1YPM+H/ygvV5BzSaW5MOgJ4hg3W8IhJInIYCKLhmSnb85POnHWN/+Oess
         kHCw==
MIME-Version: 1.0
X-Received: by 10.50.176.202 with SMTP id ck10mr27814601igc.2.1409118874491;
 Tue, 26 Aug 2014 22:54:34 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Tue, 26 Aug 2014 22:54:34 -0700 (PDT)
In-Reply-To: <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
        <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
Date:   Wed, 27 Aug 2014 07:54:34 +0200
Message-ID: <CACna6rwJBDpg9VS4h5hfP4wtGRVwAdRUq5mELeA0OFWWzH9jsA@mail.gmail.com>
Subject: Re: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt support
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42273
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

On 24 August 2014 23:24, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> +On NorthStar ARM SoCs the NAND flash is available at 0x1c000000 and the
> +NOR flash is at 0x1e000000
> +
> +Example:
> +
> +nvram0: nvram@0 {
> +       compatible = "brcm,bcm47xx-nvram";
> +       reg = <0x1c000000 0x01000000>;
> +};

Could we avoid that? Type of flash can easily be checked in the code.
All we need to do is to read BCMA_IOST register of BCMA_CORE_NS_ROM
core.
