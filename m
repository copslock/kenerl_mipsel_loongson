Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jun 2003 10:06:32 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8224821AbTFUJG2>; Sat, 21 Jun 2003 10:06:28 +0100
Date: Sat, 21 Jun 2003 10:06:28 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Brian Murphy <brm@murphy.dk>, Ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.4] cpu-probe.c error
Message-ID: <20030621100628.A31107@ftp.linux-mips.org>
References: <E19TPHY-0002ih-00@brian.localnet> <1056128905.10307.4.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056128905.10307.4.camel@zeus.mvista.com>; from ppopov@mvista.com on Fri, Jun 20, 2003 at 10:08:25AM -0700
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 20, 2003 at 10:08:25AM -0700, Pete Popov wrote:
> 
> FYI, I had tried the same patch and it works fine on my boards. I think
> mips64 may be broken as well, if I remember correctly.

FYI, I sent patch which fixes mips/mips64; 2.4/2.5 at Mon, 16 Jun 2003
16:13:07 +0200 with subject "[PATCH] cpu-probe compile fix" and
Message-ID: <20030616141307.GA16721@simek>
Ralf could you please apply that one?

	ladis
