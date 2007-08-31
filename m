Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 15:50:29 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:7150 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20022991AbXHaOuU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Aug 2007 15:50:20 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 43A48200A202;
	Fri, 31 Aug 2007 16:50:18 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27125-01-98; Fri, 31 Aug 2007 16:50:15 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B8B3F200A1EC;
	Fri, 31 Aug 2007 16:50:12 +0200 (CEST)
Message-ID: <46D82A9F.5080001@27m.se>
Date:	Fri, 31 Aug 2007 16:50:07 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.12 (X11/20070730)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46D8089F.3010109@gmail.com>
In-Reply-To: <46D8089F.3010109@gmail.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Ralf added this a while ago:

"arch/mips/mm/cache.c:void __flush_dcache_page(struct page *page)"

//Markus

Franck Bui-Huu wrote:
> Hi,
>
> I noticed that there's currently (v2.6.23-rc4) no implementation of
> this function even for mips CPUs that have dcache aliasing.
>
> Could anybody explain why ?
>
> thanks, Franck
>


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

iD8DBQFG2Cqe6I0XmJx2NrwRCNouAKDTex/fiBt4qJgX15tW4TzwQct7DQCgi6sE
GNFJZe/vjsW3z/FQw01yxx0=
=RFVE
-----END PGP SIGNATURE-----
