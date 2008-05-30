Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 12:34:45 +0100 (BST)
Received: from p549F7A8A.dip.t-dialin.net ([84.159.122.138]:49287 "EHLO
	p549F7A8A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022444AbYE3Lel (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 12:34:41 +0100
Received: from smtp4-g19.free.fr ([212.27.42.30]:6851 "EHLO smtp4-g19.free.fr")
	by lappi.linux-mips.net with ESMTP id S1109564AbYE3L1O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2008 13:27:14 +0200
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 7364A3EA0C5
	for <linux-mips@linux-mips.org>; Fri, 30 May 2008 13:27:13 +0200 (CEST)
Received: from bobafett.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 679433EA0D8
	for <linux-mips@linux-mips.org>; Fri, 30 May 2008 13:27:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 118D62AE6D;
	Fri, 30 May 2008 13:27:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qn1a-cLltw1u; Fri, 30 May 2008 13:27:12 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 25C921CC6C;
	Fri, 30 May 2008 13:27:12 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: kexec on mips - anyone has it working?
Date:	Fri, 30 May 2008 13:27:11 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>,
	openwrt-devel@lists.openwrt.org
References: <483BCB75.4050901@wpkg.org> <200805291347.05196.nschichan@freebox.fr> <483F0EF3.3060500@wpkg.org>
In-Reply-To: <483F0EF3.3060500@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805301327.11925.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
> # kexec -e
> b44: eth0: powering down PHY
> Starting new kernel
> Will call new kernel at 00305000

The calling address of the kernel looks quite wrong, it should clearly
be inside the KSEG0 zone. could  you please indicate the output of the
command "mips-linux-readelf -l vmlinux" ?

Regards,

-- 
Nicolas Schichan
