Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 12:25:12 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:8593 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20029907AbXKEMZD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 12:25:03 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 47498200A24A;
	Mon,  5 Nov 2007 13:24:59 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21638-01-99; Mon, 5 Nov 2007 13:24:56 +0100 (CET)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E3BA9200A229;
	Mon,  5 Nov 2007 13:24:55 +0100 (CET)
Message-ID: <472F0B96.4080205@27m.se>
Date:	Mon, 05 Nov 2007 13:24:54 +0100
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.14pre (X11/20071020)
MIME-Version: 1.0
To:	veerasena reddy <veerasena_b@yahoo.co.in>
Cc:	uclibc@uclibc.org, linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	buildroot@uclibc.org
Subject: Re: NPTL support
References: <279675.30374.qm@web8411.mail.in.yahoo.com>
In-Reply-To: <279675.30374.qm@web8411.mail.in.yahoo.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I don't use neither buildroot nor uClibc-nptl, due to uClibc-nptl is a
(dev-)branch and not a release. It differs quite a lot from the 0.9.29
release.

//Markus

veerasena reddy wrote:
> Hi Markus,
>
> thanks for the information.
>
> i checked out uclibc-nptl (version 0.9.29). is it a stable release?
>  If i want to build toolchain using buildroot with nptl support for
> linux kernel 2.6.18.8, could you please guide us the right version
> of buildroot, binutils, and gcc to be used.
>
> Thanks & Regards, Veerasena.
>
> ----- Original Message ---- From: Markus Gothe
> <markus.gothe@27m.se> To: veerasena reddy
> <veerasena_b@yahoo..co.in> Cc: uclibc@uclibc.org; linux-mips
> <linux-mips@linux-mips.org>; linux-kernel.org
> <linux-kernel@vger.kernel.org>; buildroot@uclibc.org Sent: Friday,
> 2 November, 2007 6:01:41 PM Subject: Re: NPTL support
>
> You'll have to use the uClibc-nptl branch on their svn. In 0.9.28,
> no.
>
> //Markus
>
> On 2 Nov 2007, at 06:03, veerasena reddy wrote:
>
>> Hi,
>>
>> I am trying to build the toolchain for MIPS processor using
>> buildroot. I am using gcc version of 3.4.3, binutils-2.15,
>> uclibc-0.9.28 and linux-2.6.18.8 kernel.
>>
>> Basically i need to enable NPTL feature support in my toolchain.
>> does uclibc-0.9.28 has the support for NPTL? If not, how can i
>> get it enabled for my above build configuration?
>>
>> I see there is separate branch "uclibc-nptl" in uclibc. Do i need
>> to use this (uclibc-nptl) to meet my requirement?
>>
>> Could you please suggest me right approach to succssfully enable
>> NPTL?
>>
>> Thanks in advance.
>>
>> Regards, Veerasena.
>>
>>
>> Why delete messages? Unlimited storage is just a click away. Go
>> to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/
>> tools-08.html
>>
>>
>
> _______________________________________
>
> Mr Markus Gothe Software Engineer
>
> Phone: +46 (0)13 21 81 20 (ext. 1046) Fax: +46 (0)13 21 21 15
> Mobile: +46 (0)73 718 72 80 Diskettgatan 11, SE-583 35 Linköping,
> Sweden www.27m.com
>
>
> Did you know? You can CHAT without downloading messenger. Go to
> http://in.messenger.yahoo.com/webmessengerpromo.php/
>
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
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHLwuS6I0XmJx2NrwRCLRDAJ9O5mtOAtncebZ9yTZoZpWQLD7hKwCghfdz
IlaSKs6XX+dD6dqC5YFYbRY=
=/Kz+
-----END PGP SIGNATURE-----
