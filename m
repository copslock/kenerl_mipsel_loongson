Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2018 12:03:53 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:37581
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993016AbeFNKDp31T4i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2018 12:03:45 +0200
Received: by mail-lf0-x241.google.com with SMTP id g21-v6so8507783lfb.4;
        Thu, 14 Jun 2018 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vodbzBKpJhhpe4g90mTwqzCE5CjR0xvzILkSUKy7L0Q=;
        b=uFYl72z06Tow+SFEHzvDIeMKpYgz8lEHFq3Tjw5GKdQLWGancG0Rtb0M4joS/yNI78
         GOfW5vUt7Ckz8MA1tkY7k9h5n1fiETCIuyLl/lyB8jkTKiPJNXLaeMLL9Ntl6gg5ZLUp
         zgV5PZOqwyrwvBYkh4Yxrwxuu81dA+HWLj2RzSfAkgfF/jsW2FYZYsJFb6BhzSgq2K2Q
         n/xazhuAgXdoplk//9rAri8q1fKc3KuLqJetKcpliQKlQ+aPKk5Ak2Ej7oy5jHjSNzcG
         zdIjnHLedItQkD9NSbDGYrwUNb0LmCJ2dxewOAcVH8HbavZo6zt1sAOlJyoVC3doi9QH
         cZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vodbzBKpJhhpe4g90mTwqzCE5CjR0xvzILkSUKy7L0Q=;
        b=XmZ6scRCnFHZvwxuYnQ8UjQOCCmFwS/0PjrG/xhCrztx2n/CtMf+nSX/jOqLLIEy4f
         x4Sxze3x8VzRQl/g1H17qYmDtk0a7rWH1GDmmVVm7KSSwVtbJBWKjUsjJnuPO7ZdpMQ5
         va1HnAEpUgbTtZjETJDH19NK0UkrZsKPH1+tJkZHaCklEtH+RcGsqQoy7c7bw2ivV8gy
         b+zVQGX3x0F9Jlbzl8Ke2c+fUplk+p83yrLBB/QJ3WTWA6cTpQGIFygmU7/BWBhxJKjH
         qubOMIS6vyEVrOTJ5pTrjR7UH7BuSTg00OZLK1ztBTe2gm9PTo7OXeLFW0mWD3W/F/i2
         +8Ng==
X-Gm-Message-State: APt69E2gMiqtkQJHslRD+mGEh3GI2tnABOSVFBJjoFWHLwwXJFA8wjNc
        6wOARjxnRwW4dcH9UBazrzKHJGqlcc2kKBiZYO9ogw==
X-Google-Smtp-Source: ADUXVKJ5alK9gLVnKhDZ3G4yT8tXhTpULBE3a/iooRSe4DKa88kKA3l9knJL2uEHm+Q/cJC2HQt7aYLcEPFRXbKiJ7g=
X-Received: by 2002:a2e:5453:: with SMTP id y19-v6mr1234608ljd.11.1528970619879;
 Thu, 14 Jun 2018 03:03:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:03:38
 -0700 (PDT)
In-Reply-To: <20180612054034.4969-2-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-2-songjun.wu@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 12:03:38 +0200
X-Google-Sender-Auth: e6NBsyed01hqbvTPE9y-orQf8xk
Message-ID: <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64266
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

On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses a hard-coded register value to check if
> the current serial entity is the console entity.
> Now the lantiq serial driver uses the aliases for the index of the
> serial port.
> The lantiq danube serial dts are updated with aliases to support this.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
>  arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
> index 2dd950181f8a..7a9e15da6bd0 100644
> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
> @@ -4,6 +4,10 @@
>         #size-cells = <1>;
>         compatible = "lantiq,xway", "lantiq,danube";
>
> +       aliases {
> +               serial0 = &asc1;
> +       };
> +

You generally want the aliases to be part of the board specific file,
not every board numbers their serial ports in the same way.

       Arnd
