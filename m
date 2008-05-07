Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 23:38:13 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:27923 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022078AbYEGWiK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 23:38:10 +0100
Received: by mo.po.2iij.net (mo30) id m47Mc43M052245; Thu, 8 May 2008 07:38:04 +0900 (JST)
Received: from rally.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id m47MbxbZ022160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 May 2008 07:38:01 +0900
Message-Id: <200805072238.m47MbxbZ022160@po-mbox303.hop.2iij.net>
Date:	Thu, 8 May 2008 07:38:08 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix divide by zero error in build_clear_page and
 build_copy_page
In-Reply-To: <Pine.LNX.4.55.0805071712520.25644@cliff.in.clinika.pl>
References: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
	<Pine.LNX.4.55.0805071712520.25644@cliff.in.clinika.pl>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 7 May 2008 17:14:22 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Wed, 7 May 2008, Yoichi Yuasa wrote:
> 
> > Fix divide by zero error in build_clear_page() and build_copy_page()
> 
>  Why would ever cache_line_size be zero in this place?  Are you trying to 
> support a cacheless CPU?  If not, it should be a BUG_ON().
> 

When CPU has no prefetch, no cache cdex_s and no caache cdex_p, cache_line_size is zero.
I confirmed it with Nevada(Cobalt server) and VR41xx.

Yoichi
