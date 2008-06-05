Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 22:34:19 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:58838 "HELO smtp.movial.fi")
	by ftp.linux-mips.org with SMTP id S28575864AbYFEVeQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 22:34:16 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id E13B6C803F;
	Fri,  6 Jun 2008 00:34:10 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 9J+EoFurkprS; Fri,  6 Jun 2008 00:34:10 +0300 (EEST)
Received: from webmail.movial.fi (webmail.movial.fi [62.236.91.25])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id C20FDC801D;
	Fri,  6 Jun 2008 00:34:10 +0300 (EEST)
Received: by webmail.movial.fi (Postfix, from userid 33)
	id B037023CD79; Fri,  6 Jun 2008 00:34:10 +0300 (EEST)
Received: from 84.249.59.97
        (SquirrelMail authenticated user dvorobye)
        by webmail.movial.fi with HTTP;
        Fri, 6 Jun 2008 00:34:10 +0300 (EEST)
Message-ID: <38408.84.249.59.97.1212701650.squirrel@webmail.movial.fi>
In-Reply-To: <20080605183854.GN25477@mit.edu>
References: <20080512130604.GA15008@deprecation.cyrius.com>
    <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
    <20080512143426.GB7029@mit.edu>
    <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com>
    <20080513045028.GC22226@linux-mips.org>
    <20080528070637.GA10393@deprecation.cyrius.com>
    <20080605111148.GA4483@deprecation.cyrius.com>
    <1212664977.4840.6.camel@sd048.hel.movial.fi>
    <20080605183854.GN25477@mit.edu>
Date:	Fri, 6 Jun 2008 00:34:10 +0300 (EEST)
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
From:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>
To:	"Theodore Tso" <tytso@MIT.EDU>
Cc:	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>,
	"Martin Michlmayr" <tbm@cyrius.com>,
	"Ralf Baechle" <ralf@linux-mips.org>,
	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
X-Priority: 3 (Normal)
Importance: Normal
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Theodore Tso wrote:
>
> If you really insist I suppose we could have a MIPS specific patch
> where we allocate a 4k page and zero it, so we can use it from our
> kernel code because you don't want to export and make available the
> ZERO_PAGE that gets used by the rest of the kernel, but that seems
> awfully silly, and would be a waste of 4k of memory.....  Someone from
> MIPS land would have to test it, as well, as I dont think any of the
> ext4 developers have access to a MIPS platform.

Ted, Ralf seems to be unwilling to accept the ZERO_PAGE() export. If you
send the MIPS-specific patch, I can do the testing for you as I have a
MIPS Malta board at my disposal.

Thanks,
Dmitri
