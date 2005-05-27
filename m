Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 17:43:22 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:20154
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226070AbVE0QnH>; Fri, 27 May 2005 17:43:07 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j4RGfKsc030640;
	Fri, 27 May 2005 17:41:20 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4RGfGv3030639;
	Fri, 27 May 2005 17:41:16 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Porting To New System
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Cameron Cooper <developer@phatlinux.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050527162816.31998.qmail@server256.com>
References: <20050527162816.31998.qmail@server256.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117212073.5730.221.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 27 May 2005 17:41:15 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-05-27 at 17:28, Cameron Cooper wrote:
> So even if this is a bad way of doing it, is it even possable?

It's certainly a good way to get started. Several ports began by using
boot firmware drivers and then eventually replaced them.

Does the firmware give you the ability to control MMU mappings ?
