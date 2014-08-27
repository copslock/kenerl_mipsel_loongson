Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 20:30:35 +0200 (CEST)
Received: from mail-vc0-f173.google.com ([209.85.220.173]:53622 "EHLO
        mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007092AbaH0SabyLoQP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 20:30:31 +0200
Received: by mail-vc0-f173.google.com with SMTP id id10so50771vcb.4
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8CbTpAxVzkNvRJ2/njSgT7Mt5cbwLJP/kujCDhggBFA=;
        b=hDPg/bZaDLcePVlsSmesIgQyXiL0z9LGGh42MATqIg7cqL28KEeHSESFkvNKRRKKsU
         11Twk2o5LbiKxAVSBjOcBIJ239WR/LTLDE/l+dObcgd1rQHCEVPt0S/bEvJwFbwJe6ic
         5dytXLNB1vwGdwNcdsErItmxuwIrPPL3ji0YS0H99fUFvRVJemEaUkdRDRVpE6DsMpiV
         kN/c4OpEnDORGiH6rQbrQWVbuUDcgmWyAJmgW6O5tv+w8C1tO3RBJKSXOWLstpZPczkK
         YgY2QR1oGLLdDtA8BQqdBKUyrXo8j8POXDE62MgWVUkhv4PSgi7gG+cp3egT4pixJ5Ba
         u2FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8CbTpAxVzkNvRJ2/njSgT7Mt5cbwLJP/kujCDhggBFA=;
        b=e61EV8MPzABq40uUZckMxIdMKwfHZduNABxtYCDa6R79wW3kE7DtHaj2fq4YmsUWX0
         By6KLTD7IW2xlsd4amTDkC54QS3ySqrlCFrc27Jjoo/CAVN55VY+Al8wC0wI6UDt4Tgo
         YTl2pkHmDRecpQdtJKW9lPKClr7rgxZ7YrIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8CbTpAxVzkNvRJ2/njSgT7Mt5cbwLJP/kujCDhggBFA=;
        b=A3eIJtwhdP5WFpeDQBepQuTHXXJkeN9qHAuI2yXGxHNqrxsUQM9Q9NGHPWGtlkOcCF
         WIEekafWX0OSaXV1JJ7CRT/D5jWxS95P3leUiQwZdRIrahL+P/dzKPLsRe8D77F88hHn
         fny/EO4jZ4kDGxgQp8xaSRNnY6umC9fqjebZbOm5DgIftLoBfbZs0JpT5cXEnLM0dYEQ
         +uC7eWGXqwRvNXyrh/qsjQa9o17oEaZkOZuhoYGkparTSHY6hdLdFNSCPUUD24UIXhl/
         unbDv8xXv0plrEWANAEBvGAhFBY+g5ifES8u0hiqARKl5QGiA6AhBlWk/NIMBJ90uRjX
         KcIQ==
X-Gm-Message-State: ALoCoQkf9+gpUzYkH1ePBVlPgn4qr24eVAiBco1E90g9ZR/33y2gDHugtcr544Evwrmb/KX4yPWd
MIME-Version: 1.0
X-Received: by 10.52.249.66 with SMTP id ys2mr3035433vdc.41.1409164225587;
 Wed, 27 Aug 2014 11:30:25 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Wed, 27 Aug 2014 11:30:25 -0700 (PDT)
In-Reply-To: <CAOiHx=mZPt=p_jw4fyEqgniJvqunQ86ro_Run5ZtD1zLYWzmqA@mail.gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
        <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
        <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
        <20140823063113.GC23715@localhost>
        <CAMuHMdXudu0kuOkKN8JCrWZSrQ4awKHhHU0E2ss++ProP0rteQ@mail.gmail.com>
        <CAOiHx=mZPt=p_jw4fyEqgniJvqunQ86ro_Run5ZtD1zLYWzmqA@mail.gmail.com>
Date:   Wed, 27 Aug 2014 11:30:25 -0700
X-Google-Sender-Auth: gSKCX90fjPFKKMmxN0pywTF2gKY
Message-ID: <CAL1qeaFTw=0XMEkag1Z8C4jKkWnwBeGJLYxHGiYfKXBk-9o0Yw@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42284
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

On Mon, Aug 25, 2014 at 8:17 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Sat, Aug 23, 2014 at 9:50 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sat, Aug 23, 2014 at 8:31 AM, Olof Johansson <olof@lixom.net> wrote:
>>>> > arch/arm/boot/dts/<vendor>/
>>>> >
>>>> > Is this something we should do for the MIPS and update the other architectures
>>>> > to follow that scheme?
>>>>
>>>> I recall reading that as well and that it would be adopted for ARM64,
>>>> but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
>>>> more.
>>>
>>> Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
>>> and the amount of files in that directory is becoming pretty
>>> insane. Moving to a subdirectory structure later gets messy which is
>>> why we've been holding off on it.
>>
>> It would mean we can change our scripts to operate on "interesting"
>> DTS files from
>>
>>      do-something-with $(git grep -l $vendor, -- arch/arm/boot/dts)
>>
>> to
>>
>>     do-something-with arch/arm/boot/dts/$vendor/*
>>
>> which is easier to type...
>
> Btw, do you mean chip-vendor or device-vendor with vendor?
> Device-vendor could get a bit messy on the source part as the router
> manufacturers tend to switch them quite often. E.g. d-link used arm,
> mips and ubi32 chips from marvell, ubicom, broadcom, atheros, realtek
> and ralink for their dir-615 router, happily switching back and forth.
> There are 14 known different hardware revisions of it where the chip
> differed from the previous one.

I'm going to assume it means chip/SoC vendor.  That would result in
the following structure (I think):

Octeon -> cavium/
Lantiq -> lantiq/
Netlogic -> netlogic/ (or should this now be brcm/?)
SEAD-3 -> mti/
Ralink -> ralink/
