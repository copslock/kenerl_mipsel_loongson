Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 17:21:20 +0100 (CET)
Received: from mail-qg0-f44.google.com ([209.85.192.44]:56836 "EHLO
        mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009644AbaLWQVSW4aHb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 17:21:18 +0100
Received: by mail-qg0-f44.google.com with SMTP id q107so4827872qgd.3;
        Tue, 23 Dec 2014 08:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YMb1mvqxIgNCYgm81il/95+RBpVN6ymBg2ywpS8OXX8=;
        b=ZkdkDpCdN1uf4zeUcmB8dQuv9K9ev1DVXgQ7ZwfARvOdDZJQCMaI+NRloGPj+fRzJs
         S65IIS9ze/ivJCv3T9rvghVP8ummqXMLuIOIaciM+CPiFsjdfIckYsFo/5ryZez4mxCb
         1hTJZAXkts/SE/fV33MGzPP+6fPQ9/9CspQnZlu4+tYw+MYJhM7b5+pzYZg2itZmeQcl
         fJMAxTKsBcyhqs7tIgcLEwlK1lYbhE9d6V123DZFmcjVNJ+YvnrCb0X2k18kF4Wsehxi
         I0eb1hxJLZ/ka7MRIDHtajGo+CzvpAwq79nWYt5s2Un/3oaTO+eNQL5Wa33y5WV5SNBP
         c8vQ==
X-Received: by 10.140.34.67 with SMTP id k61mr32930905qgk.95.1419351672441;
 Tue, 23 Dec 2014 08:21:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Tue, 23 Dec 2014 08:20:52 -0800 (PST)
In-Reply-To: <CAGVrzcZPODEbQBF8Z+_r-6H3A_S-4Mi=1ALBf87ZmEngWzDpyw@mail.gmail.com>
References: <1419290863-19788-1-git-send-email-abrestic@chromium.org> <CAGVrzcZPODEbQBF8Z+_r-6H3A_S-4Mi=1ALBf87ZmEngWzDpyw@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Tue, 23 Dec 2014 08:20:52 -0800
Message-ID: <CAJiQ=7A0ZrNr0+mbHs1xJNDHEJMiG7v69XhEtCyWTYrBtX1zpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Move device-trees into vendor sub-directories
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Dec 23, 2014 at 8:07 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2014-12-22 15:27 GMT-08:00 Andrew Bresticker <abrestic@chromium.org>:
>> Move the MIPS device-trees into the appropriate vendor sub-directories.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  arch/mips/Makefile                                 |  2 +-
>>  arch/mips/boot/dts/Makefile                        | 33 ++++++++--------------
>>  arch/mips/boot/dts/bcm/Makefile                    |  9 ++++++
>>  arch/mips/boot/dts/{ => bcm}/bcm3384.dtsi          |  0
>>  arch/mips/boot/dts/{ => bcm}/bcm93384wvg.dts       |  0
>
> Let's use brcm here, which is the DT vendor prefix, or go full name
> with broadcom, there has been enough debate in the past about this ;)

IOW we want to see:

arch/mips/boot/dts/brcm/bcm3384.dtsi
arch/mips/boot/dts/brcm/bcm93384wvg.dts

right?  "brcm" for the vendor name, "bcmXXXX[X[X]]" for the chip
names, just like the compatible strings.

BTW, this will again create an ordering dependency with respect to my
Generic BMIPS patch series.  If Ralf can take Andrew's updated patches
ASAP (since they're straightforward renamings) it will make it easier
to add/rename platforms without having to fix up merge conflicts.
