Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 18:11:57 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225215AbTEMRLw>; Tue, 13 May 2003 18:11:52 +0100
Date: Tue, 13 May 2003 18:11:52 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: memory for exception vectors
Message-ID: <20030513181152.A5160@ftp.linux-mips.org>
References: <20030512115641.F17151@ftp.linux-mips.org> <20030512104408.C24045@mvista.com> <20030513105145.D22288@ftp.linux-mips.org> <20030513095244.B26990@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513095244.B26990@mvista.com>; from jsun@mvista.com on Tue, May 13, 2003 at 09:52:44AM -0700
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2003 at 09:52:44AM -0700, Jun Sun wrote:
[snip]
> I figured that out a while back.  I think you can find answers in
> arch/mips/kernel/setup.c, 
> 
> 	start_pfn = PFN_UP(__pa(&_end));

Strange I read that file many times, but for yet unknown reason never noticed
__pa(&_end). That's what I call selective blindness :)

> I think zero pages are allocated so that all future read-only zero-filled
> pages can be mapped to them.  They are allocated at the beginning of
> start_pfn, which is also after kernel image.

Thanks a lot for explanation, now I'm sure that MC based memory probing for
IP22 will not break anything. Patch will come tomorrow.

	Ladis
