Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 18:51:05 +0200 (CEST)
Received: from mail.lysator.liu.se ([130.236.254.3]:16606 "EHLO
	mail.lysator.liu.se") by lappi.linux-mips.net with ESMTP
	id S1102006AbYDAQur (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Apr 2008 18:50:47 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id EF000200A233;
	Tue,  1 Apr 2008 18:50:05 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06583-01-97; Tue, 1 Apr 2008 18:50:05 +0200 (CEST)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 67DC1200A231;
	Tue,  1 Apr 2008 18:50:05 +0200 (CEST)
Message-ID: <47F267BA.8050807@27m.se>
Date:	Tue, 01 Apr 2008 18:50:02 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	peter fuerst <post@pfrst.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28: fix MC GIOPAR setting
References: <Pine.LNX.4.58.0803211535570.423@Indigo2.Peter> <20080321194737.GA8398@alpha.franken.de> <Pine.LNX.4.58.0803212125050.523@Indigo2.Peter> <20080321213233.GA10546@alpha.franken.de> <20080401153655.GA15109@linux-mips.org>
In-Reply-To: <20080401153655.GA15109@linux-mips.org>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Thanks to O'Reilly in Germany, I've got an I^2, non-impact... I'll set
up an test enviroment for mips-linux there,
when I've got the time.

//Markus

Ralf Baechle wrote:
> On Fri, Mar 21, 2008 at 10:32:33PM +0100, Thomas Bogendoerfer
> wrote:
>
>>> Would indeed be most surprising, if this isn't appropriate for
>>> any Indigo2- Impact, but don't know for sure.  And can't check,
>>> whether it at least doesn't hurt Non-Impact Indigo2.  Of
>>> course, being able to avoid '#ifdef' at all would be the
>>> prettiest alternative.
>> I'll check my IP22 machines, if they are ok with that change.
>> Another solution could be to have gio_set_master() similair to
>> pci_set_master(). That way we only enable master, if it is
>> requested by a driver.
>
> That sounds like a clean solution.  Anyway where are we standing
> with this? I assume it's release critical for IP28?
>
> Ralf
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

iD8DBQFH8me16I0XmJx2NrwRCG5JAJ9vCHZhAVXD9GGwtVC8RBgaTun+rQCePUnE
uDmjdB3ii0qRasWST4pqaJc=
=LCvE
-----END PGP SIGNATURE-----
