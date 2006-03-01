Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 12:36:23 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:41737 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133138AbWCAMgG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 12:36:06 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 61EB064D3D; Wed,  1 Mar 2006 12:43:50 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 06CDF9028; Wed,  1 Mar 2006 13:43:41 +0100 (CET)
Date:	Wed, 1 Mar 2006 12:43:41 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to select a rootfs for embedded linux based hardisk?
Message-ID: <20060301124341.GM24493@deprecation.cyrius.com>
References: <50c9a2250603010418s6f778c25s799d79cee2b79333@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250603010418s6f778c25s799d79cee2b79333@mail.gmail.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* zhuzhenhua <zzh.hust@gmail.com> [2006-03-01 20:18]:
> i want to port the linux to our board based hardisk with
> mips arch. i do not find too much file sytem for rootfs on hardisk
> besides ext2/ext3.
> but it seems ext2/ext3 is not suitable for embedded system.
> does someone have idea or experience with these products?

How large is your hard drive exactly and is it a real IDE hard drive
or some kind of flash?  If the disk/flash is very small, ext3 may be a
bad choice since it's a journalling file system which means that a)
it'll take up quite a significant portion of space on a small drive
and b) it'll write to the same sectors all the time, which will kill
the flash in no time.
-- 
Martin Michlmayr
http://www.cyrius.com/
