Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 09:38:10 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:33696 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S20024742AbZDIIiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 09:38:03 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 633D0274006; Thu,  9 Apr 2009 10:38:02 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 8E28D274003;
	Thu,  9 Apr 2009 10:38:00 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 811C38294E;
	Thu,  9 Apr 2009 10:40:51 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id CA0E8FF855;
	Thu,  9 Apr 2009 10:39:26 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	yanhua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 1/14] lemote: Loongson2F based machines support
References: <49DD7E88.7040305@lemote.com>
Organization: Mandriva
Date:	Thu, 09 Apr 2009 10:39:26 +0200
In-Reply-To: <49DD7E88.7040305@lemote.com> (yanhua's message of "Thu, 09 Apr 2009 12:50:16 +0800")
Message-ID: <m3prfm6x1d.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

yanhua <yanh@lemote.com> writes:

Hi,


> Mini fuloong, yeeloong are all Loongson2F based systems. Loongson2F have
> builtin DDR2 and PCIX controller. The PCIX controller have a similar
> programming interface with FPGA northbridge used in Loongson2E.

First, please read Documentation/SubmittingPatches first. There's no
signed-off-by and this patch is too big. So big patches are making
review a nightmare, please split it into smaller pieces :(

Also, I'd like to see a different directories layout. You're doing :
arch/mips/lemote/
    lm2e/
    lm2f/
        common/
        fuloong/
        yeeloong/

This is quite annoying because:
- I'll prefer seeing loongson instead of Lemote. I've some ST machines
  here they do share a lot of code with the 2e/2f so I'd like to avoid
  duplicating code.

- There's some code very similar between 2e, 2f-yeelong and
  2f-fuloong and other machines. Why not putting them in a common
  directory instead of duplicating again some code ?

To sum up, imho, it would be better to have something like :
arch/mips/loongson/
    common/
    2e/
    2f/ (or something similar)
       common/
       yeelong/
       fuloong/
       ...

Arnaud
