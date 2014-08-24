Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 02:36:23 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33723 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006583AbaHYAgWu5MHe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 02:36:22 +0200
Received: by mail-ie0-f171.google.com with SMTP id at1so9000538iec.30
        for <linux-mips@linux-mips.org>; Sun, 24 Aug 2014 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/QrPTJHsoIKgWIYgFrbmHqv5Qtfhg4o4LgT1ygAmgYQ=;
        b=asfk+AAvUe5LrTWbbf1cTfPgzAcrr+UT9d6iAlhbcTsUEF7h7p26yrlO70EqYrgiPw
         zk639qhyou5d61N3AplYhfhwpjSzAiBQW6NFkNpkOCZC3dBkdjECPxZLtvwb3jrNpVw+
         +ToPI3QNKCOvf5VTZJJ7p7QaoudFtTQN4/rEDkhYNPm1TD/AuhgKmVSKUQv/pbr2veYF
         SE4h1hucT1URJxWW96xvEvifyFwit3o0+n6yxmajF7sdsfZiiGTbjnnQWnXJvrprr8KU
         EhUNSPptI2GA9G/9fhUmS0Gb5qprPEWYZ+7Vm88Vt1xl8hJW+fYTBiboJ+7nHwyQY5F5
         qMYA==
MIME-Version: 1.0
X-Received: by 10.50.176.202 with SMTP id ck10mr11856115igc.2.1408916738606;
 Sun, 24 Aug 2014 14:45:38 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Sun, 24 Aug 2014 14:45:38 -0700 (PDT)
In-Reply-To: <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
        <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
Date:   Sun, 24 Aug 2014 21:45:38 +0000
Message-ID: <CACna6rx_V46wAAkRFA+XnZNX80tAdWkaYrTUV5VHxLwbC6GvfQ@mail.gmail.com>
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
X-archive-position: 42199
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

On 24 August 2014 21:24, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This was copied from arch/mips/bcm47xx/nvram.c and modified to interact
> with device tree. My plan is to make the MIPS bcm47xx also use this new
> driver some time later.

I don't like this.

First, you change API (_getenv call), without explanation why/if we
really need this. We decided we're very unlikely to ever find devices
with multiple (separated) NVRAMs. So what's the point of having nvram
per device?

Secondly, don't duplicate the code. If you're going to switch bcm47xx
to this new code, handle it smarter. Modify bcm47xx mode, move it to
the "misc" and re-use in bcm53xx.
