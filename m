Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2012 21:28:52 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:43765 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903679Ab2EGT2q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 May 2012 21:28:46 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q47JSX5O011050;
        Mon, 7 May 2012 12:28:35 -0700
Received: from [192.168.65.146] (192.168.65.146) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 7 May 2012
 12:28:32 -0700
Message-ID: <4FA8225F.1030401@mips.com>
Date:   Mon, 7 May 2012 12:28:31 -0700
From:   Leonid Yegoshin <yegoshin@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] Revert "MIPS: cache: Provide cache flush operations for
 XFS"
References: <1333987989-1178-1-git-send-email-sjhill@mips.com> <CAJiQ=7AjtSB8KQ9+edUOvW+70nAWzh6c8B26ehnEpuud6QeMJA@mail.gmail.com>,<4F8475F7.9060809@mips.com> <31E06A9FC96CEC488B43B19E2957C1B80114692038@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B80114692038@exchdb03.mips.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: QelUtygNq6LlvReQY+eWww==
X-archive-position: 33179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Steven,

On 05/07/2012 12:21 PM, Hill, Steven wrote:
> Leonid,
>
> I am dropping this patch for the 3.5 release too.
>
> -Steve

I don't care - we still have it in internal repo, right?

Sometime this/next month I will create a second patch for L1 only 
flushing optimization in this case and we can repeat it in future 
release. Unfortunately, right these weeks I have no time for that 
optimization, sorry for that.

Thank you,

- Leonid.
