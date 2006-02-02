Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 17:01:19 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:9989 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465647AbWBBRBC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 17:01:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12H63kS021301;
	Thu, 2 Feb 2006 17:06:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12H62kS021300;
	Thu, 2 Feb 2006 17:06:02 GMT
Date:	Thu, 2 Feb 2006 17:06:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Optimize swab operations
Message-ID: <20060202170602.GB5273@linux-mips.org>
References: <cda58cb80601260308v3eecf0d0w@mail.gmail.com> <20060126120114.GD3411@linux-mips.org> <cda58cb80602020232r36241faeh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80602020232r36241faeh@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 02, 2006 at 11:32:05AM +0100, Franck Bui-Huu wrote:

> I'm a bit disapointed the way you do it. You changed the patch
> (wrongly) and the authorships. At least you could have said: "thanks
> to" in your commit message. Bad experience for my first patch...

Sorry, yesterday was an extremly chaotic day and I had my thoughts
elsewhere ...

When applying an emailed patch my scripts (git-applymbox that is) usually
take care of proper attribution to people but since I had to edit your
patch manually that didn't happen automatically.

  Ralf
