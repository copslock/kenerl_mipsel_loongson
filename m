Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2014 00:10:22 +0200 (CEST)
Received: from mail-vc0-f181.google.com ([209.85.220.181]:35700 "EHLO
        mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaHVWKUfv6eU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 00:10:20 +0200
Received: by mail-vc0-f181.google.com with SMTP id lf12so12794682vcb.26
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MEk7aJavWw0t1B7pKxIF/mR7ZxqFUERsRoAJpqYCTjs=;
        b=HABeaTXqdrHuJrplfGjTglDINbA9T6O35hQDP0CQsoweZ6tl2wgJTw7MGr2uNjJfZ8
         BtSA+xBlondLBXj353OsVs1RsFuCsiqZX2Yy9SG2sjjAEN6VXQOz/OLymlplSe6Hslzz
         O1faBIdyIPeeR9RS1s+0a5AADfV6SJr1DZgh0kb7ftHwtYf6j1Kojjk7upcL02lFyvK2
         eL5qyrz051kI/dRFJmFzgoopRO+/L2EHOOpq91a39/m6kV/dx4sH+g4MyqOEN5R0z/Q+
         LuIB9Td3n+CeVvCInDMsiSOXz8XcpA+1S3nVMSMV9H09+0I93MStOCKrY8ersqu8NQUT
         8yyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MEk7aJavWw0t1B7pKxIF/mR7ZxqFUERsRoAJpqYCTjs=;
        b=EDR6AxYZIwLJz3ubjhWVDcPCAx4ZvbHCKTRbQk1jv2ehbFlXZqmtChh0OFrYb0NzhF
         QHuF/ShR0zViuhNAvveJkXa07jyKw0WPiBA18pJi4/NfYiBn88ODYlv6ek76wTfIki8y
         cFAygT4tupo29lpyUwjEGGBkGL44GFsZ55sHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MEk7aJavWw0t1B7pKxIF/mR7ZxqFUERsRoAJpqYCTjs=;
        b=DOlBmsTFvl5G4r9GMHbtEf9eI2kxxOyopf5pQLPYvNHUm/ry6xbkApkWIj6hx6XZ5D
         XUGDYhxp4bUFLhoPtl8wVFFsAPLparzdI+qsxsyH/tDnXN6vTuOINoUJO3m74c+q/Aqy
         9nbpIRiZ6W5fCZ6FkacGaNTJNfseH5ME3maZ9tm2c/oxrCGwE7ZgYdeIAfGyhoZTJPwO
         BWN3Tx+zW9vzRxM5WJ/DetwRSrE9eAye4Gd5Vz7Vr/BVdzeVR+KQnMVM1iohVmFRvJ2B
         BID5sTDyPohvragFeALgiSD13kyUDRF3gCmlCQpOwRYoKd2aRrZ79ERstbnJ+U/GaJGJ
         NgLQ==
X-Gm-Message-State: ALoCoQmskgoCjNHpNnG+0zs7Fs2clRkw9lVAI6WahBQlSqhUTJQmuo3BgyLLdy0WIZuiywzOi9Br
MIME-Version: 1.0
X-Received: by 10.52.162.74 with SMTP id xy10mr17834vdb.51.1408745419443; Fri,
 22 Aug 2014 15:10:19 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Fri, 22 Aug 2014 15:10:19 -0700 (PDT)
In-Reply-To: <53F7AEAC.90303@gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
        <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
        <53F7AEAC.90303@gmail.com>
Date:   Fri, 22 Aug 2014 15:10:19 -0700
X-Google-Sender-Auth: TUQBiRiU1MJGUsjK1YFogOtlIjY
Message-ID: <CAL1qeaEaZx0KpMpTSGqZVMZZj1VrzGY3ffRbzEdy4Aks2yHciA@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
From:   Andrew Bresticker <abrestic@chromium.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
X-archive-position: 42183
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

On Fri, Aug 22, 2014 at 1:57 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 08/22/2014 01:42 PM, Florian Fainelli wrote:
>>
>> On Aug 21, 2014 3:05 PM, "Andrew Bresticker" <abrestic@chromium.org
>> <mailto:abrestic@chromium.org>> wrote:
>>  >
>>  > To be consistent with other architectures and to avoid unnecessary
>>  > makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
>>  > and build them with a common makefile.
>>
>> I recall reading that the ARM organization for DTS files was a bit
>> unfortunate and should have been something like:
>>
>> arch/arm/boot/dts/<vendor>/
>>
>> Is this something we should do for the MIPS and update the other
>> architectures to follow that scheme?
>
>
> If we choose not to intermingle .dts files from all the vendors in a single
> directory, why do anything at all?  Currently the .dts files for a vendor
> are nicely segregated with the rest of the vendors code under a single
> directory.
>
> Personally I think things are fine as they are.  Any common code remaining
> in the Makefiles could be moved to the scripts directory for a smaller
> change.

Assuming we don't move them to a common location just to segregate
them again, it makes MIPS consistent with every other architecture
(not just ARM!) using DT.  It also makes it easier to introduce common
changes later on, like the 'dtbs' or 'dtbs_install' make targets.
