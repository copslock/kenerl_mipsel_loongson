Received:  by oss.sgi.com id <S553757AbQJXMKy>;
	Tue, 24 Oct 2000 05:10:54 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:36107 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553742AbQJXMKs>;
	Tue, 24 Oct 2000 05:10:48 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B1FF080B; Tue, 24 Oct 2000 14:10:45 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EC013900C; Tue, 24 Oct 2000 14:08:58 +0200 (CEST)
Date:   Tue, 24 Oct 2000 14:08:58 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Randall Craig <randall@suse.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: R5000SC
Message-ID: <20001024140858.F3795@paradigm.rfc822.org>
References: <20001023213530.A32077@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001023213530.A32077@suse.com>; from randall@suse.com on Mon, Oct 23, 2000 at 09:35:30PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 23, 2000 at 09:35:30PM -0700, Randall Craig wrote:

> The machine seems seems to have Secondary unified cache.  Could anyone
> confirm that this machine is not supported.

Even without Secondary Cache there are problems with R5000.

>      1 180 MHZ IP22 Processor
>      FPU: MIPS R5000 Floating Point Coprocessor Revision: 1.0
>      CPU: MIPS R5000 Processor Chip Revision: 2.1

I got a 150Mhz IP22 (Indy) without secondary cache and i see
very strange things happen with 2.4.0-test9 (2.2.14 was reported
to work)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
