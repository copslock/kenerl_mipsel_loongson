Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 17:42:14 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:62979 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842451AbaGWPmK28DNk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 17:42:10 +0200
Received: by mail-wi0-f171.google.com with SMTP id hi2so8023498wib.16
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=urA2RNg2D4FwtiAy634zi7lIUyYksPCEVwQLPjHHeEA=;
        b=hMbMLzKrcOpuGIZwUympFqgSzzhg08l+OCPpemzo7/b5ZBpsAK3SXTRTjayKeDvRHw
         jsJBN8T0iHFiG1QZPSVZAKMDoKPE1oi4YPOPsvP2xYl6YFr+ePHaoN8OWgGPlBxhnPXI
         y7MAhjv11dqG//M3CKktg6/F6F0BmdUITKi8SXO3CWOnJaYdxSB0DicU82zrdjMHEYrh
         uyhl93b9fwVSpQqmkqJpE1/zlGmJM1vmzIi3UULoXQUYj+YwnoR/hMgaNa2c5OpPpDmY
         B757kpBmrjAhWpUnkcAKLn5GDs+d9lbmOhRpX1iSOOzfT9e9qUfrVfTH8FSY4zA74FCM
         /7HA==
X-Received: by 10.194.89.106 with SMTP id bn10mr2831264wjb.121.1406130123147;
 Wed, 23 Jul 2014 08:42:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.26.4 with HTTP; Wed, 23 Jul 2014 08:41:23 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1727C2C8@AcuExch.aculab.com>
References: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
 <1406126186-471228-3-git-send-email-manuel.lauss@gmail.com> <063D6719AE5E284EB5DD2968C1650D6D1727C2C8@AcuExch.aculab.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 23 Jul 2014 17:41:23 +0200
Message-ID: <CAOLZvyEZLP=c1cgkp=szvJOEgfctGx16obPc+2KpG0fQ3hqQAA@mail.gmail.com>
Subject: Re: [PATCH 2/6] MIPS: Alchemy: move ethernet registers to ethernet driver
To:     David Laight <David.Laight@aculab.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, Jul 23, 2014 at 4:58 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Manuel Lauss
>> Move the register offsets and bit descriptions from the au1000.h header
>> to their only user, the au1000_eth.c driver.
>
> Personally I'd use 2 header files.
> One for the private data and one for the public data.
> It can be much easier to read code if the structure definitions are in
> a header file.

au1000.h now only contains core chip-specific code; this is the last
driver which
has driver-specific definitions living in the "chip-global" headers.
Eventually I'd like to get rid of au1000_eth.h as well :)

Manuel
