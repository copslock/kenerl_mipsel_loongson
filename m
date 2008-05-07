Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 17:14:37 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:17403 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20022388AbYEGQOe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 17:14:34 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m47GEWMO027659;
	Wed, 7 May 2008 18:14:32 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m47GEMYH027655;
	Wed, 7 May 2008 17:14:32 +0100
Date:	Wed, 7 May 2008 17:14:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix divide by zero error in build_clear_page and
 build_copy_page
In-Reply-To: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
Message-ID: <Pine.LNX.4.55.0805071712520.25644@cliff.in.clinika.pl>
References: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 May 2008, Yoichi Yuasa wrote:

> Fix divide by zero error in build_clear_page() and build_copy_page()

 Why would ever cache_line_size be zero in this place?  Are you trying to 
support a cacheless CPU?  If not, it should be a BUG_ON().

  Maciej
