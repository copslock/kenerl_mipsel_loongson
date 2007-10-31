Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 13:02:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28384 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025051AbXJaNCT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 13:02:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VD220T014973;
	Wed, 31 Oct 2007 13:02:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VD213v014972;
	Wed, 31 Oct 2007 13:02:01 GMT
Date:	Wed, 31 Oct 2007 13:02:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kaka <share.kt@gmail.com>
Cc:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Re: Unknown Synbol:__make_dp
Message-ID: <20071031130201.GC14187@linux-mips.org>
References: <eea8a9c90710310335mdee2749i2c1758eb6b8f1041@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea8a9c90710310335mdee2749i2c1758eb6b8f1041@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 31, 2007 at 04:05:18PM +0530, kaka wrote:

>  While installing the  linux framebuffer driver by insmod cmd. i am getting
> the above error,
> Unknown Synbol:__make_dp
> 
> Can anybody throw some light on it , kow to remove it?

This is a fp function.  We told you before you cannot use the FPU in the
kernel or all hell will break loose.

  Ralf
