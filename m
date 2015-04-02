Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 17:35:13 +0200 (CEST)
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34731 "EHLO
        mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006802AbbDBPfMNM0X9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 17:35:12 +0200
Received: by qcay5 with SMTP id y5so69731689qca.1
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2015 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FlVMdm5r1CfDSuZH78oExagxtOahLZtaMD8viPeyUQI=;
        b=NDqbwZyG1o49VRF7RX705VYs4UNJABT+y0QywT2Q1RQmsHc/VLq6AkcYIrJA7aNswU
         6NFkl5o7XCtQM4m3fW5TAKFVMNc4L2OU+CUkfT852b6pTiN3KB+t8wPUDtzK1Zxr/hsd
         YTQjJz+9dmAK3+I7q85p0dMS0OJJmTsNyWltJ7D8EF6YleoY4eTScHTlTkXlJNVy7Rql
         2HJUDbDrWbS0C5+BTmh2rdx4Dy1rPWCP49C/yG4Yzps9vQlrr9Q5hks3PxjPbmugDcFH
         elKa5dT+75M7GrFRwkL7qXEOlSJmZaBZ6+asUwKaXS+sxn5kFzV1ujbythnwHOMcnoXb
         g66w==
X-Gm-Message-State: ALoCoQklxPGb4drmdBNLMQPNMESpTrN3gNl4VnLX04LebTFVJOh9x+ppuHewLpYsy7NXP3TU6FA3
X-Received: by 10.140.97.203 with SMTP id m69mr60926993qge.39.1427988907769;
        Thu, 02 Apr 2015 08:35:07 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id g34sm3707250qgd.0.2015.04.02.08.35.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 08:35:07 -0700 (PDT)
Message-ID: <551D61A5.8000604@hurleysoftware.com>
Date:   Thu, 02 Apr 2015 11:35:01 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Rob Herring <robh@kernel.org>
CC:     Grant Likely <grant.likely@linaro.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com>
In-Reply-To: <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 04/02/2015 09:46 AM, Rob Herring wrote:
> Sorry about that. I had thought about doing the same thing. At least
> unifying the macros, but not necessarily the tables. If it is also
> extendable to other firmware interfaces like ACPI perhaps that would
> be good.

No need to apologize; I'll make those changes and resubmit for your
review.

Regards,
Peter Hurley
