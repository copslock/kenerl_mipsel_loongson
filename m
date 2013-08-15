Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Aug 2013 13:52:49 +0200 (CEST)
Received: from mail-we0-f175.google.com ([74.125.82.175]:39626 "EHLO
        mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816122Ab3HOLwlAGB4W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Aug 2013 13:52:41 +0200
Received: by mail-we0-f175.google.com with SMTP id q58so483060wes.34
        for <linux-mips@linux-mips.org>; Thu, 15 Aug 2013 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VVTcedpdEHj26rJzkba0v33Bld+RZr+PiPFrRT1Mj38=;
        b=vvFHkHusgx1Nf90Un/shaXS/ucuVkPth8BKJ9QT/ljp4DYdPcRk75G1gE+aZn8iYci
         E85x1lPag9imHqThUOfRKN1mBJ9nakSly2pSrzJwAq6kCYxNCqTOTFWtO0GaFYJnv36s
         kNZNihX9KRUbACBC+3RNApKW57jfot2k4RbhiITSZwMhCMc2yKxIsA1YXfYZQ5HjCjW0
         5dmswxq8ZVslES/GD7VFvnvdh8SvBJhANX5jy2cbjbx2uaYu25TxYtkDcHvTtVrm+0zm
         Y69IG3h1BzpxytK2pGZZ7HzHghX0l76JvafNpwea2Wh4UICIiyZdOZ6poYAMqnqgi91R
         LAIA==
X-Received: by 10.180.75.239 with SMTP id f15mr1572753wiw.42.1376567555680;
 Thu, 15 Aug 2013 04:52:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.162.168 with HTTP; Thu, 15 Aug 2013 04:51:55 -0700 (PDT)
In-Reply-To: <520CB905.1000700@cogentembedded.com>
References: <1376555267-1633-1-git-send-email-markos.chandras@imgtec.com> <520CB905.1000700@cogentembedded.com>
From:   Markos Chandras <markos.chandras@gmail.com>
Date:   Thu, 15 Aug 2013 12:51:55 +0100
Message-ID: <CAG2jQ8hDNprNa6D1R-VwyyN_b_uaHpKUvb6bmchDkp4SOxpB2Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: netlogic: xlr: Serial support depends on CONFIG_SERIAL_8250
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37560
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

Hi Sergei,

On 15 August 2013 12:18, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
>
>    It's better to follow what Documentation/Submitting patches suggest and
> add:
>
> #else
> static inline void nlm_early_serial_setup(void) {}
>
>> +#endif
>>

Thank you for the review. I will submit a new patch.

-- 
Regards,
Markos Chandras
