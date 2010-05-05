Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 15:17:41 +0200 (CEST)
Received: from mail-vw0-f48.google.com ([209.85.212.48]:62580 "EHLO
        mail-vw0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492061Ab0EENRh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 15:17:37 +0200
Received: by vws13 with SMTP id 13so4067211vws.35
        for <linux-mips@linux-mips.org>; Wed, 05 May 2010 06:17:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.214.147 with SMTP id ha19mr4201094qcb.90.1273065449454; 
        Wed, 05 May 2010 06:17:29 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Wed, 5 May 2010 06:17:29 -0700 (PDT)
In-Reply-To: <m3wrviv8a8.fsf@anduin.mandriva.com>
References: <r2l180e2c241005040255mff483747jcef507aadea0cabd@mail.gmail.com>
         <4BE1614D.1090008@simtec.co.uk> <m3wrviv8a8.fsf@anduin.mandriva.com>
Date:   Wed, 5 May 2010 21:17:29 +0800
Message-ID: <o2u180e2c241005050617h299beefdm2fd046c94bdf3101@mail.gmail.com>
Subject: Re: [PATCH 10/12] add the sm501fb option to sm501 fb driver
From:   yajin <yajinzhou@vm-kernel.org>
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     Ben Dooks <ben@simtec.co.uk>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Hi,

>> Why not get this added to the main mode database instead of
>> adding a new one into the sm501 driver?

> fwiw, the original patch is putting it in the main database.

According to the Documentation/fb/modedb.txt, that's because the
modedb.c provides one generic video mode database with a fair amount
of standard videomodes. Yes, 1024x600 can be added to maindb, but I am
wondering whether it is a generic video mode. If so, there should be
1024x600 in main database already.

yajin

http://vm-kernel.org



2010/5/5 Arnaud Patard <apatard@mandriva.com>:
> Ben Dooks <ben@simtec.co.uk> writes:
>
> Hi,
>
>> On 04/05/10 18:55, yajin wrote:
>>> Currently the sm501 mode can only be fetched from modedb.c.
>>> Unfortunately the modes in modedb.c are not complete. For example it
>>> lacks the resolution of 1024x600. So the sm501 fb driver should have
>>> the ability to accept the mode option from linux command line.
>>
>> Why not get this added to the main mode database instead of
>> adding a new one into the sm501 driver?
>
> fwiw, the original patch is putting it in the main database. Please
> wait that all this stuff is sorted out. Theses patches are based on the
> patches I'm working on and are adding some bugs in them.
>
> Arnaud
>
