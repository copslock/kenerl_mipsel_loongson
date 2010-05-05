Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 15:31:13 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:37278 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492083Ab0EENbK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 15:31:10 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 9144727C016; Wed,  5 May 2010 15:31:08 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id A79F827C015;
        Wed,  5 May 2010 15:31:07 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id E44AA8427F;
        Wed,  5 May 2010 15:49:06 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id B2203FF855;
        Wed,  5 May 2010 15:31:14 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     yajin <yajinzhou@vm-kernel.org>
Cc:     Ben Dooks <ben@simtec.co.uk>, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/12] add the sm501fb option to sm501 fb driver
References: <r2l180e2c241005040255mff483747jcef507aadea0cabd@mail.gmail.com>
        <4BE1614D.1090008@simtec.co.uk> <m3wrviv8a8.fsf@anduin.mandriva.com>
        <o2u180e2c241005050617h299beefdm2fd046c94bdf3101@mail.gmail.com>
Organization: Mandriva
Date:   Wed, 05 May 2010 15:31:14 +0200
In-Reply-To: <o2u180e2c241005050617h299beefdm2fd046c94bdf3101@mail.gmail.com> (yajin's message of "Wed, 5 May 2010 21:17:29 +0800")
Message-ID: <m3sk66v5jx.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

yajin <yajinzhou@vm-kernel.org> writes:

> Hi,
>
>>> Why not get this added to the main mode database instead of
>>> adding a new one into the sm501 driver?
>
>> fwiw, the original patch is putting it in the main database.
>
> According to the Documentation/fb/modedb.txt, that's because the
> modedb.c provides one generic video mode database with a fair amount
> of standard videomodes. Yes, 1024x600 can be added to maindb, but I am
> wondering whether it is a generic video mode. If so, there should be

afair it is fairly generic

> 1024x600 in main database already.

Not seeing a mode is the database doesn't mean it shouldn't go
there. It may only mean that nobody needed it before.

Arnaud
