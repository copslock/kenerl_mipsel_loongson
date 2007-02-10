Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 10:35:37 +0000 (GMT)
Received: from pentafluge.infradead.org ([213.146.154.40]:34998 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20038938AbXBJKfc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Feb 2007 10:35:32 +0000
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HFpWd-0005St-7l; Sat, 10 Feb 2007 10:32:11 +0000
Subject: Re: -mm merge plans for 2.6.21
From:	David Woodhouse <dwmw2@infradead.org>
To:	Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:	Davide Libenzi <davidel@xmailserver.org>, ralf@linux-mips.org,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org>
	 <1171042535.29713.96.camel@pmac.infradead.org>
	 <20070209134516.2367a7aa.akpm@linux-foundation.org>
	 <1171058342.29713.136.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com>
	 <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date:	Sat, 10 Feb 2007 10:32:07 +0000
Message-Id: <1171103527.29713.228.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+5cffa4984f8ae9ed5307+1266+infradead.org+dwmw2@pentafluge.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips

On Sat, 2007-02-10 at 11:22 +0100, Heiko Carstens wrote:
> Which remembers me that I think that MIPS is using the non-compat version
> of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
> syscall for some reason. Dunno. 

It's OK as long as the 64-bit kernel, N32 and O32 userspace all agree
there there's 32 bits of padding between the fields of this structure:

struct epoll_event {
        __u32 events;
        __u64 data;
};

I suspect it's a fairly safe bet that N32 userspace agrees; if the O32
ABI is different then it would need the compat syscall.

-- 
dwmw2
