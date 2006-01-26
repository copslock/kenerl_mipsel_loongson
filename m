Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 19:11:03 +0000 (GMT)
Received: from omx1-ext.sgi.com ([192.48.179.11]:65190 "EHLO
	omx1.americas.sgi.com") by ftp.linux-mips.org with ESMTP
	id S8133710AbWAZTKh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 19:10:37 +0000
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k0QJEOOX008860;
	Thu, 26 Jan 2006 13:14:24 -0600
Received: from v0 (mtv-vpn-hw-masa-1.corp.sgi.com [134.15.25.210])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with SMTP id k0QJUgAP10766216;
	Thu, 26 Jan 2006 11:30:42 -0800 (PST)
Date:	Thu, 26 Jan 2006 11:14:19 -0800
From:	Paul Jackson <pj@sgi.com>
To:	Pavel Machek <pavel@suse.cz>
Cc:	mita@miraclelinux.com, linux-kernel@vger.kernel.org,
	rth@twiddle.net, ink@jurassic.park.msu.ru, rmk@arm.linux.org.uk,
	spyro@f2s.com, dev-etrax@axis.com, dhowells@redhat.com,
	ysato@users.sourceforge.jp, torvalds@osdl.org,
	linux-ia64@vger.kernel.org, takata@linux-m32r.org,
	linux-m68k@vger.kernel.org, gerg@uclinux.org,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, ak@suse.de, chris@zankel.net
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-Id: <20060126111419.54b1cc56.pj@sgi.com>
In-Reply-To: <20060126161426.GA1709@elf.ucw.cz>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125112857.GB18584@miraclelinux.com>
	<20060126161426.GA1709@elf.ucw.cz>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <pj@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pj@sgi.com
Precedence: bulk
X-list: linux-mips

Pavel wrote:
> cpu_set sounds *very* ambiguous. We have thing called cpusets,

Hmmm ... you're right.  I've worked for quite some time on both
of these, and hadn't noticed this similarity before.

Oh well.  Such is the nature of naming things.  Sometimes nice
names resemble other nice names in unexpected ways.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
