Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 10:42:33 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:29629 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S29041194AbYISJmG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 10:42:06 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2F72A223C31E;
	Fri, 19 Sep 2008 11:42:03 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26750-01-73; Fri, 19 Sep 2008 11:42:02 +0200 (CEST)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 31B8C200A783;
	Fri, 19 Sep 2008 11:42:02 +0200 (CEST)
Message-ID: <48D373E9.70403@27m.se>
Date:	Fri, 19 Sep 2008 11:42:01 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Klatt Uwe <U.Klatt@miwe.de>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: [SPAM] Same mipsel binary =?UTF-8?B?ZsO8ciAyLjQgYW5kIDIuNiBr?=
 =?UTF-8?B?ZXJuZWwgcG9zc2libGU/?=
References: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
In-Reply-To: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Looks like the FPU-Emulator isn't working. Which kernel versions are
you using?

//Markus

Klatt Uwe wrote:
> Hello,
>
> I have a custom hardware (AU1100) with kernel 2.4 and an working binary
using floats (compiled with gcc 3.3.5).
> Now I am testing with kernel 2.6.
>
> When I use the old binary, float math isn't working anymore.
> I have to recompile the source with new gcc 4.1.2 but then the new
binary is working only on kernel 2.6.
>
> Can somebody give me some hints, how to chage settings for kernel 2.6
creation or compiler settings to generate an universal binary.
>
> Thanks
> Uwe
>


- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFI03Pn6I0XmJx2NrwRCH4eAJwMWR2/SrFaWRJAWMul9sK/GvATdQCaAgmJ
LnzfYvUmO6mzyV5QMKtCmKs=
=dP4U
-----END PGP SIGNATURE-----
