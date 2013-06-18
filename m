Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 15:19:04 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60646 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3FRNSkdpx6T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 15:18:40 +0200
Received: by mail-wi0-f182.google.com with SMTP id m6so3211503wiv.15
        for <multiple recipients>; Tue, 18 Jun 2013 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pkdFcgZfYXUpk+zAPdfpGSutqs9PPHlsHH0tCEHOwnI=;
        b=w49vVX+UP4yBO9L1k6sk9MmuSwjgOQodAX9ovDgyFXGzJ7aD/o37ZgO7ZgS/9GTDGI
         eBPq6H48BbgejMSgZ/63sKkRT0qBCo9trJkegVLwTqzTRPg3o/EGxpiquep2AWT5CXxp
         e/2nGVREfMUHBDw1um/6+vsRYj0WySN8jMmbpnubsov42CGlHd/ffQVnA2oD8we/aozx
         oGEtvDwA2N76xBCdMopMva2JZ+8dpM0Js3LQ19xsOfYbnJ4nwraJqvRykM9PM7SFHVyj
         V1X/CToBqmfMNANC2b2cXgnT9mUb0u3v5qCtSEdHXYcfrMHlgZr8MdZ5MKuOFA+t+9Eo
         001A==
X-Received: by 10.180.211.202 with SMTP id ne10mr3690660wic.39.1371561514863;
 Tue, 18 Jun 2013 06:18:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.136.115 with HTTP; Tue, 18 Jun 2013 06:17:54 -0700 (PDT)
In-Reply-To: <20130617170304.GF10408@linux-mips.org>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
 <1371477641-7989-6-git-send-email-markos.chandras@imgtec.com> <20130617170304.GF10408@linux-mips.org>
From:   Markos Chandras <markos.chandras@gmail.com>
Date:   Tue, 18 Jun 2013 14:17:54 +0100
Message-ID: <CAG2jQ8j8vbeNK9YD2C0WgDOxS5PNxz88M1er543VRCf=zongxA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking problems
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@gmail.com
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

On 17 June 2013 18:03, Ralf Baechle <ralf@linux-mips.org> wrote:
>> @@ -208,7 +209,9 @@ static long sbwdog_ioctl(struct file *file, unsigned int cmd,
>>                * get the remaining count from the ... count register
>>                * which is 1*8 before the config register
>>                */
>> -             ret = put_user(__raw_readq(user_dog - 8) / 1000000, p);
>> +             tmp_user_dog = __raw_readq(user_dog - 8);
>> +             tmp_user_dog = do_div(tmp_user_dog, 1000000);
>> +             ret = put_user(tmp_user_dog, p);
>
> In effect the code with your change now does:
>
>                 ret = put_user(__raw_readq(user_dog - 8) % 1000000, p);
>
> No good.
>
>                 tmp_user_dog = __raw_readq(user_dog - 8);
>                 do_div(tmp_user_dog, 1000000);
>                 ret = put_user(tmp_user_dog, p);
>
> Should to the right thing.
>

Hi Ralf,

Yes you are right. I will submit a new patch.

--
Regards,
Markos Chandras
