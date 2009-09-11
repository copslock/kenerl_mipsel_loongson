Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2009 02:14:44 +0200 (CEST)
Received: from are.twiddle.net ([75.149.56.221]:43607 "EHLO are.twiddle.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493028AbZIKAOg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Sep 2009 02:14:36 +0200
Received: from stone.twiddle.home (stone.twiddle.home [172.31.0.16])
	by are.twiddle.net (Postfix) with ESMTPSA id 1CEB6576;
	Thu, 10 Sep 2009 17:14:32 -0700 (PDT)
Message-ID: <4AA99666.4090207@twiddle.net>
Date:	Thu, 10 Sep 2009 17:14:30 -0700
From:	Richard Henderson <rth@twiddle.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux390@de.ibm.com, linux-s390@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com, Kyle McMartin <kyle@mcmartin.ca>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Mike Frysinger <vapier@gentoo.org>,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
 to compiler.h
References: <4AA991C1.1050800@caviumnetworks.com> <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rth@twiddle.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
Precedence: bulk
X-list: linux-mips

On 09/10/2009 04:56 PM, David Daney wrote:
> +#ifndef unreachable
> +# define unreachable() do { for (;;) ; } while (0)
> +#endif

#define unreachable() do { } while (1)


r~
