Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 19:07:47 +0100 (CET)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36879 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008280AbbCFSHqKnXlR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 19:07:46 +0100
Received: by qgdz107 with SMTP id z107so14520571qgd.4
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 10:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QPav9tpINL3owXAcpxdrqRuzjEpVU+LQ8FnU2lTVLI8=;
        b=nrCuygQNdygD5ObuMp8FwU/5jHms6h7ad8kHOZZn9n3EHIKtTOKqx54Bp+AjoO4V0u
         bw5rcOmsx2xQQ/BSdIoBhEN6oENQm2uEJhTddJ7vPGRnCOX8SjQBsjsIcf8i2zu3KeuF
         8FULzUFAw8n925BAgsJ8E2QG8G+uF4wxAtuCLrgBxsCXCf3oDz3THDK8MKGqvx2iWDpi
         uVOVGf6ufjyQyzhvC+8o+DLToSt4881fspJaIrTdPRDdUQBGoWyG9ynkO9tg/7UKoKTa
         TjC+YcvMSEBPgtXWo82PIkyJmq9g56hJG2b4erEVwY2Uo2+cx7Sr4gVWLLkq4At7hx6/
         majw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QPav9tpINL3owXAcpxdrqRuzjEpVU+LQ8FnU2lTVLI8=;
        b=aUNEoy11FGByMQVh6LcFVjWtqw0OwSKbpPUfPg7agnSpQA3bN/rP5Ha0k+kLCJivHE
         QOYbuTzBnKrhLYy7TnNu94IEDs/SfLZAv+POdyIqpSnowdrhjlMTAFQRZhRO7fX5Kmd5
         F065Ewo9e1jfrgD+U3cwtYmhVI4AzA+5dqfTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QPav9tpINL3owXAcpxdrqRuzjEpVU+LQ8FnU2lTVLI8=;
        b=AoPVAKuVJrjYEyvt3rOlRCc53j2L2NuMi/TMfcEpkh8aRqQkvLuPqNvTFXVUiM5hMS
         Ognggso7lCM8SpRMVOwV54wN96ktulSjdUZXcZABb+OIRmnHPP4xKXTbyUvPz2VDifzw
         IcQgVoelW6MC7yZaaXrZTOtTrKAYf+qXnW7zldWySxM+Jfn5Xn9FHhEFJq/PFvtz/rSO
         Bj2Fzetwt0b1Bd2SPEATWflGRZIDKwNg+j9ogHsSK54S1im8oNpp0fWE8vydjB927INi
         smvtsDoYLrf+OuZ8JosIWlm9M2D8tA//jlwew1/ikbjX1evnuYRq9B8N9xxgbTd40dCH
         dNyg==
X-Gm-Message-State: ALoCoQlt5c1jzMsQX9EL52kS7MDNHcVBqCfTQzgHT5bdq4L9HdhwJHN+et2UoMQj2ibWd7vypWv2
MIME-Version: 1.0
X-Received: by 10.55.16.83 with SMTP id a80mr19377456qkh.86.1425665260739;
 Fri, 06 Mar 2015 10:07:40 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 6 Mar 2015 10:07:40 -0800 (PST)
In-Reply-To: <CACRpkdbCOHNPs5Y58h--X6pOVvYyxTrgcFhFyk5dWE+JLo=rhg@mail.gmail.com>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <CACRpkdbCOHNPs5Y58h--X6pOVvYyxTrgcFhFyk5dWE+JLo=rhg@mail.gmail.com>
Date:   Fri, 6 Mar 2015 10:07:40 -0800
X-Google-Sender-Auth: qjWJrKJNBzNVV2EyGb4w5eIFNuc
Message-ID: <CAL1qeaEqcL24DM=w4jgboAvDRi93AidkC9soXPAV9uF4C18JCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: Support for IMG Pistachio
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46238
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

On Fri, Mar 6, 2015 at 3:29 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>
>>  I'd like this to go through the MIPS tree with
>> Linus'/Alex's ACKs if possible.
>
> Why? It will only help creating merge conflicts.
> There seem to be no compile-related dependencies, just Kconfig
> symbols, so patches using this can go in orthogonally.

Ah, ok.  If the missing Kconfig symbol is not a big deal, then let's
take them through your tree.

-Andrew
