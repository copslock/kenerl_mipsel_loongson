Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 12:35:07 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14787 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030383AbXKBMfF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Nov 2007 12:35:05 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA2CYWOH014169;
	Fri, 2 Nov 2007 12:34:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA2CYUP8014168;
	Fri, 2 Nov 2007 12:34:30 GMT
Date:	Fri, 2 Nov 2007 12:34:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Denys Vlasenko <vda.linux@googlemail.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org,
	Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
Subject: Re: [IDE] Fix build bug
Message-ID: <20071102123428.GA14106@linux-mips.org>
References: <20071025135334.GA23272@linux-mips.org> <200710301134.30087.vda.linux@googlemail.com> <20071030124155.GA7582@linux-mips.org> <200711011843.16894.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200711011843.16894.vda.linux@googlemail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 06:43:16PM +0000, Denys Vlasenko wrote:

> We can intrduce new, ro sections or teach gcc that combining const objects into
> non-ro sections is not a crime. I wonder why it currently disallows that.
> (And it does it only _somethimes_, const pointers happily go into rw sections!)

The pattern seems to be that const-ness of the first object placed into
a particular section determines the writability of that section.  If that
conflicts with the requirements for a later object such as a non-const
object into a section r/o gcc doesn't consider making the section r/w
but throws an error instead.

  Ralf
