Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 14:01:43 +0200 (CEST)
Received: from p508B7090.dip.t-dialin.net ([80.139.112.144]:48060 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123916AbSJAMBm>; Tue, 1 Oct 2002 14:01:42 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g91C1Ki02361;
	Tue, 1 Oct 2002 14:01:20 +0200
Date: Tue, 1 Oct 2002 14:01:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Mike Nugent <mips@illuminatus.org>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@ftp.linux-mips.org: linux
Message-ID: <20021001140120.F616@linux-mips.org>
References: <20020929014920Z1121744-9213+239@linux-mips.org> <20020930.135717.39150888.nemoto@toshiba-tops.co.jp> <1033436801.13267.47.camel@templar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033436801.13267.47.camel@templar>; from mips@illuminatus.org on Mon, Sep 30, 2002 at 06:46:41PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 30, 2002 at 06:46:41PM -0700, Mike Nugent wrote:

> Suggestion for this bug:  Since the except_vec3_r4000 is a fix for the
> 4k series only, add 'default' statement as below:

The whole switch statement there is ever inflating and covers only a tiny
aspect of the CPU so I simply killed it.

  Ralf
