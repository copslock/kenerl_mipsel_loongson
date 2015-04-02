Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 17:36:52 +0200 (CEST)
Received: from mail-qc0-f173.google.com ([209.85.216.173]:36122 "EHLO
        mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009544AbbDBPgvMMaHB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 17:36:51 +0200
Received: by qcgx3 with SMTP id x3so70117729qcg.3
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2015 08:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6+fskcUxQi5wsQp8SN6r5EehCy+19/jBdGLk0lNG2qs=;
        b=G6o+tnEO/PRsjx2Lht2uI8qhMOKKzBpVDmtL7z5ikVWa3GPXUlbYm9ZDVjqgR+tBOz
         QLOzKh52cWlEU+crDewpin/phXn2/IKRvWmQM9oJuTFf2ZafV5vZg9uVd5CzqLyYrAtc
         tHWaXIfOY5ym0+M1h4MGzjaoSnXPyim3X/5hgbQaHaORLUan3e+GSz+IZpy1hfsgaFAa
         RnJFTAK7FoMrx+USsZKMX/SJbqY2JbORiS1Np2alfuNB43djZImyw0DX5Fz//lgxWSdx
         8fEO3Y5JBY/hRL/M0U1H/qZevYfTtFH8Go054GBDOrsaDT/98v9TzJqYIPkWVyGrLPgK
         V7rw==
X-Gm-Message-State: ALoCoQm5bzfDSW6sKA31dCYO/1kCXujORJEtngdl+iuAA0BDBsBEIjJDBZmBIzMfQwLMFsQXCllz
X-Received: by 10.140.232.19 with SMTP id d19mr18181467qhc.19.1427989006595;
        Thu, 02 Apr 2015 08:36:46 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id 64sm3679001qgx.40.2015.04.02.08.36.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 08:36:45 -0700 (PDT)
Message-ID: <551D6208.2060009@hurleysoftware.com>
Date:   Thu, 02 Apr 2015 11:36:40 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com>
In-Reply-To: <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46709
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

Hi Kevin,

On 03/28/2015 03:28 PM, Kevin Cernekee wrote:
> On Sat, Mar 28, 2015 at 10:01 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> I know these got ACKs already but as you point out in the commit log,
>>>> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
>>>> distinction between early_init_dt_scan_chosen_serial() and
>>>> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
>>>> taught to properly decode of_serial driver bindings instead of a
>>>> stack of parameters to of_setup_earlycon().
>>>>
>>>> In fact, this patch allows a mis-defined devicetree to bring up a
>>>> functioning earlycon because the 'big-endian' property is directly
>>>> associated with UPIO_MEM32BE, which will create incompatibility problems
>>>> when DT earlycon is fixed to decode the of_serial DT bindings.
>>>
>>> That's a good point. This hasn't been merged yet, so there isn't any
>>> impact on addressing this. I would propose that for consistency, the
>>> earlycon code should always default to 8-bit access. if big-endian
>>> accesses are required, then reg-io-width + big-endian must be specified.
>>>
>>> Something like the following would do it and would be future-proof. We
>>> can add support for 16 or 64bit big or little endian access if it ever
>>> became necessary.
>>
>> I was planning on adding MEM32BE support to OF earlycon on top of my
>> patch series 'OF earlycon cleanup', which adds full support for the
>> of_serial driver DT properties (among other things).
> 
> Hi Peter,
> 
> This is my latest work-in-progress, incorporating the feedback from
> you and Grant:
> 
> https://github.com/cernekee/linux/commits/endian
> 
> Not sure if this code plays nice with your recent cleanups?  If we're
> touching the same files/functions we should probably coordinate.

Ok, I'll look over your git tree and add whatever's required to
earlycon.

> Also, it is untested, as I do not currently have access to BE systems.
> If I get desperate I can try it on an LE system, adding the big-endian
> properties in DT and then hacking the 8250 driver to swap LE accesses
> for BE accesses.

Ok.

Regards,
Peter Hurley
