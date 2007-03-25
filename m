Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 02:04:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39137 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022950AbXCYBEx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 02:04:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2P14mWQ000941;
	Sun, 25 Mar 2007 02:04:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2P14l7Y000940;
	Sun, 25 Mar 2007 02:04:47 +0100
Date:	Sun, 25 Mar 2007 02:04:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Implement flush_anon_page().
Message-ID: <20070325010447.GB692@linux-mips.org>
References: <S20022532AbXCWXgp/20070323233645Z+1432@ftp.linux-mips.org> <20070325.001433.108739347.anemo@mba.ocn.ne.jp> <20070324162721.GA12117@linux-mips.org> <20070325.021010.126581514.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070325.021010.126581514.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 25, 2007 at 02:10:10AM +0900, Atsushi Nemoto wrote:

> Thanks.  And one more.  Fix kunmap_coherent() usage.  Or is it a time
> to kill the unused argument of kunmap_coherent()?

Yes, it probably is.  But that sort of cleanup is 2.6.22 stuff.

  Ralf
