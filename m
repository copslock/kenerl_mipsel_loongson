Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2003 15:05:51 +0100 (BST)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:3695 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225617AbTIZOFq>;
	Fri, 26 Sep 2003 15:05:46 +0100
Received: from rekin.icm.edu.pl (mail@rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.5/icm) with ESMTP id h8QE5Wqk014762
	for <linux-mips@linux-mips.org>; Fri, 26 Sep 2003 16:05:37 +0200 (CEST)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1A2r4z-0005C9-00
	for <linux-mips@linux-mips.org>; Fri, 26 Sep 2003 13:48:09 +0200
Date: Fri, 26 Sep 2003 13:48:09 +0200
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: [BUG?][linux_2_4] Oops in ip22-berr.c
Message-ID: <20030926114809.GB19876@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030924092828.GB21504@icm.edu.pl> <20030924103654.A15492@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924103654.A15492@linux-mips.org>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, Sep 24, 2003 at 10:36:54AM +0100, Ladislav Michl wrote:
[...] 
> nice to see bus error handler working :-)
> please apply following patch:
> ftp://ftp.linux-mips.org/pub/linux/mips/people/ladis/sgiwd93.diff

Sorry it took me so long to test it and reply. I have good news:
it works now. Thanks a lot.
I had to change the CFLAGS, however, to be able to compile with
gcc-3.3.1. Replacing -mcpu with -mtune in arch/mips/Makefile solved
the problem.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>
