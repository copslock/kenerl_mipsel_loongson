Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 14:32:14 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:44652 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1490984Ab0EEMcL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 14:32:11 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 17E3C27C010; Wed,  5 May 2010 14:32:09 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 099FB27C009;
        Wed,  5 May 2010 14:32:09 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 0CCA58458A;
        Wed,  5 May 2010 14:50:08 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 0400FFF855;
        Wed,  5 May 2010 14:32:15 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     Ben Dooks <ben@simtec.co.uk>
Cc:     yajin <yajinzhou@vm-kernel.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/12] add the sm501fb option to sm501 fb driver
References: <r2l180e2c241005040255mff483747jcef507aadea0cabd@mail.gmail.com>
        <4BE1614D.1090008@simtec.co.uk>
Organization: Mandriva
Date:   Wed, 05 May 2010 14:32:15 +0200
In-Reply-To: <4BE1614D.1090008@simtec.co.uk> (Ben Dooks's message of "Wed, 05 May 2010 21:15:09 +0900")
Message-ID: <m3wrviv8a8.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Ben Dooks <ben@simtec.co.uk> writes:

Hi,

> On 04/05/10 18:55, yajin wrote:
>> Currently the sm501 mode can only be fetched from modedb.c.
>> Unfortunately the modes in modedb.c are not complete. For example it
>> lacks the resolution of 1024x600. So the sm501 fb driver should have
>> the ability to accept the mode option from linux command line.
>
> Why not get this added to the main mode database instead of
> adding a new one into the sm501 driver?

fwiw, the original patch is putting it in the main database. Please
wait that all this stuff is sorted out. Theses patches are based on the
patches I'm working on and are adding some bugs in them.

Arnaud
