Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 09:29:10 +0000 (GMT)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:40240
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225356AbTJ1J2i>; Tue, 28 Oct 2003 09:28:38 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.11.7/8.11.7) with ESMTP id h9SASSv25100;
	Tue, 28 Oct 2003 13:28:28 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA31641; Tue, 28 Oct 2003 13:30:04 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id h9S9IWXv004724;
	Tue, 28 Oct 2003 12:18:32 +0300 (MSK)
Message-ID: <3F9E346A.B57D80EC@niisi.msk.ru>
Date: Tue, 28 Oct 2003 12:18:34 +0300
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Zhang Haitao <zhanght@netpower.com.cn>
CC: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Packages for RH 7.3/mips
References: <000001c39996$c9f5d020$800101df@radium> <1066936052.22664.66.camel@zeus.mvista.com> <3F9833C9.6070005@realitydiluted.com> <20031024124355.GB27437@linux-mips.org> <3F9A5DE8.5080308@netpower.com.cn>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Zhang Haitao wrote:
> all your source package can be compiled using mipsel cross compiler and
> running on little endian machine?
Most of them.

> would you mind publish your RPMs with src tarballs (or patches) at the
> same time?

Yes.

> or can you rebuild your distribution for mipsel?

No, I can't. I haven't a LE mips box to test them.

I'd like to note we solve problems related to BE mips boxes. LE ones
have a better support in HJL's RH 7.3/mips distribution due to the fact
ix86 is LE too.

No wonder, I expect several of our packages can't be compiled for LE,
but it's easy to fix. More importand all  packages but glibc-{locales,
timezones} can be cross-compiled.

Regards,
Gleb.
