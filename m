Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Oct 2009 12:46:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36398 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492660AbZJaLq4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 31 Oct 2009 12:46:56 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9VBYnPV011754;
	Sat, 31 Oct 2009 12:40:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9VBYktg011655;
	Sat, 31 Oct 2009 12:34:46 +0100
Date:	Sat, 31 Oct 2009 12:34:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ralf =?iso-8859-1?Q?R=F6sch?= <ralf.roesch@rw-gmbh.de>
Cc:	linux-mips@linux-mips.org, sam@ravnborg.org, manuel.lauss@gmail.com
Subject: Re: mips: fix build of vmlinux.lds
Message-ID: <20091031113446.GA3172@linux-mips.org>
References: <4AEAEF43.7060200@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AEAEF43.7060200@rw-gmbh.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 30, 2009 at 02:50:59PM +0100, Ralf Rösch wrote:

> could you please cherry-pick commit   
> fd6b6a85c525824bece9543fae5ed68c00ad65a7
> (or fd6b6a85c525824bece9543fae5ed68c00ad65a7, seems to be identical)

Identical numbers tend to be identical ;-)

> to linux-2.6.31-stable branch and may be others too ?

Done.  Thanks!

  Ralf
