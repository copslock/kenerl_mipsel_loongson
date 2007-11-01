Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 16:46:15 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:31152 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20026235AbXKAQqH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 16:46:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E377C200A37F;
	Thu,  1 Nov 2007 17:45:35 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13672-01-60; Thu, 1 Nov 2007 17:45:35 +0100 (CET)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 80E8A200A1E8;
	Thu,  1 Nov 2007 17:45:35 +0100 (CET)
Message-ID: <472A02AE.5060501@27m.se>
Date:	Thu, 01 Nov 2007 17:45:34 +0100
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.14pre (X11/20071020)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Hyon Lim <alex@alexlab.net>, linux-mips@linux-mips.org
Subject: Re: [SPAM] Re: MIPS assembly directives in GCC
References: <dd7dc2bc0711010536l18f9f2f6gbda4e9ef1158da61@mail.gmail.com> <20071101142625.GQ7712@networkno.de>
In-Reply-To: <20071101142625.GQ7712@networkno.de>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Thiemo Seufer wrote:
> Hyon Lim wrote:
>> I investigated kernel assembly source code in my kernel (2.6.10).
>>  I found that there are a lot of assembly directives (e.g.,
>> .align, .set reorder, .cpload, .frame etc.). Is there any
>> documents which explains those directives? (not only I described
>> above. All of directives)
>
> Short of reading the assembler sourcecode I believe the best
> document is "See MIPS Run Linux".
>
>
> Thiemo
>
Use the source Luke (or Google)... I think if you'vent got a clue
about assembler (or anything else you're doing) you need to do some
research before asking, that's my not so humble opinion.

- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHKgKr6I0XmJx2NrwRCNxEAJ9S1pVnCyBRismBGVoD/lBl119l2gCg0uDy
U4la1KpQWb3zAJfR/Y9Ph0U=
=lSeG
-----END PGP SIGNATURE-----
