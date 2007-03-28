Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 15:48:42 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:42646 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20023089AbXC1Osf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 15:48:35 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 32158200A1E8;
	Wed, 28 Mar 2007 16:47:56 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20234-01-94; Wed, 28 Mar 2007 16:47:55 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 1E1BE200A1E7;
	Wed, 28 Mar 2007 16:47:49 +0200 (CEST)
Message-ID: <460A8014.1020100@27m.se>
Date:	Wed, 28 Mar 2007 16:47:48 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.10 (X11/20070307)
MIME-Version: 1.0
To:	Attila Kinali <attila@kinali.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: Power loss and system time when not having a battery backed RTC
References: <20070328163914.b7187fcb.attila@kinali.ch>
In-Reply-To: <20070328163914.b7187fcb.attila@kinali.ch>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Attila Kinali wrote:
> Moin,
>
> I have a little bit more general question than usual. I have here a
> system that should be deployed in Joe Average's house as a small
> appliance. While it is powered it will gather information and store
> them on its flash.
>
> Now, this system does not contain a battery backed RTC (not enough
> space) and thus does not know what date/time it is after boot. At a
> later time the device will be able to get a time quote from a time
> server using a wireless connection. But as the wireless connection
> is triggered by a user action, it can happen hours after boot. This
> means that there is a quite long period whithin which the device
> does not know what time it is and hence assumes it's 1970.
>
> My problem lies now in the back jumps that the device makes, when
> unplugged and replugged. On the filesystem there will be files from
> 2007, while the system still thinks it's 1970.
>
> How do you handle this issue with the back jumps, if you cannot
> stick in a batter backed RTC?
>
>
> Thanks for your help
>
> Attila Kinali
Be creative or use the battery, you could for example set a timestamp
in a file at shutdown and use it to set the date on power up, alas
this would be incorrect, so go for the battery.

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

iD8DBQFGCoAR6I0XmJx2NrwRCNbtAJ9jMBSxe0WOvv3o844TCqbHKbmgOwCeNmOR
Uot4Bwa7+EYx3/8b7h4bVcM=
=X6k4
-----END PGP SIGNATURE-----
