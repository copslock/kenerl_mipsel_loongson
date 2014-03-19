Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 07:43:31 +0100 (CET)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34815 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821115AbaCSGn3Rwpqy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 07:43:29 +0100
Received: by mail-oa0-f49.google.com with SMTP id h16so2623415oag.22
        for <multiple recipients>; Tue, 18 Mar 2014 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4ycbFsFQ+fdBZk44wf3Te2/7qrwHDhbsbE3dFc3sjg0=;
        b=ujlbJRwVQFb5fAePiZK9nqJONIxca96290omOjkeFK4Dq7EQyhp/swrin2gjA4EXkX
         JIsD8cH3hWJMeJZ9vxCvbgn5jFVfgEdNLjxVeXJknQ6txu5Y5/XOh2hD0nNGRCR7BUf+
         KytCditlkpBTSce7ZsCkF8Jy7V8ZH1gARZCl9fOImuZpdQ1XVovPndV/A9fUkSZEnvmj
         tSrCjKajnYv9wECyfQKHDDopz+lXhuCGDmh24t1MCipnfsk4Bk/KdcJMYttkvtua0ZX9
         qRXM60Mqh4fSKVWBWY3VOGlh1gPRXVOlTHrLPfIXs0E6Lo6jAWWa+4GL6VfmUf/SfHG2
         D8Dg==
MIME-Version: 1.0
X-Received: by 10.182.194.103 with SMTP id hv7mr552051obc.30.1395211397226;
 Tue, 18 Mar 2014 23:43:17 -0700 (PDT)
Received: by 10.76.33.230 with HTTP; Tue, 18 Mar 2014 23:43:17 -0700 (PDT)
In-Reply-To: <53237502.20305@hauke-m.de>
References: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
        <53237502.20305@hauke-m.de>
Date:   Wed, 19 Mar 2014 07:43:17 +0100
Message-ID: <CACna6rwzB_eD+SfTo6gc20ec9O4-0+6R5ZajgEMuqx6fzHnumg@mail.gmail.com>
Subject: Re: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when
 looking for a pin
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39500
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

2014-03-14 22:30 GMT+01:00 Hauke Mehrtens <hauke@hauke-m.de>:
> On 02/13/2014 05:48 PM, Rafał Miłecki wrote:
>> Broadcom boards support 32 GPIOs and NVRAM may have entires for higher
>> ones too. Example:
>> gpio23=wombo_reset
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Ralf: could you get it for 3.15 at least, please?
