Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 15:48:58 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:62698 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225203AbVAFPsy>;
	Thu, 6 Jan 2005 15:48:54 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j06Fmr6t023450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Jan 2005 16:48:53 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j06FmqwD023448;
	Thu, 6 Jan 2005 16:48:52 +0100
Date: Thu, 6 Jan 2005 16:48:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] Add 4/8 bytes to 'struct k_sigaction'...
Message-ID: <20050106154852.GA23433@lst.de>
References: <41DCC038.9000307@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCC038.9000307@realitydiluted.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

> --- signal.h	30 Sep 2003 14:27:29 -0000	1.17
> +++ signal.h	6 Jan 2005 04:21:58 -0000
> @@ -135,7 +135,7 @@
> 
>  struct k_sigaction {
>  	struct sigaction sa;
> -#ifdef CONFIG_BINFMT_IRIX
> +#if !defined(CONFIG_CPU_LITTLE_ENDIAN)
>  	void		(*sa_restorer)(void);
>  #endif

#ifdef __mipseb__ maybe?

Is IRIX emulation even working?
