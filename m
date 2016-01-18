Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 20:10:02 +0100 (CET)
Received: from mail-io0-f174.google.com ([209.85.223.174]:35067 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010990AbcARTJ7Ep-Ka convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jan 2016 20:09:59 +0100
Received: by mail-io0-f174.google.com with SMTP id 77so526883835ioc.2
        for <linux-mips@linux-mips.org>; Mon, 18 Jan 2016 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VZb9Y7VT4cwDHB+/hmLP195NskPWEJv13lEnkpTvJtw=;
        b=QSRYnO1XZsigMgti5o+AF8T6LIMDflzIr1WLrwAN1alRi6MfZ3qyepAohJHUaoLeCR
         yzX44CYieFWzCvSdBvJApmfm+E1/88PszPS7+ecF+utE6MWxUgrjF/6DIfbw8ngr6Ubx
         RCZIu4lygZ+RqV8PO4wkLpZSWqz+mAyDsoPCCwMHrlhqvrB8qbKtaqhneYIfjAo8I01G
         GAIiCx/jtstwFnGcDfllh4qAfMqkQ5kDT2dKa54k+708vGZa0iLIogTyrUpT9ad7L8Hg
         bs1K23JIq+NZjIBFLcxtOvHD+siubwTKLxnexcVtpZHwQNauiRGMV9p9CSb3pdCn3f/a
         RLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VZb9Y7VT4cwDHB+/hmLP195NskPWEJv13lEnkpTvJtw=;
        b=OSkSulu1ytNiFxhS721CeZXMUQEW382jKSsAfwbSBdq0ok7MbmBiKmr+14Vez/4Z3g
         kxMEvVdf3j1xIOK+A8fYz5IaHFYE9fadokH18fXULSZV7txT2MNdVZyx+FeNXO2hvT28
         Vq0xLtl8OIKEREAMS3vupSvMyi/ncCCMagaiSwNu4I/cKkCvY1Cz42Rm/kl6bg5qhd4Y
         zsHHX/XhiQWIS932zRZkWsWcIk9fDbKcag5pK7p6zy4Pyzv8tJ9JtrWypYmD8PZJE0NL
         E90WILarO1LRRuxucSh8shf9RQV/9h4ozFTHexQyI4pc9O8A+s1Dvgc7gTydTdHBC8v0
         mm4g==
X-Gm-Message-State: ALoCoQlPXMnMPRQt9dNnHBo+BOfHx3fSueN9TQFRjFvgCOsxi508J+PgHlltJIhCpKsEW2809a/mTiswVVX14EESKNr3L7baxg==
MIME-Version: 1.0
X-Received: by 10.107.168.203 with SMTP id e72mr22874294ioj.96.1453144192981;
 Mon, 18 Jan 2016 11:09:52 -0800 (PST)
Received: by 10.107.149.16 with HTTP; Mon, 18 Jan 2016 11:09:52 -0800 (PST)
In-Reply-To: <20160118175303.19164539@wiggum>
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
        <4037550.DMaVTE01Aq@wuerfel>
        <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
        <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
        <87y4bn5m4q.fsf@kamboji.qca.qualcomm.com>
        <20160118175303.19164539@wiggum>
Date:   Mon, 18 Jan 2016 20:09:52 +0100
Message-ID: <CACna6ry2jSJpov1Mcvk=NF+GKrZVSHKjOsinpEQh7_BQAx34wQ@mail.gmail.com>
Subject: Re: ssb: Set linux-wireless as MAINTAINERS list
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51201
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

On 18 January 2016 at 17:53, Michael Büsch <m@bues.ch> wrote:
> ssb patches go through the linux-wireless tree.
> Set the list to linux-wireless, so linux-wireless patchwork can catch the patches.

Thanks Michael
