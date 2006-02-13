Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 22:41:33 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:37637 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBMWlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 22:41:23 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D93B564D3D; Mon, 13 Feb 2006 22:47:40 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0F62A82BB; Mon, 13 Feb 2006 22:47:33 +0000 (GMT)
Date:	Mon, 13 Feb 2006 22:47:33 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Peter 'p2' De Schrijver <p2@mind.be>,
	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060213224733.GA4983@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl> <20060213223951.GA4226@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213223951.GA4226@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-13 22:39]:
>   LD      .tmp_vmlinux1
> arch/mips/kernel/built-in.o: In function `einval':arch/mips/kernel/scall32-o32.S:(.text+0xb6c0): undefined reference to `sys_newfstatat'
> 
> This is with binutils 2.16.1cvs20060117-1 and gcc 4.0.3 20051201.

I see a fix for this just went into Linus' git tree.  Can we have this
in the linux-mips tree too please.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=326a625748535c4cdb1c632b1dcb07030989a393

-- 
Martin Michlmayr
http://www.cyrius.com/
