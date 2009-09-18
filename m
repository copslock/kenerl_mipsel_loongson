Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 15:48:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47514 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493191AbZIRNsN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Sep 2009 15:48:13 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8IDnM4w014017;
	Fri, 18 Sep 2009 15:49:22 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8IDnMMG014016;
	Fri, 18 Sep 2009 15:49:22 +0200
Date:	Fri, 18 Sep 2009 15:49:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Huang Weiyi <weiyi.huang@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: remove duplicated #include
Message-ID: <20090918134922.GB13602@linux-mips.org>
References: <1253258075-3088-1-git-send-email-weiyi.huang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253258075-3088-1-git-send-email-weiyi.huang@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 18, 2009 at 03:14:35PM +0800, Huang Weiyi wrote:
> From: Huang Weiyi <weiyi.huang@gmail.com>
> Date: Fri, 18 Sep 2009 15:14:35 +0800
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org, Huang Weiyi <weiyi.huang@gmail.com>
> Subject: [PATCH 2/2] MIPS: remove duplicated #include
> 
> Remove duplicated #include('s) in
>   arch/mips/kernel/smp.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Applied.  Thanks,

  Ralf
